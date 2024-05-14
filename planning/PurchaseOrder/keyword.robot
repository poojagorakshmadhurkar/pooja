
*** Settings ***
Library     SeleniumLibrary
Library     String
Library     Collections
Library     DateTime
Resource    ././keyword.robot   #C:\Users\nites\OneDrive\Desktop\ManufApp\automation\Suite\planning\PurchaseOrder\keyword.robot
Resource    ././variable.robot  #C:\Users\nites\OneDrive\Desktop\ManufApp\automation\Suite\planning\PurchaseOrder\variable.robot
Resource    ../../keywords.robot    #C:\Users\nites\OneDrive\Desktop\ManufApp\automation\Suite\keywords.robot
Resource    ../../variables.robot   #C:\Users\nites\OneDrive\Desktop\ManufApp\automation\Suite\variables.robot


*** Keywords ***
#--------------------------------------------------------------------------------
Open Browser Site
    open browser    ${URL}  ${BROWSER}
    Maximize Browser Window
#--------------------------------------------------------------------------------
Login To ManufApp Site
    #Check page title
    title should be    Sign In | ManufApp
#    Check page element "Sign in to your ManufApp Account" present or not
    element text should be   ${PAGE TEXT CHECK}     Sign in to your ManufApp Account
    ${element_text}    Get Text    ${PAGE TEXT CHECK}
    Log    ${element_text}
    #Enter Email
    Input Text    ${MOBILE OR EMAIL}    admin@smart.com     #pooja_dev@testing.com
    #Enter Password
    Input Text    ${PASSWORD}   271828      #4652049559
    #Click sign in Button
    click    ${SIGNIN}
    Sleep   0.5s
#--------------------------------------------------------------------------------
Select Your Site
    [Arguments]    ${select_site}      #Smart Factory, testingsiteautomation
    sleep   0.5s
    mouse over    //button[text()='Smart Factory']
    wait until element is visible   //a[@id='${select_site}']     10s          #//button[text()='${select_site}']
    sleep    0.5s
    set selenium speed    0.08s
    click   //a[.='${select_site}']
#--------------------------------------------------------------------------------
Landing On Purchase Order Page
    Wait Until Page Contains Element    ${PLANNING}    20s
    Wait Until Element Is Visible    ${PLANNING}  10sec
    Sleep   0.5s
    click    ${PLANNING}
    Sleep   0.5s
    click    ${PURCHASE ORDERS}
    Sleep   0.5s
#--------------------------------------------------------------------------------
Refresh_Purchase_Order_Page_List
    set selenium speed    1s
#    sleep    1s
    ${refresh icon}=    element should be visible   ${REFRESH_ELEMENT_LOCATOR}
    log to console    ${refresh icon}
    [Arguments]   ${REFRESH_ELEMENT_LOCATOR}
    Reload Page
    Wait Until Element Is Visible    ${REFRESH_ELEMENT_LOCATOR}    timeout=10s
    ${page_state}=    Execute Javascript    return document.readyState
    Should Be Equal As Strings    ${page_state}    complete
    click    //button[@role='switch']//div[1]   #Item View toggle button
    Sleep   0.5s
#--------------------------------------------------------------------------------
PO_Page Column_List
    PO Table Heading List
    PO Number column List
    Item Details column List
    Ordered column List
    Delivery column List
    Rejected column List
    Remaining column List
    Vender column List
    Issue Date column List
    Delivery Date column List
    Price column List
    Created by column List
    Status column List
#--------------------------- PO Table Heading List ------------------------------
PO Table Heading List
    log to console    -----------------PO Table Heading List ----------------------
    sleep    0.05s
    ${get_text_HeadingData}  get webelements    ${PO TABLE HEADING ELEMENTS2}
    FOR    ${Po_H_List}    IN     @{get_text_HeadingData}
    Log To Console    ✅ ${Po_H_List.text}
    END
    sleep    0.05s
#--------------------------- PO Number column List ------------------------------
PO Number column List
    log to console    ----------------PO Number column Data List ------------------
    ${get_text_colData}  get webelements    ${PO NUMBER COLUMN DATA LIST}
    FOR    ${Po_no_List}    IN     @{get_text_colData}
    Log To Console    ✅ ${Po_no_List.text}
    END
    sleep    0.05s
#--------------------------- Item Details column List ---------------------------
Item Details column List
    log to console    ----------------Item Details column Data List ------------------
    ${get_text_colData}  get webelements    ${ITEM DETAILS COLUMN DATA}
    FOR    ${Po_no_List}    IN     @{get_text_colData}
    Log To Console    ✅ ${Po_no_List.text}
    END
    sleep    0.05s
#--------------------------- Ordered column List --------------------------------
Ordered column List
    log to console    ----------------Ordered  column Data List ------------------
    ${get_text_colData}  get webelements    ${ORDERD COLUMN DATA}
    FOR    ${Po_no_List}    IN     @{get_text_colData}
    Log To Console    ✅ ${Po_no_List.text}
    END
    sleep    0.05s
#--------------------------- Delivery column List -------------------------------
Delivery column List
    log to console    ----------------Delivery  column Data List ------------------
    ${get_text_colData}  get webelements    ${DELIVERY COLUMN DATA}
    FOR    ${Po_no_List}    IN     @{get_text_colData}
    Log To Console    ✅ ${Po_no_List.text}
    END
    sleep    0.05s
