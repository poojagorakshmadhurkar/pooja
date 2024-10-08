*** Settings ***
Library  SeleniumLibrary

Resource  ./variables.robot
Library  String
Library  Collections
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ../../variables.robot
Resource  ./variables.robot
Library  DateTime
Resource  ../../inventory/warehouses/keywords.robot

*** Keywords ***

open order tracker page
    click  ${planningDropdown}
    sleep  2
    click  ${salesorderoption}
    sleep  2

Create SO
    [Arguments]  ${customername}  ${itemData1}
    Open Order Tracker Page
    click  ${newSO}
    Wait Until Page Contains Element    //span[text()="Add New SO"]    timeout=10s
    Select Customer    ${customername}[0]
    ${randomrefNumber}=    Generate Random String    5-10    [NUMBERS]
    Input    ${refNumber}    ${randomrefNumber}
    Delivery Date Entry
    set ith item in so  0  ${itemData1}[0]  ${itemData1}[1]
    click  ${submit}
    sleep  2
    ${order_info}    Get Text    xpath=//div[contains(@style, 'text-align: center;')]
    ${start_index}    Evaluate    "${order_info}".find("Order ") + len("Order ")
    ${end_index}    Evaluate    "${order_info}".find(" has been created!")
    ${order_number}    Evaluate    "${order_info}"[${start_index}:${end_index}]
    click  ${createNewOrder}
    click  ${backbutton}
    search Sonumber in SoListpage for validation  ${order_number}
    wait until page contains element  //a[text()="${order_number}"]/../../../../../../../../../../td[2][text()="${randomrefNumber}"]/../td[3][text()="${customername}[0]"]  timeout=30s
    RETURN  ${order_number}



Cross-checking so under the same po
    [Arguments]  ${i}
    click  //tbody/tr[${i}]/th/span/a

