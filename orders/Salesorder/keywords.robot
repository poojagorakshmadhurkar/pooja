*** Settings ***
#Library  SeleniumLibrary
Resource  ./variables.robot
Library  String
Library  Collections
#Library  SeleniumLibrary
Resource  ../../keywords.robot
#Resource  ../../variables.robot
#Resource  ./variables.robot
Library  DateTime
Resource  ../../inventory/warehouses/keywords.robot
Library    Browser

*** Keywords ***
open order tracker page
    browser.click  ${planningDropdown}
    sleep   1
    browser.click  ${salesorderoption}

Create SO
    [Arguments]  ${customername}  ${itemData1}
    sleep  1
    Open Order Tracker Page
    sleep  1
    browser.click  ${newSO}
    Wait For Elements State        //span[text()="Add New SO"]   visible    timeout=60s
    Select Customer   ${customername}[0]
    ${randomrefNumber}=    Generate Random String    5-10    [NUMBERS]
    Input    ${refNumber}    ${randomrefNumber}
    Delivery Date Entry
    set ith item in so  0  ${itemData1}[0]  ${itemData1}[1]
    sleep  2
    browser.click  ${submit}
    ${order_info}    browser.Get Text    xpath=//div[contains(@style, 'text-align: center;')]
    ${start_index}    Evaluate    "${order_info}".find("Order ") + len("Order ")
    ${end_index}    Evaluate    "${order_info}".find(" has been created!")
    ${order_number}    Evaluate    "${order_info}"[${start_index}:${end_index}]
    browser.click  ${createNewOrder}
    browser.click  ${backbutton}
    search Sonumber in SoListpage for validation  ${order_number}
    Wait For Elements State      //a[text()="${order_number}"]/../../../../../../../../../../td[2][text()="${randomrefNumber}"]/../td[3][text()="${customername}[0]"]   visible   timeout=60s
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
    browser.click  //span[text() = "${customer}"]