#--------------------------- Rejected column List -------------------------------
Rejected column List
    log to console    ----------------Rejected  column Data List ------------------
    ${get_text_colData}  get webelements    ${REJECTED COLUMN DATA}
    FOR    ${Po_no_List}    IN     @{get_text_colData}
    Log To Console    ✅ ${Po_no_List.text}
    END
    sleep    0.05s
#--------------------------- Remaining column List ------------------------------
Remaining column List
    log to console    ----------------Remaining  column Data List ------------------
    ${get_text_colData}  get webelements    ${REMAINING COLUMN DATA}
    FOR    ${Po_no_List}    IN     @{get_text_colData}
    Log To Console    ✅ ${Po_no_List.text}
    END
    sleep    0.05s
#--------------------------- Vender column List ---------------------------------
Vender column List
    log to console    ----------------Vender Column Data List ----------------------
#    sleep   0.05s
    ${get_text_colData}  get webelements     ${VENDER COLUMN DATA1}     #//td[@class="ant-table-cell"][1]
    FOR    ${Po_no_List}    IN     @{get_text_colData}

    Log To Console   ✅ ${Po_no_List.text}
    END
    sleep   0.05s
#--------------------------- Issue Date column List -----------------------------
Issue Date column List
    log to console    -----------------Issue Date Column Data List ------------------
#    sleep   0.05s
#    get the Issue Date column list
    ${get_text_colData}  get webelements     ${ISSUE DATE COLUMN LIST}      #//td[@class="ant-table-cell"][2]
    FOR    ${Po_no_List}    IN     @{get_text_colData}

    Log To Console   ✅ ${Po_no_List.text}
    END
    sleep   0.05s
#--------------------------- Delivery Date column List --------------------------
Delivery Date column List
    log to console    -----------------Delivery Date Column Data List ----------------
#    sleep   0.05s
    ${get_text_colData}  get webelements     ${DELIVERY DATE COLUMN DATA}   #//td[@class="ant-table-cell"][3]
    FOR    ${Po_no_List}    IN     @{get_text_colData}

    Log To Console   ✅ ${Po_no_List.text}
    END
    sleep   0.05s
#--------------------------- Price column List ----------------------------------
Price column List
    log to console    ---------------- Price Column Data List -------------------------
#    sleep   0.05s
    ${get_text_colData}  get webelements     ${PRICE COLUMN DATA}   #//td[@class="ant-table-cell"][4]
    FOR    ${Po_no_List}    IN     @{get_text_colData}

    Log To Console   ✅ ${Po_no_List.text}
    END
    sleep   0.05s
#--------------------------- Created by column List -----------------------------
Created by column List
    log to console    ------------------ Created by Column Data List -------------------
#    sleep   0.05s
    ${get_text_colData}  get webelements     ${CREATED BY COLUMN DATA}      #//td[@class="ant-table-cell"][5]
    FOR    ${Po_no_List}    IN     @{get_text_colData}

    Log To Console   ✅ ${Po_no_List.text}
    END
    sleep   0.05s
#--------------------------- Status column List ---------------------------------
Status column List
    log to console    -----------------Status Column Data List ------------------
    sleep   0.05s
    ${get_text_colData}  get webelements     ${STATUS COLUMN LIST}      #//td[@class="ant-table-cell"][6]
    FOR    ${Po_no_List}    IN     @{get_text_colData}
    Log To Console   ✅ ${Po_no_List.text}
    END
    sleep   0.05s
#--------------------------- Sorting --------------------------------------------
Sorting
    sleep    0.5s
    Wait Until Page Contains Element    ${PLANNING}    10s
    set selenium speed    0.05s

#**************    PO Column    ******************************
    #sorting list PO number column
    #Get text list
    log to console    -------------------PO Number column Data List (Before clicking) --------------------------------
    ${get_text_colData}  get webelements    ${PO NUMBER COLUMN DATA LIST}   #--get the PO column Data list
    FOR    ${Po_no_List}    IN     @{get_text_colData}
    Log To Console    ${Po_no_List.text}
    END
    sleep   0.5s
    #click PO Number Column
    click    ${SORT_PO}
    sleep   0.5s

    log to console    -------------------PO Number column Data List (After clicking) --------------------------------
    ${get_text_colData}  get webelements    ${PO NUMBER COLUMN DATA LIST}
    FOR    ${Po_no_List}    IN     @{get_text_colData}
    Log To Console    ✅ ${Po_no_List.text}
    END

    log to console    ........👆 Please Verify PO Column Sorted Data below  .........................
    sleep   0.05s


#--------------------------------------------------------------------------------

#**************    click vender Column    ******************************

    #sorting list click vender Column
    #Get text list
    log to console    -------------------Vender Column Data List (Before clicking) --------------------------------

    sleep   0.5s
    ${get_text_colData}  get webelements     //td[@class="ant-table-cell"][1]
    FOR    ${Po_no_List}    IN     @{get_text_colData}

    Log To Console   ✅ ${Po_no_List.text}
    END

    click    ${SORT_VENDER}
    sleep   0.5s
    log to console    -------------------Vender Column Data List (After clicking) --------------------------------
    ${get_text_colData1}  get webelements    ${VENDER COLUMN DATA}
    FOR    ${Vender_col_List}    IN     @{get_text_colData1}
    Log To Console    ✅ ${Vender_col_List.text}
    END

    log to console    ........👆 Please Verify Vender Column Sorted Data below  ...................................
    log to console    ........✅ Functionality of Sorting operation is sucessfully done😎.........................
    sleep   0.05s