create WO on specified machine
    [Arguments]  ${machineName}  ${scheduleType}
    click  (//div[text() = "${machineName}"]/..)/button[1]
    select option from dropdown  //span[text() = "Schedule"]/../../div[2]  //span[text() = "${scheduleType}"]/../..
    ${randomWoValue}=  generate random string  1  [NUMBERS]
    input  ${woQuantity}  ${randomWoValue}
    click  ${previewWo}

    click  ${Create}
    click  ${mrnRequest}


select customer
    [Arguments]  ${customer}
    input  ${customerDropdown}  ${customer}
    click  //span[text() = "${customer}"]

select machinesSo
    [Arguments]  ${machinename}
    input  ${SomachinesDropdwon}  ${machinename}
    click  //span[text() = "${machinename}"]

select ShiftsSo
    [Arguments]  ${shiftname}
    input  ${shiftSo}  ${shiftname}
    click  //span[text() = "${shiftname}"]

select salesorder
    [Arguments]  ${SOorderno}
    input  ${salesorderproductiondropdown}  ${SOorderno}
    click  //span[text() = "${SOorderno}"]


delivery date entry
    sleep  1
    ${today1}    Get Current Date  result_format=%d-%m-%Y
#    ${today1}=    Evaluate    datetime.datetime.now().strftime('%d-%m-%Y')
#    Log To Console    Current Date: ${today1}
#    BuiltIn.Sleep    1
    click  //span[text() = "Delivery Date *"]/../../div[2]/div/input
    click  //a[text()="Today"]
#    input  //span[text() = "Delivery Date *"]/../../div[2]/div/input  ${today1}
#    sleep  2
#    press keys  //span[text() = "Delivery Date *"]/../../div[2]/div/input  ENTER
#    sleep  1


set ith item in SO
    [Arguments]  ${i}  ${recievedName}  ${recievedQuantity}
    press keys  //input[@id="so_details_${i}_sku"]/../../span[2]  CTRL+A  BACKSPACE  ${recievedName}
    Sleep  1
    Wait Until Page Contains Element  //*[text() = "${recievedName}"]  20
    press keys  //input[@id="so_details_${i}_sku"]  ENTER
    sleep  1
    press keys    //input[@id="$so_details${i}_quantity"]  CTRL+A  BACKSPACE  ${recievedQuantity}
    sleep  1

search Sonumber in SoListpage for validation
    [Arguments]  ${soordernumber}
    wait until element is visible  //h5[text()="sales orders"]  timeout=30s
    click  //h5[text()="sales orders"]
    Wait Until Element Is Not Visible    css=.ant-spin-spinning    timeout=30s
    Wait Until Element Is Clickable  ${SOdetailsFilter}  timeout=30s
    sleep  2
    click element  ${SOdetailsFilter}
    sleep  1
    click  ${Soinputfield}
    press keys  ${Soinputfield}  CTRL+A  BACKSPACE
    input  ${Soinputfield}  ${soordernumber}
    press keys  ${Soinputfield}  ENTER
    sleep  1


Extract SO ListPage ColumnDetails
    [Arguments]    ${so_columnxpath}
    ${so_details}    Create List
    ${elements}    Get WebElements    ${so_columnxpath}
    FOR    ${element}    IN    @{elements}
        ${detail_text}    Get Text    ${element}
        Append To List    ${so_details}    ${detail_text}
    END
    RETURN    ${so_details}

Verify Sorting Functionality
    [Arguments]    ${so_details}
    [Documentation]    Verifies if the SO details are sorted correctly.
    Collections.Sort List    ${so_details}
    ${sorted_details}    Convert To List    ${so_details}
    Should Be Equal As Strings    ${so_details}    ${sorted_details}
    Log    So Details column is sorted correctly.

Create SO with multiple items
    [Arguments]  ${customername}  ${itemData1}  ${itemData2}  ${itemData3}
    Open Order Tracker Page
    click  ${newSO}
    Wait Until Page Contains Element    //span[text()="Add New SO"]    timeout=10s
    Select Customer    ${customername}[0]
    ${randomrefNumber}=    Generate Random String    5-10    [NUMBERS]
    Input    ${refNumber}    ${randomrefNumber}
    Delivery Date Entry
    set ith item in so  0  ${itemData1}[0]  ${itemData1}[1]
    set ith item in so  1  ${itemData2}[0]  ${itemData2}[1]
    set ith item in so  2  ${itemData3}[0]  ${itemData3}[1]
    click  ${submit}
    sleep  2
    ${order_info}    Get Text    xpath=//div[contains(@style, 'text-align: center;')]
    ${start_index}    Evaluate    "${order_info}".find("Order ") + len("Order ")
    ${end_index}    Evaluate    "${order_info}".find(" has been created!")
    ${order_number}    Evaluate    "${order_info}"[${start_index}:${end_index}]
    click  ${createNewOrder}
    click  ${backbutton}
    search Sonumber in SoListpage for validation  ${order_number}
    wait until page contains element  //a[text()="${order_number}"]/../../../../../../../../../../td[2][text()="${randomrefNumber}"]/../td[3][text()="${customername}[0]"]  timeout=30s
    RETURN  ${order_number}


Expand And FetchItems from BOM
    [Arguments]    ${itemData1}  ${itemxpath}
    Click    //span[@aria-label="Expand All"]
    Click    //a[text()="${itemData1}[0]"]
    ${handles}=    Get Window Handles
    Switch Window    ${handles}[1]
    Sleep    2
    Click    //button[@class='ant-switch ant-switch-small'][@role='switch']
    ${item_elements}=    Get WebElements    ${itemxpath}
    ${items}=    Create List
    FOR    ${element}    IN    @{item_elements}
        ${text}=    Get Text    ${element}
        ${lines}=    Split String    ${text}    \n
        ${desired_text}=    Set Variable    ${lines}[0]
        Append To List    ${items}    ${desired_text}
    END
    ${item1}=    Get From List    ${items}    0
    ${item2}=    Get From List    ${items}    1
    ${item3}=    Get From List    ${items}    2
    SeleniumLibrary.Switch Window    ${handles}[0]
    RETURN    ${item1}    ${item2}    ${item3}

Input Date Into Field
    [Arguments]    ${date}
    Click Element    xpath=//input[@placeholder='Select date']
    Input Text    xpath=//input[@placeholder='Select date']    ${date}
    Press Keys    xpath=//input[@placeholder='Select date']  ENTER

date entryproduction
    sleep  1
    ${today1}    Get Current Date  result_format=%d-%m-%Y
#    ${today1}=    Evaluate    datetime.datetime.now().strftime('%d-%m-%Y')
#    Log To Console    Current Date: ${today1}
#    BuiltIn.Sleep    1
    click  ${dateentryproduction}
    input  ${dateentryproduction}  ${today1}
    sleep  1
    press keys  ${dateentryproduction}  ENTER
    sleep  1

open production Dropown
     click  ${productiondropdown}
     sleep  2
     click  ${productionreportdropown}
     sleep  2




Set Items And Quantities
    [Arguments]    ${items}    ${quantities}
    FOR    ${index}    IN RANGE    ${items.__len__()}  # Loop through each item
        Select Item And Set Quantity    ${items[${index}]}    ${quantities[${index}]}
    END

Select Item And Set Quantity
    [Arguments]    ${item}    ${quantity}
    Click Element    //div[contains(@class, 'ant-select') and contains(@class, 'ant-select-single') and contains(@class, 'ant-select-allow-clear')]
    Click Element    //span[text()='${item}']
    Input Text    //input[@type='number' and @class='ant-input']    ${quantity}

set ith item in productionForm
    [Arguments]  ${i}  ${recievedName}  ${recievedQuantity}
    press keys  //input[@id="production_sku_${i}"]/../../span[2]  CTRL+A  BACKSPACE  ${recievedName}
    Sleep  2
#    Wait Until Page Contains Element  //*[text() = "${recievedName}"]  20
    press keys  //input[@id="production_sku_${i}"]  ENTER
    sleep  1
    press keys    //input[@id="production_qty_${i}"]  CTRL+A  BACKSPACE  ${recievedQuantity}
    sleep  1

rejectionprodform
    [Arguments]    ${i}  ${rejectioreason}    ${rejectionquantity}
    press keys  //th[text()="${rejectioreason}"]/../../../tbody//td[${i}]//input[@inputprops="[object Object]"]  ${rejectionquantity}  ENTER

search rejectedquantity in warehouse summary view
    [Arguments]  ${itemName}
    Wait Until Element Is Not Visible    css=.ant-spin-spinning    timeout=30s
    Wait Until Element Is Visible  ${rejectedsearchfilter}  timeout=10s
    click  ${rejectedsearchfilter}
    click  ${rejectedfilterinput}
    Wait Until Element Is Visible  ${rejectedfilterinput}  timeout=10s
    press keys  ${rejectedfilterinput}  CTRL+A  BACKSPACE
    input  ${rejectedfilterinput}  ${itemName}
    press keys  ${rejectedfilterinput}  ENTER
    wait until page contains element  //span[text() = "${itemName}"]  20

search rejectedquantity in warehouse detailed view
    [Arguments]  ${itemName}  ${machine}  ${reason}
    Wait Until Element Is Not Visible    css=.ant-spin-spinning    timeout=30s
    click  //button[text()="Detailed View"]
    Wait Until Element Is Visible  ${rejectedsearchfilter}  timeout=10s
    click  ${rejectedsearchfilter}
    click  ${rejectedfilterinput}
    Wait Until Element Is Visible  ${rejectedfilterinput}  timeout=10s
    press keys  ${rejectedfilterinput}  CTRL+A  BACKSPACE
    input  ${rejectedfilterinput}  ${itemName}
    press keys  ${rejectedfilterinput}  ENTER
    wait until page contains element  //span[text() = "${itemName}"]  20
    sleep  2
    click  (//*[name()='svg'][@id='live_inventory_Machines_search'])[2]
    click  (//input[@id='rc_select_1'])[1]
    Wait Until Element Is Visible  (//input[@id='rc_select_1'])[1]  timeout=10s
    press keys  (//input[@id='rc_select_1'])[1]  CTRL+A  BACKSPACE
    input  (//input[@id='rc_select_1'])[1]  ${machine}
    Press Keys  (//input[@id='rc_select_1'])[1]  ARROW_DOWN  ENTER
    Sleep  1
    click  (//*[name()='svg'][@id='live_inventory_Machines_search'])[3]
    sleep  1
    Execute JavaScript  document.evaluate("(//div[@class='ant-table-body'])[2]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollLeft = document.evaluate("(//div[@class='ant-table-body'])[2]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollWidth;
#    Drag And Drop By Offset  (//div[@class='ant-table-body'])[2]  100  0
    click  ${rejectedreasonfiltersearchbar}
    click  ${rejectedreasoninputsearch}
    Wait Until Element Is Visible  ${rejectedreasoninputsearch}  timeout=10s
    press keys  ${rejectedreasoninputsearch}  CTRL+A  BACKSPACE
    input  ${rejectedreasoninputsearch}  ${reason}
    Press Keys  ${rejectedreasoninputsearch}  ARROW_DOWN  ENTER
    Sleep  1
    click  (//*[name()='svg'][@id='live_inventory_Rejection Reason_search'])[3]
    sleep  1



rejected current quantity of summary view
    [Arguments]  ${itemName}
    search rejectedquantity in warehouse summary view  ${itemName}
#    scroll element into view  (//span[text() = "${itemName}"])[1]
    ${quantityS}  Get Text  (//span[text() = "${itemName}"]/ancestor::tr/td[5])[2]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    RETURN  ${integer_value}
    reload page


rejected current quantity of detailed view
    [Arguments]  ${itemName}  ${machine}  ${reason}
    click  //button[text()="Detailed View"]
    search rejectedquantity in warehouse detailed view  ${itemName}  ${machine}  ${reason}
    ${quantityS}  Get Text  (//span[text()="${itemName}"])[5]/../../../../../../../../../td[9]
#    ${quantityS}  Get Text  (//tr[@class="ant-table-measure-row"])[2]/../tr[2]//td[9]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    RETURN  ${integer_value}
    reload page

#Get current Quantity of Booked Stock
#    [Arguments]  ${itemName}
#    search Fg in warehouse  ${itemName}
#    sleep  2
#    #scroll element into view  (//span[text() = "${itemName}"])[1]
#    ${quantityS}  Get Text  (//span[text() = "${itemName}"]/ancestor::tr/td[4])[2]
#    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
#    ${integer_value}  Convert To Integer  ${Quantity_number}
#    RETURN  ${integer_value}
#



Get current Quantity of FG Booked Stock
    [Arguments]  ${itemName}
    search Fg in warehouse  ${itemName}
    sleep  2
    ${quantityS}  Get Text  (//span[text() = "${itemName}"]/ancestor::tr/td[4])[2]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit()) if ''.join(c for c in "${quantityS}" if c.isdigit()) else '0'
    ${integer_value}  Convert To Integer  ${Quantity_number}
    RETURN  ${integer_value}

Get current Quantity of Rawmaterail Booked Stock
    [Arguments]  ${itemName}
    search rawmaterailname in warehouse  ${itemName}
    sleep  2
    ${quantityS}  Get Text  //span[text() = "${itemName}"]/ancestor::tr/td[4]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit()) if ''.join(c for c in "${quantityS}" if c.isdigit()) else '0'
    ${integer_value}  Convert To Integer  ${Quantity_number}
    RETURN  ${integer_value}

Get current Quantity of WIP Booked Stock
    [Arguments]  ${itemName}
    search WIPname in warehouse  ${itemName}
    sleep  2
    ${quantityS}  Get Text  (//span[text() = "${itemName}"]/ancestor::tr/td[4])[2]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit()) if ''.join(c for c in "${quantityS}" if c.isdigit()) else '0'
    ${integer_value}  Convert To Integer  ${Quantity_number}
    RETURN  ${integer_value}






Book Quantity If OnHand Greater Than Ordered
    [Arguments]    ${item_name}
    ${ORDERED_QUANTITY_XPATH}    Set Variable    //td[.//span[contains(text(),"${item_name}")]]/following-sibling::td[1]
    ${ON_HAND_QUANTITY_XPATH}    Set Variable    //td[.//span[contains(text(),"${item_name}")]]/following-sibling::td[3]
    ${BOOKED_QUANTITY_INPUT_XPATH}    Set Variable    //td[.//span[contains(text(),"${item_name}")]]/following-sibling::td[4]//input

    # Extract the on-hand quantity and ordered quantity
    ${ordered_quantity_text}    Get Text    ${ORDERED_QUANTITY_XPATH}
    ${onhand_quantity_text}    Get Text    ${ON_HAND_QUANTITY_XPATH}

    # Log the quantities for debugging purposes
    Log    Ordered quantity: ${ordered_quantity_text}
    Log    On-hand quantity: ${onhand_quantity_text}

    # Extract numerical values using Evaluate
    ${ordered_quantity}    Evaluate    "${ordered_quantity_text.split(' ')[0] if ' ' in '${ordered_quantity_text}' else '${ordered_quantity_text}'}"
    ${onhand_quantity}    Evaluate    "${onhand_quantity_text.split(' ')[0] if ' ' in '${onhand_quantity_text}' else '${onhand_quantity_text}'}"

    # Convert quantities to integers
    ${ordered_quantity}    Convert To Integer    ${ordered_quantity}
    ${onhand_quantity}    Convert To Integer    ${onhand_quantity}

    # Compare quantities and handle accordingly
    Run Keyword If    ${onhand_quantity} >= ${ordered_quantity}    Input Booked Quantity    ${BOOKED_QUANTITY_INPUT_XPATH}    ${ordered_quantity}
    ...    ELSE    Fail    On-hand quantity (${onhand_quantity}) is less than ordered quantity (${ordered_quantity}).

Input Booked Quantity
    [Arguments]    ${xpath}    ${quantity}
    # Input the quantity in the booked quantity field
    Input Text    ${xpath}    ${quantity}
    Log    Booked quantity input: ${quantity}