select machinesSo
    [Arguments]  ${machinename}

    click  (//div[@class='ant-select-selector'])[1]
    input  ${SomachinesDropdwon}  ${machinename}

#    click  (//*[@data-icon="caret-down"])[1]

    click  //span[text() = "${machinename}"]
    sleep  1


select ShiftsSo
    [Arguments]  ${shiftname}
    input  ${shiftSo}  ${shiftname}
    click  (//span[text() = "${shiftname}"])[2]
    Wait For Elements State     (//span[text() = "${shiftname}"])[2]    visible   timeout=60s
    sleep  1

select salesorder
    [Arguments]  ${SOorderno}
    input  ${salesorderproductiondropdown}  ${SOorderno}
    click  //span[text() = "${SOorderno}"]


delivery date entry

    ${today1}    Get Current Date  result_format=%d-%m-%Y
#    ${today1}=    Evaluate    datetime.datetime.now().strftime('%d-%m-%Y')
#    Log To Console    Current Date: ${today1}
#    BuiltIn.Sleep    1
    browser.click  //span[text() = "Delivery Date *"]/../../div[2]/div/input
    browser.click  //a[text()="Today"]
#    input  //span[text() = "Delivery Date *"]/../../div[2]/div/input  ${today1}
#    sleep  2
#    press keys  //span[text() = "Delivery Date *"]/../../div[2]/div/input  ENTER
#    sleep  1


set ith item in SO image validation
    [Arguments]  ${i}  ${recievedName}  ${recievedQuantity}
    browser.press keys  //input[@id="so_details_${i}_sku"]/../../span[2]  Control+A
    browser.press keys  //input[@id="so_details_${i}_sku"]/../../span[2]    Backspace
    fill text  //input[@id="so_details_${i}_sku"]    ${recievedName}
#    Wait For Elements State    css=img.ant-image-img    visible
#    Get Attribute    css=img.ant-image-img    src
#    Wait For Elements State     //*[text() = "${recievedName}"]  visible   timeout=60s
    browser.press keys  //input[@id="so_details_${i}_sku"]  Enter
   sleep   1
#    browser.press keys    //input[@id="$so_details${i}_quantity"]  Control+A
#    browser.press keys    //input[@id="$so_details${i}_quantity"]   Backspace
    input   //input[@id="$so_details${i}_quantity"]    ${recievedQuantity}
#    browser.press keys    //input[@id="$so_details${i}_quantity"]   Enter
     browser.click   //span[text()="Add New SO"]
     sleep  1



set ith item in SO
    [Arguments]  ${i}  ${recievedName}  ${recievedQuantity}
    sleep  2
    browser.press keys  //input[@id="so_details_${i}_sku"]/../../span[2]  Control+A
    browser.press keys  //input[@id="so_details_${i}_sku"]/../../span[2]    Backspace
    fill text  //input[@id="so_details_${i}_sku"]    ${recievedName}
#    Wait For Elements State     //*[text() = "${recievedName}"]  visible   timeout=60s
    browser.press keys  //input[@id="so_details_${i}_sku"]  Enter
     sleep  2
#    browser.press keys    //input[@id="$so_details${i}_quantity"]  Control+A
#    browser.press keys    //input[@id="$so_details${i}_quantity"]   Backspace
    input   //input[@id="$so_details${i}_quantity"]    ${recievedQuantity}
#    browser.press keys    //input[@id="$so_details${i}_quantity"]   Enter
     browser.click   //span[text()="Add New SO"]
     sleep  2

Edit ith item in SO
    [Arguments]  ${i}  ${recievedName}  ${recievedQuantity}
    sleep   1
    browser.Press Keys    //input[@id="so_details_${i}_sku"]    Control+A
    browser.Press Keys   //input[@id="so_details_${i}_sku"]    Backspace
    sleep   1
    Fill Text      //input[@id="so_details_${i}_sku"]      ${recievedName}
    Press Keys  //input[@id="so_details_${i}_sku"]  Enter
    sleep  1
#    Wait For Elements State    (//span[text()="${newItemName}"])[1]  attached  timeout=60s
#    Browser.Wait For Elements State  //input[@id="credit__details__${i}__quantity"]  visible  timeout=60s
    Press Keys  //input[@id="$so_details${i}_quantity"]   Control+A
    Press Keys  //input[@id="$so_details${i}_quantity"]   Backspace
    sleep  1
    Fill Text     //input[@id="$so_details${i}_quantity"]    ${recievedQuantity}







search Sonumber in SoListpage for validation
    [Arguments]  ${soordernumber}
    Wait For Elements State      //h5[text()="sales orders"]  visible   timeout=60s
    browser.click  //h5[text()="sales orders"]
    Wait For Elements State        css=.ant-spin-spinning   hidden   timeout=60s
    Wait For Elements State      ${SOdetailsFilter}  visible   timeout=30s
    sleep  1
    browser.click   ${SOdetailsFilter}
    browser.click  ${Soinputfield}
    browser.press keys  ${Soinputfield}  Control+A
    browser.press keys  ${Soinputfield}   Backspace
    input  ${Soinputfield}  ${soordernumber}
    browser.press keys  ${Soinputfield}  Enter



Extract SO ListPage ColumnDetails
    [Arguments]    ${so_columnxpath}
    ${so_details}    Create List
    sleep  1
    ${elements}    Get Elements            ${so_columnxpath}
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
    sleep  1
    click  ${newSO}
    Wait For Elements State        //span[text()="Add New SO"]    visible   timeout=60s
    Select Customer    ${customername}[0]
    ${randomrefNumber}=    Generate Random String    5-10    [NUMBERS]
    Input    ${refNumber}    ${randomrefNumber}
    Delivery Date Entry
    set ith item in so  0  ${itemData1}[0]  ${itemData1}[1]
    set ith item in so  1  ${itemData2}[0]  ${itemData2}[1]
    set ith item in so  2  ${itemData3}[0]  ${itemData3}[1]
    click  ${submit}
    ${order_info}    browser.Get Text    xpath=//div[contains(@style, 'text-align: center;')]
    ${start_index}    Evaluate    "${order_info}".find("Order ") + len("Order ")
    ${end_index}    Evaluate    "${order_info}".find(" has been created!")
    ${order_number}    Evaluate    "${order_info}"[${start_index}:${end_index}]
    click  ${createNewOrder}
    click  ${backbutton}
    search Sonumber in SoListpage for validation  ${order_number}
    Wait For Elements State       //a[text()="${order_number}"]/../../../../../../../../../../td[2][text()="${randomrefNumber}"]/../td[3][text()="${customername}[0]"]   visible   timeout=60s
    RETURN  ${order_number}


Expand And FetchItems from BOM
    [Arguments]    ${itemData1}  ${itemxpath}
    Click    //span[@aria-label="Expand All"]
    Click    (//a[text()="${itemData1}[0]"])[1]
    sleep  1
    ${pages}=    Get Page Ids

    Switch Page    ${pages}[0]
    Set Viewport Size    1450    750
    Click    //button[@class='ant-switch ant-switch-small'][@role='switch']
    ${item_elements}=    Get Elements        ${itemxpath}
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
   Switch page        ${pages}[0]
   Set Viewport Size    1450    750
    RETURN    ${item1}    ${item2}    ${item3}

Input Date Into Field
    [Arguments]    ${date}
    Click    xpath=//input[@placeholder='Select date']
    Input Text    xpath=//input[@placeholder='Select date']    ${date}
    Press Keys    xpath=//input[@placeholder='Select date']  Enter

date entryproduction

    ${today1}    Get Current Date  result_format=%d-%m-%Y
#    ${today1}=    Evaluate    datetime.datetime.now().strftime('%d-%m-%Y')
#    Log To Console    Current Date: ${today1}
#    BuiltIn.Sleep    1
    click  ${dateentryproduction}
    input  ${dateentryproduction}  ${today1}
    press keys  ${dateentryproduction}  Enter


open production Dropown
      sleep  1
     click  ${productiondropdown}

     click  ${productionreportdropown}
     Wait For Elements State    //h5[text()='Production Reports']    visible   timeout=60s





Set Items And Quantities
    [Arguments]    ${items}    ${quantities}
    FOR    ${index}    IN RANGE    ${items.__len__()}  # Loop through each item
        Select Item And Set Quantity    ${items[${index}]}    ${quantities[${index}]}
    END

Select Item And Set Quantity
    [Arguments]    ${item}    ${quantity}
    Click    //div[contains(@class, 'ant-select') and contains(@class, 'ant-select-single') and contains(@class, 'ant-select-allow-clear')]
    Click    //span[text()='${item}']
    Input Text    //input[@type='number' and @class='ant-input']    ${quantity}

set ith item in productionForm
    [Arguments]  ${i}  ${recievedName}  ${recievedQuantity}
    press keys  //input[@id="production_sku_${i}"]  Control+A
    press keys  //input[@id="production_sku_${i}"]    Backspace
    fill text  //input[@id="production_sku_${i}"]   ${recievedName}
#    Wait Until Page Contains Element  //*[text() = "${recievedName}"]  20
    press keys  //input[@id="production_sku_${i}"]  Enter

    press keys    //input[@id="production_qty_${i}"]  Control+A
    press keys    //input[@id="production_qty_${i}"]    Backspace
    fill text   //input[@id="production_qty_${i}"]  ${recievedQuantity}

rejectionprodform
    [Arguments]    ${i}  ${rejectioreason}    ${rejectionquantity}
    press keys  //th[text()="${rejectioreason}"]/../../../tbody//td[${i}]//input[@inputprops="[object Object]"]  ${rejectionquantity}  ENTER

search rejectedquantity in warehouse summary view
    [Arguments]  ${itemName}
    Wait For Elements State        css=.ant-spin-spinning    hidden   timeout=60s
    Wait For Elements State      ${rejectedsearchfilter}  visible    timeout=60s
    click  ${rejectedsearchfilter}
    click  ${rejectedfilterinput}
    Wait For Elements State      ${rejectedfilterinput}  visible  timeout=60s
    press keys  ${rejectedfilterinput}  Control+A
    press keys  ${rejectedfilterinput}   Backspace
    input  ${rejectedfilterinput}  ${itemName}
    press keys  ${rejectedfilterinput}  Enter
    Wait For Elements State      //span[text() = "${itemName}"]  visible   timeout=60s

search rejectedquantity in warehouse detailed view
    [Arguments]  ${itemName}  ${machine}  ${reason}
    Wait For Elements State        css=.ant-spin-spinning    hidden    timeout=60s
    click  //button[text()="Detailed View"]
    Wait For Elements State      ${rejectedsearchfilter}  visible   timeout=60s
    click  ${rejectedsearchfilter}
    click  ${rejectedfilterinput}
    Wait For Elements State      ${rejectedsearchfilter}  visible   timeout=60s
    press keys  ${rejectedfilterinput}  Control+A
    press keys  ${rejectedfilterinput}    Backspace
    input  ${rejectedfilterinput}  ${itemName}
    press keys  ${rejectedfilterinput}  Enter
#    Wait For Elements State      //span[text() = "${itemName}"]  visible    timeout=60s
    click  (//*[name()='svg'][@id='live_inventory_Machines_search'])
    click  (//input[@type="search"])[2]
    Wait For Elements State      (//input[@type="search"])[2]  visible   timeout=60s
    press keys  (//input[@type="search"])[2]  Control+A
    press keys  (//input[@type="search"])[2]  Backspace
    input  (//input[@type="search"])[2]  ${machine}
    click   (//span[contains(text(),'${machine}')])[2]
    click  (//*[name()='svg'][@id='live_inventory_Machines_search'])[2]
    sleep  1
#    Evaluate JavaScript    document.evaluate("(//div[contains(@class, 'ant-table-body')])[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollLeft = document.evaluate("(//div[contains(@class, 'ant-table-body')])[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollWidth
    click  ${rejectedreasonfiltersearchbar}
#    click  (//input[@type="search"])[2]
#    Wait For Elements State      (//input[@type="search"])[2]    visible   timeout=60s
#    press keys  (//input[@type="search"])[2]  Control+A
#    press keys  (//input[@type="search"])[2]    Backspace
#     Select Option From Dropdown Using Div       (//div[@class="ant-select-selector"])[4]   ${reason}
    click   (//span[contains(text(),'${reason}')])
    click  (//*[name()='svg'][@id='live_inventory_Rejection Reason_search'])



rejected current quantity of summary view
    [Arguments]  ${itemName}
    search rejectedquantity in warehouse summary view  ${itemName}
#    scroll element into view  (//span[text() = "${itemName}"])[1]
    ${quantityS}  Get Text  (//span[text() = "${itemName}"]/ancestor::tr/td[5])
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    RETURN  ${integer_value}
    Reload


rejected current quantity of detailed view
    [Arguments]  ${itemName}  ${machine}  ${reason}
    click  //button[text()="Detailed View"]
    search rejectedquantity in warehouse detailed view  ${itemName}  ${machine}  ${reason}
    ${quantityS}  Get Text  (//span[text()="${itemName}"])[5]/../../../../../../../../../td[9]
#    ${quantityS}  Get Text  (//tr[@class="ant-table-measure-row"])[2]/../tr[2]//td[9]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit())
    ${integer_value}  Convert To Integer  ${Quantity_number}
    RETURN  ${integer_value}
    Reload

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
    ${quantityS}  Get Text  (//span[text() = "${itemName}"]/ancestor::tr/td[4])
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit()) if ''.join(c for c in "${quantityS}" if c.isdigit()) else '0'
    ${integer_value}  Convert To Integer  ${Quantity_number}
    RETURN  ${integer_value}

Get current Quantity of Rawmaterail Booked Stock
    [Arguments]  ${itemName}
    search rawmaterailname in warehouse  ${itemName}
    ${quantityS}  Get Text  //span[text() = "${itemName}"]/ancestor::tr/td[4]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${quantityS}" if c.isdigit()) if ''.join(c for c in "${quantityS}" if c.isdigit()) else '0'
    ${integer_value}  Convert To Integer  ${Quantity_number}
    RETURN  ${integer_value}

Get current Quantity of WIP Booked Stock
    [Arguments]  ${itemName}
    search WIPname in warehouse  ${itemName}
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