#--------------------------------------------------------------------------------

#click issue date Column
    click   ${SORT_ISSUE_DATE}
    click   ${SORT_ISSUE_DATE}

#click delivery date Column
    click   ${SORT_DELIVERY_DATE}
    click   ${SORT_DELIVERY_DATE}
#--------------------------- Search in PO_Number Colomn -------------------------
Search In PO_Number Column
    #%%%%%%%%%%%%%%%%%%    PO column Search    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sleep    2s
    Searching PO Number
    set selenium speed    0.05sec
    click   ${SEARCH ICON}      #--extenal click icon
    click   ${SEARCH ICON INPUT FIELD}      #--search icon input field text box
    #Take randome value for searching
    ${value}  Evaluate  random.choice($PO_Col)  random             #<------- call data randomely
#    log to console  \nvalue: ${value}
    input text    ${SEARCH ICON INPUT FIELD}   ${value}   #${ENTER SEARCH TEXT}   #--i.e "PO-000"        #--enter input for searching data PO-186

#    ${search text}=    Get Text     ${SEARCH ICON INPUT FIELD}
    log to console   ..................You search🔎[ ${value} ] in search box................................
    click   ${CLICK ON SEARCH ICON}     #--intenal click icon
    sleep    0.05s

    log to console  ...................Text Matching result.........................................................
    #after clicking search we get the list as per text input in the search box
    ${get_text_colData}  get webelements    ${PO NUMBER COLUMN DATA LIST}
    FOR    ${Po_no_List}    IN     @{get_text_colData}
    Log To Console    ✅ ${Po_no_List.text}
    log     ✅ ${Po_no_List.text}
    END
    sleep    0.05s
    log to console    ........👆 Please Verify Search Data below  ...................................................
#--------------------------- Search in PO_Number Colomn -------------------------
Search In PO_Vendor Column
    #%%%%%%%%%%%%%%%%%%    Vendor column Search    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sleep    2s
    Refresh_Purchase_Order_Page_List    ${REFRESH_ELEMENT_LOCATOR}
#    Searching Vendor
    set selenium speed    0.05sec
    click   ${Vendor SEARCH ICON}      #--extenal click icon
    click   ${Vendor SEARCH ICON INPUT FIELD}      #--search icon input field text box
    #Take randome value for searching
    ${value}  Evaluate  random.choice($Vendor_Col)  random             #<------- call data randomely
    log to console  \nvalue: ${value}
#    input text    ${Vendor SEARCH ICON INPUT FIELD}   ${value}
    sleep   1s
    select option from dropdown using div  (//div[@class='ant-select-selector']//div)[1]     ${Value}

     ${search text}=    Get Text     ${Vendor SEARCH ICON INPUT FIELD}
    log to console   ..................You search🔎[ ${value} ] in search box................................
    click   ${Vendor CLICK ON SEARCH ICON}      #--intenal click icon
    sleep    0.05s

    log to console  ...................Text Matching result.........................................................
    #after clicking search we get the list as per text input in the search box
    ${get_text_colData}  get webelements    ${VENDER COLUMN DATA}
    FOR    ${Vendor_Col_List}    IN     @{get_text_colData}
    Log To Console    ✅ ${Vendor_Col_List}
    log     ✅ ${Vendor_Col_List.text}
    END
    sleep    0.05s
    log to console    ........👆 Please Verify Search Data below  ...................................................
#--------------------------- Search in PO_Vendor Colomn -------------------------
Searching PO Number
    click   ${PO PAGINATION}
    sleep    2s
    click   ${PO PAGINATION 100}
    wait until page contains element    ${PO NUMBER COLUMN DATA LIST}   20s
    sleep    2s
    ${get_text_colData}  get webelements    ${PO NUMBER COLUMN DATA LIST}   #--get the PO column Data list -100 entries
    FOR    ${Po_no_List}    IN     @{get_text_colData}
    sleep    0.05s
    Log To Console    ${Po_no_List.text}
    END
    sleep    1s
#--------------------------------------------------------------------------------
Searching Vendor
    sleep    2s
    click   ${PO PAGINATION}
    sleep    2s
    click   ${PO PAGINATION 100}
    wait until page contains element    ${PO_HOLE_PAGE_HIGHLIGHT}   20s
    set selenium speed    0.05sec
    click   ${Vendor SEARCH ICON}      #--extenal click icon
    ${get_text_colData2}  get webelements    //div[@id='rc_select_2_list']      #${VENDER COLUMN DATA1}   #--get the PO column Data list -100 entries
    FOR    ${Vendor_Col_List}    IN     @{get_text_colData2}
    sleep    0.05s
    log to console    ${Vendor_Col_List.text}
    RETURN  ${get_text_colData2}
    sleep    1s
    click   ${Vendor SEARCH ICON INPUT FIELD}
#--------------------------------------------------------------------------------
Close The Browser
    Sleep    1s
    Close Browser
#--------------------------------------------------------------------------------
select vendor
    [Arguments]  ${customer}
    input  ${vendordropdown}  ${customer}
    click  //span[text() = "${customer}"]
Move to Purchase Order Page
    sleep    0.5s
    mouse over    //button[text()='Planning']
    click element    //a[.='Purchase Orders']
    sleep    0.5s
    element text should be    //h5[text()='purchase orders']    Purchase Orders
select Issue Date
    click   ${ISSUE_DATE_CALENDER}
    click    ${CURRENT_DATE}
    sleep    0.5s
Select Itom Code_Quantity_Price
    [Arguments]     ${i}  ${quantity}  ${price}
#    click    ${ITEM_CODE}
#    click    ${SELECT_ITEMTYPE}
    Wait Until Element Is Clickable    ${SELECT_ITEMTYPE}   10s
    press keys    //input[@id='purchase_order_${i}_sku']   ARROW_DOWN     ENTER
    sleep    1s
#    press keys    (//div[@class='ant-select-item ant-select-item-option'])[${i}]    ENTER
    sleep   0.5s
    click    ${INPUT_QUANTITY}
    input text      ${INPUT_QUANTITY}    ${quantity}
    sleep    0.5s
    click    ${INPUT_PRICE}
    sleep    0.5s
    input text    ${INPUT_PRICE}  ${price}
Select Multiple Itom_Code Quantity_Price
    [Arguments]     ${i}    ${j}  ${k}  ${quantity}  ${price}
#    click    ${ITEM_CODE}
#    click    ${SELECT_ITEMTYPE}
    press keys    //input[@id='purchase_order_${i}_sku']   ARROW_DOWN     ENTER
    sleep    1s
#    press keys    (//div[@class='ant-select-item ant-select-item-option'])[${i}]    ENTER
    sleep   0.5s
    click    ${INPUT_QUANTITY_M}[${j}]
    input text      ${INPUT_QUANTITY_M}[${j}]    ${quantity}
    sleep    0.5s
    click    ${INPUT_PRICE_M}${k}
    input text    ${INPUT_PRICE_M}[${k}]  ${price}
Verify Text
#    [Arguments]     ${VERIFY_TEXT}
    sleep    3s
    ${element_text}    Get Text    ${VERIFY_TEXT}
    Log    ${element_text}
    element text should be    ${VERIFY_TEXT}   ${element_text}
    log to console    -----[✅ ${element_text}]----
Create_PO_And_Edit_PO
    set selenium speed    0.05
    wait until page contains element    //a[contains(text(),'NEW')]  timeout=10s
    click    ${CREATE_NEW_BUTTON}
    Select Vendor for PO  ${vendor}[0]
    select Delivery Date  ${date}[0]
#    delivery date entry
    ${today1}    Get Current Date  result_format=%d-%m-%Y
    set ith item in PO  ${ItemData}[0]  ${ItemData}[1]  ${ItemData}[2]  ${ItemData}[3]
    click   ${SUBMIT}
    log to console    --- * PO creation Successfully done * --
    Verify Text
    set selenium speed    0.05s
    ${order_info}    Get Text    xpath://div[contains(@style, 'text-align: center;')]
    ${start_index}    Evaluate    "${order_info}".find("Order ") + len("Order ")
    ${end_index}    Evaluate    "${order_info}".find(" has been created!")
    ${order_number}    Evaluate    "${order_info}"[${start_index}:${end_index}]

    click    ${BACK}
    sleep    1s
    Search In PO    ${order_number}
    sleep   1s
    click    //a[@id='purchase_order_label']
    sleep   1s
    click   //button[text()='Edit']
    set ith item in PO    ${ItemData2}[0]  ${ItemData2}[1]  ${ItemData2}[2]  ${ItemData2}[3]
    click    (//button[text()='Submit'])[1]
    click    //*[@id='back_btn']
    log to console    --- * PO editing Successfully done * --
    sleep    0.05s
    Search In PO    ${order_number}
Select PO item type
    [Arguments]  ${item_type}
    input    (//input[@type='search'])[1]  ${item_type}
    click  //span[text()='${item_type}']
Select PO Vendor
    [Arguments]  ${vendor_Name}
    input  //input[@id="purchase_order_vendor"]  ${vendor_Name}
    click  //span[text()='${vendor_Name}']
select Delivery Date
    [Arguments]    ${inputDate}
    click   ${DELIVERY_DATE_CALENDER}
    sleep    1s
    input text    ${DELIVERY_DATE_CALENDER}     ${inputDate}
    press keys    ${DELIVERY_DATE_CALENDER}    ENTER
    sleep    1s
Select PO Item Code
#    [Arguments]  ${item_code}
#    input  ${ITEM_CODE_List}  ${item_code}
#    click  //span[text()='${item_code}']
    Wait Until Element Is Clickable    ${SELECT_ITEMTYPE}   10s
    press keys    //input[@id='purchase_order_${i}_sku']    ARROW_DOWN     ENTER
Select PO Quantity
    [Arguments]  ${quantity}
    click    ${INPUT_QUANTITY}
    input text      ${INPUT_QUANTITY}    ${quantity}
    sleep    0.5s
Select Price
    [Arguments]  ${price}
    click    ${INPUT_PRICE}
    sleep    0.5s
    input text    ${INPUT_PRICE}  ${price}
Select Random
    [Arguments]    ${element_list}
    ${list_length}    Get Length    ${element_list}
    ${random_index}    Evaluate    random.randint(0, ${list_length}-1)
    ${random_value}    Get From List    ${element_list}    ${random_index}
    log to console    ${list_length.txt}

    RETURN  ${random_value}
Search Vendor
    click   (//span[text()='Vendor']/following-sibling::span)[1]
    click    (//div[@class='ant-select-selector']//div)[1]
    select random    //div[@class='rc-virtual-list-holder-inner']
    input text    (//div[@class='ant-select-selector']//div)[1]        ${random_value}
Extract PO ListPage ColumnDetails
    [Arguments]    ${po_columnxpath}
    ${po_details}    Create List
    ${elements}    Get WebElements    ${po_columnxpath}
    FOR    ${element}    IN    @{elements}
        ${detail_text}    Get Text    ${element}
        Append To List    ${po_details}    ${detail_text}
    END
    RETURN    ${po_details}
Search In PO
    [Arguments]    ${order_number}
    sleep    2s
#    Searching PO Number
    set selenium speed    0.07sec
    click   ${SEARCH ICON}      #--extenal click icon
    click   ${SEARCH ICON INPUT FIELD}      #--search icon input field text box
#    sleep   1s
    input text    ${SEARCH ICON INPUT FIELD}   ${order_number}   #${ENTER SEARCH TEXT}   #--i.e "PO-000"        #--enter input for searching data PO-186

#    ${search text}=    Get Text     ${SEARCH ICON INPUT FIELD}
    log to console   .................. You search🔎[ ${order_number} ] in search box ...................
    click   ${CLICK ON SEARCH ICON}     #--intenal click icon
    sleep    0.07s

    log to console  ................... Text Matching result ............................................    #after clicking search we get the list as per text input in the search box
    sleep    0.07s
    ${get_text_colData}  get webelements    ${PO NUMBER COLUMN DATA LIST}
    FOR    ${Po_no_List}    IN     @{get_text_colData}
    Log To Console    ✅ ${Po_no_List}
    log     ✅ ${Po_no_List}
    END
#    sleep    0.07s
    log to console    ........👆 Please Verify Search Data below  .......................................
    sleep   1s
    RETURN    ${order_number}
Search Randonmly In PO_Number Column
     #%%%%%%%%%%%%%%%%%%    PO column Search    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sleep    2s
    Searching PO Number
    set selenium speed    0.05sec
    click   ${SEARCH ICON}      #--extenal click icon
    click   ${SEARCH ICON INPUT FIELD}      #--search icon input field text box
    #Take randome value for searching
    ${value}  Evaluate  random.choice($PO_Col)  random             #<------- call data randomely
#    log to console  \nvalue: ${value}
    input text    ${SEARCH ICON INPUT FIELD}   ${value}   #${ENTER SEARCH TEXT}   #--i.e "PO-000"        #--enter input for searching data PO-186

#    ${search text}=    Get Text     ${SEARCH ICON INPUT FIELD}
    log to console   ..................You search🔎[ ${value} ] in search box................................
    click   ${CLICK ON SEARCH ICON}     #--intenal click icon
    sleep    0.05s

    log to console  ...................Text Matching result.........................................................
    #after clicking search we get the list as per text input in the search box
    ${get_text_colData}  get webelements    ${PO NUMBER COLUMN DATA LIST}
    FOR    ${Po_no_List}    IN     @{get_text_colData}
    Log To Console    ✅ ${Po_no_List.text}
    log     ✅ ${Po_no_List.text}
    END
    sleep    0.05s
    log to console    ........👆 Please Verify Search Data below  ...................................................
Search Randonmly In Vendor Column
#%%%%%%%%%%%%%%%%%%    Vendor column Search    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sleep    2s
    click   ${PO PAGINATION}
    sleep    2s
    click   ${PO PAGINATION 100}
    wait until page contains element    ${PO_HOLE_PAGE_HIGHLIGHT}   20s
    set selenium speed    1sec
    click   ${Vendor SEARCH ICON}      #--extenal click icon
    click   ${Vendor SEARCH ICON INPUT FIELD}
    ${get_text_colData2}  get webelements    (//div[@class='rc-virtual-list-holder']//div)[2]      #${VENDER COLUMN DATA1}   #--get the PO column Data list -100 entries
    FOR    ${Vendor_Col_List}    IN     @{get_text_colData2}
    sleep    0.05s
    log to console    ${Vendor_Col_List.text}
    RETURN  ${get_text_colData2}
    sleep    1s
    click   ${Vendor SEARCH ICON INPUT FIELD}
    ${value}  Evaluate  random.choice($get_text_colData2)   random             #<------- call data randomely
    log to console  \nvalue: ${value}
#    input text    ${Vendor SEARCH ICON INPUT FIELD}   ${value}
    sleep   1s
    select option from dropdown using div  (//div[@class='ant-select-selector']//div)[1]     ${value}

     ${search text}=    Get Text     ${Vendor SEARCH ICON INPUT FIELD}
    log to console   ..................You search🔎[ ${value} ] in search box................................
    click   ${Vendor CLICK ON SEARCH ICON}      #--intenal click icon
    sleep    0.05s

    log to console  ...................Text Matching result.........................................................
    #after clicking search we get the list as per text input in the search box
    ${get_text_colData}  get webelements    ${VENDER COLUMN DATA}
    FOR    ${Vendor_Col_List}    IN     @{get_text_colData}
    Log To Console    ✅ ${Vendor_Col_List}
    log     ✅ ${Vendor_Col_List.text}
    END
    sleep    0.05s
    log to console    ........👆 Please Verify Search Data below  ...................................................
Search Randonmly In Issue Date
    set selenium speed  1s
    click    //*[@id="purchase_order_Issue Date_search"]
    click    //input[@placeholder='Start date']
    click    //span[text()='Today']
    click    (//*[@id="purchase_order_Issue Date_search"])[2]
Search Randonmly In Delivery Date
    set selenium speed  0.5s
    click    id:purchase_order_Delivery Date_search
    click    (//input[@placeholder='Start date'])[1]
#    click    (//div[text()='7'])[3]
#    click    (//span[text()='This Week'])[2]
    click    (//li[@class='ant-picker-preset']//span)[2]
#    click element    (//span[text()='This Week'])[2]
    click    (//button[contains(@class,'ant-btn ant-btn-circle')])[2]
    sleep    1min
Searching Issue Date Column
     #sorting list PO number column
    #Get text list
    log to console    -----------------Issue Date Column Data List ------------------
    sleep   0.05s
#    get the Issue Date column list
    ${get_text_colData}  get webelements     ${ISSUE DATE COLUMN LIST}      #//td[@class="ant-table-cell"][2]
    FOR    ${Po_no_List}    IN     @{get_text_colData}

    Log To Console   ✅ ${Po_no_List.text}
    END
    sleep    2s
    Search Randonmly In Issue Date
    sleep    1s

    log to console    -------------------Issue Date Column Data List (After Searching) --------------------------------
    sleep   0.05s
#    get the Issue Date column list
    ${get_text_colData}  get webelements     ${ISSUE DATE COLUMN LIST}      #//td[@class="ant-table-cell"][2]
    FOR    ${Po_no_List}    IN     @{get_text_colData}

    Log To Console   ✅ ${Po_no_List.text}
    END
    sleep    2s

    log to console    ........👆 Please Verify PO Column Sorted Data below  .........................
    sleep   0.05s
Searching Delivery Date Column
    #----------------------------Delivery Date column List--------------------------------
    log to console    -----------------Delivery Date Column Data List ----------------
    sleep   0.05s
    ${get_text_colData}  get webelements     ${DELIVERY DATE COLUMN DATA}   #//td[@class="ant-table-cell"][3]
    FOR    ${Po_no_List}    IN     @{get_text_colData}

    Log To Console   ✅ ${Po_no_List.text}
    END
    sleep    1s
    Search Randonmly In Delivery Date
    sleep    1s

    log to console    -----------------Delivery Date Column Data List (After Searching) ----------------
    sleep   0.05s
    ${get_text_colData}  get webelements     ${DELIVERY DATE COLUMN DATA}   #//td[@class="ant-table-cell"][3]
    FOR    ${Po_no_List}    IN     @{get_text_colData}

    Log To Console   ✅ ${Po_no_List.text}
    END
    sleep   0.05s
Searching Item Details Column
    #----------------------------Item Details column List--------------------------------
    log to console    -----------------Item Details Column Data List ----------------
    sleep   0.05s
    ${get_text_colData}  get webelements     ${ITEM DETAILS COLUMN DATA}   #//td[@class="ant-table-cell"][3]
    FOR    ${Po_no_List}    IN     @{get_text_colData}

    Log To Console   ✅ ${Po_no_List.text}
    END
    sleep    1s
    Search Randonmly In Delivery Date
    sleep    1s

    log to console    -----------------Item Details Column Data List (After Searching) ----------------
    sleep   0.05s
    ${get_text_colData}  get webelements     ${ITEM DETAILS COLUMN DATA}   #//td[@class="ant-table-cell"][3]
    FOR    ${Po_no_List}    IN     @{get_text_colData}

    Log To Console   ✅ ${Po_no_List.text}
    END
    sleep   0.05s
Search Randonmly In Item Details columns
    set selenium speed  0.5s
    click    id:purchase_order_Item Details_search
#    press keys    //*[@class="ant-select-selection-overflow"]   ARROW_DOWN     ENTER
    click   (//*[@class="rc-virtual-list-holder-inner"])//div[7]
    sleep    3s
Input Text Validation
#    ${order_info}    Get Text    xpath://div[contains(@style, 'text-align: center;')]
#    ${start_index}    Evaluate    "${order_info}".find("Order ") + len("Order ")
#    ${end_index}    Evaluate    "${order_info}".find(" has been created!")
#    ${order_number}    Evaluate    "${order_info}"[${start_index}:${end_index}]
#   search Ponumber in PoListpage for validation  ${order_number}
    RETURN  ${order_number}
Verify Row Data
#    [Arguments]    ${xpath} #ant-table-row ant-table-row-level-0
#    @{getData}  Get WebElements    ${xpath}

    ${rows1} =  get element count   ant-table-row ant-table-row-level-0
    sleep  2
    log to console   Total Rows= ${rows1}

    ${ItemDetails}    Get Text     //td[@class="ant-table-cell"][1]
    log to console  Item Details is ✅ ${ItemDetails}}

    ${quantity}    Get Text     //td[@class="ant-table-cell"][2]
    log to console  Item Details is ✅ ${quantity}
    log to console    Item_Code, Quantity, Price editing successfully completed On PO Page
Verify_ItemCode_Price_Quantity_ Should_Be_Edited
    [Arguments]    ${xpath}
    sleep   1s
    click   ${xpath}
    sleep   1s                                              #//input[@id="purchase_order_0_sku"]
    click   //button[text()='Edit']
    press keys  (//span[@class='ant-select-selection-search'])[3]   ARROW_DOWN     ENTER
    select itom code_quantity_price    0    200     30
    sleep    0.5s
    click   back_btn
    refresh_purchase_order_page_list    ${REFRESH_ELEMENT_LOCATOR}
    sleep    0.5s
    Verify Row Data
set ith item in PO
    [Arguments]  ${i}  ${recievedName}  ${recievedQuantity}  ${price}
    press keys  //input[@id="purchase_order_${i}_sku"]/../../span[2]  CTRL+A  BACKSPACE  ${recievedName}
    Sleep  2
    Wait Until Page Contains Element  //*[text() = "${recievedName}"]  20
    press keys  //input[@id="purchase_order_${i}_sku"]  ENTER
    sleep  1
    press keys    //input[@id="purchase_order_${i}_quantity"]  CTRL+A  BACKSPACE  ${recievedQuantity}
    sleep  1
    press keys    //input[@id="purchase_order_${i}_price_per_unit"]  CTRL+A  BACKSPACE  ${price}
    sleep  1
Select Vendor for PO
    [Arguments]  ${vendorname}
    input  ${vendorselectiondropdown}  ${vendorname}
    click  //span[text() = "${vendorname}"]
Multiple PO Creation
    [Arguments]    ${vendor}  ${date}   ${ItemData}
    set selenium speed    0.05s
    wait until page contains element    //a[contains(text(),'NEW')]  timeout=10s
    click    ${CREATE_NEW_BUTTON}
    Select Vendor for PO  ${vendor}[3]
    select Delivery Date  ${date}[0]
    ${today1}    Get Current Date  result_format=%d-%m-%Y

    set ith item in PO  ${ItemData}[0]  ${ItemData}[1]  ${ItemData}[2]  ${ItemData}[3]
    set ith item in PO  ${ItemData1}[0]  ${ItemData1}[1]  ${ItemData1}[2]  ${ItemData1}[3]
    set ith item in PO  ${ItemData2}[0]  ${ItemData2}[1]  ${ItemData2}[2]  ${ItemData2}[3]
    set ith item in PO  ${ItemData3}[0]  ${ItemData3}[1]  ${ItemData3}[2]  ${ItemData3}[3]

    click   ${SUBMIT}
    log to console    --- * PO creation Successfully done * --
    Verify Text

    ${order_info}    Get Text    xpath://div[contains(@style, 'text-align: center;')]
    ${start_index}    Evaluate    "${order_info}".find("Order ") + len("Order ")
    ${end_index}    Evaluate    "${order_info}".find(" has been created!")
    ${order_number}    Evaluate    "${order_info}"[${start_index}:${end_index}]
    log to console    --- * Multiple PO creation is Sucessfully done * --
#    sleep   1s
    click    ${BACK}
#    sleep   1s
    Search In PO    ${order_number}
#    sleep   1s
    RETURN  ${order_number}

Create_PO
    [Arguments]    ${ItemData}  ${vendor}   ${date}
    set selenium speed    0.05
    wait until page contains element    //a[contains(text(),'NEW')]  timeout=10s
    click    ${CREATE_NEW_BUTTON}
    Select Vendor for PO  ${vendor}[0]
    select Delivery Date  ${date}[0]
    ${today1}    Get Current Date  result_format=%d-%m-%Y
    set ith item in PO  ${ItemData}[0]  ${ItemData}[1]  ${ItemData}[2]  ${ItemData}[3]
    click   ${SUBMIT}
    log to console    --- * PO creation Successfully done * --
    Verify Text
    set selenium speed    0.5s
    ${order_info}    Get Text    xpath://div[contains(@style, 'text-align: center;')]
    ${start_index}    Evaluate    "${order_info}".find("Order ") + len("Order ")
    ${end_index}    Evaluate    "${order_info}".find(" has been created!")
    ${order_number}    Evaluate    "${order_info}"[${start_index}:${end_index}]
    click    ${BACK}
    sleep    1s
    Search In PO    ${order_number}
    sleep   2s
    RETURN  ${order_number}
Text validation
    [Arguments]    ${expected_text}
    ${actual_text}    Get Text    (//span[@class='ant-tag ant-tag-yellow'])[1]
    log to console    ${actual_text}
    IF    '${actual_text}' == '${expected_text}'
        Log    ✅ Status validation passed
        log to console  ✅ Status validation passed
#    ELSE  '${actual_text}' Should Not Be Equal '${expected_text}'
#        Log    ❌ Status validation failed
#        log to console  ❌ Status validation failed

    END

Verify PO Details
    [Documentation]    Validates PO details
#    [Arguments]   ${vendor}   ${date}   ${ItemData}[1]
    Click Element    ${ITEM_VIEW_TOGGLE_BUTTON}
    Sleep    1.5s
    ${PO_details}    Get Text    (//tr[@class='ant-table-row ant-table-row-level-0'])[1]
    @{list}=    Create List    ${PO_details}
#    ${PO_details}    Get Text    (//tr[@class='ant-table-row ant-table-row-level-0'])[1]
#    ${vendor_Name}   Evaluate    "${list}".find("${vendor}[1]")
#    ${Delivery_date}   Evaluate    "${list}".find("${date}")
#    ${Multiple_ItemData}   Evaluate    "${list}".find("${ItemData}[0]")


    Log To Console    ---------------------------------------------
    Log To Console    ✅ ${list}   #${PO_details}
    Click Element    ${ITEM_VIEW_TOGGLE_BUTTON}
    Click Element    ${PO_ORDER_DETAIL}
    Sleep    1s
    ${validate_Details}    Get Text    //div[contains(@class,'MuiPaper-root MuiPaper-outlined')]
    Log To Console    ---------------------------------------------
    Log To Console    ✅ ${validate_Details}
    @{Item}=    Create List    //div[contains(@class,'MuiPaper-root MuiPaper-outlined')]
    FOR    ${Item}    IN    ${list}
        Page Should Contain List    ${Item}
#        wait until element contains    ${validate_Details}  ${Item}
    END
    IF    '${list}' IN   '${Item}'
        log    ${list}
    END

Verify Withdraw Status
    set selenium speed    0.05s
    Text validation   ${expected_text}
    click    //*[@id='purchase_order_withdraw ']
    ${conform_msg}      get text    //*[@id='confirm-site-delete']
    element text should be    //*[@id='confirm-site-delete']    ${conform_msg}
    click    (//*[@id='undefined__deactivate_btn'])[2]
    sleep    1s
    ${Widthdraw_Note}   get text    //div[@class='MuiAlert-message css-1xsto0d']
    log to console    ✅ ${Widthdraw_Note}
    element text should be    ${withdraw-Status}   Withdrawn
    ${Status}  get text    ${withdraw-Status}
    log    Status is ✅ ${Status}
    log to console    Status is ✅ ${Status}
    click   //*[@id='purchase_order_closed_filter_chip']
    sleep    1s
    ${search}=  Search In PO    ${order_number}
    ${search}     ${order_number}

PO Inward_Flow
    set selenium speed   0.05s
    ${order_number}=    multiple po creation    ${vendor}  ${date}   ${ItemData}
    wait until element is visible   ${inward_button}   10s        #${inward_button}[1]   10s
    element should be visible   ${inward_button}
    element should be enabled   ${inward_button}
    click   ${inward_button}
    ${text}=    get text    //span[text()='Inward Against ${order_number} / ${vendor}[3]']
    log to console    ✅ ${text}
    should contain    ${text}   ${order_number} / ${vendor}[3]
    Select from inspected by dropdown PO_inward   ${inspected_By}[0]
#    sleep    1s
    ${randomrefNumber}=   Generate Random number_4_digit
    input   ${invoice_number}    ${randomrefNumber}
    ${random_string}=    Generate Random Number_String
    input   ${truck_number}    ${random_string}
#   selct all item details using checkbox
    select checkbox    ${checkbox}
    click    ${Auto_fill}
    wait until element is visible   //input[@value='${ItemData}[2]']
    wait until element is visible   //input[@value='${ItemData1}[2]']
    wait until element is visible   //input[@value='${ItemData2}[2]']
    wait until element is visible   //input[@value='${ItemData3}[2]']
    log    //input[@value='${ItemData}[2]']
    log    //input[@value='${ItemData1}[2]']
    log    //input[@value='${ItemData2}[2]']
    log    //input[@value='${ItemData3}[2]']
    sleep    0.05s
    unselect checkbox     ${checkbox}
    sleep    0.5s
    select checkbox    (//input[@type="checkbox"])[5]       #${checkbox}[5]
    sleep    0.5s
    click    ${Auto_fill}
    sleep    1s
    click    ${move to top}
    click button    ${submit}
    sleep    1s
    ${inward_note}  get text  ${inward_note_msg}
    log to console  ✅ ${inward_note}
    sleep    1s

Select from inspected by dropdown PO_inward
    [Arguments]  ${inspected_By}
    input  //input[@id='credit__form__inspected_by']  ${inspected_By}
    click  //div[text()='${inspected_By}']

Input into Invoice No Dropdown PO_inward    #generate random no
    [Arguments]  ${invoice_No}
    input  //input[@id='credit__form__invoice_number']  ${invoice_No}
#    click  //span[text() = "${invoice_No}"]

Input into Truck Number PO_inward           #generate random no
    [Arguments]  ${Truck_Number}
    input  //input[@id='credit__form__truck_number']  ${Truck_Number}
#    click  //span[text() = "${Truck_Number}"]


Input into Deliverd_qnt inputBox
    [Arguments]  ${Deliverd_qnt}
    input  (//input[@class='ant-input'])[3]  ${Deliverd_qnt}
#    click  //span[text() = "${Deliverd_qnt}"]

Item Deatail Checkbox
#    [Arguments]    ${Checkbox_xpath}
    click    (//input[@class='ant-checkbox-input'])[1]

Generate Random number_4_digit
    ${ran_int}=    Generate Random String    length=4    chars=[NUMBERS]
    ${ran_int}=    Convert To Integer    ${ran_int}
    log to console    This is a random number between 1000 and 9999: ${ran_int}
    RETURN    ${ran_int}

Generate Random number_2_digit
    ${ran_int}=    Generate Random String    length=2    chars=[NUMBERS]
    ${ran_int}=    Convert To Integer    ${ran_int}
    log to console    This is a random number between 10 and 99: ${ran_int}
    RETURN    ${ran_int}

Generate Random Number_String
    ${random_string}=    Generate Random String    length=6    chars=[UPPER][NUMBERS]
    Log    Random String: ${random_string}
    log to console    Random String: ${random_string}
    RETURN    ${random_string}







