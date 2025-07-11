*** Settings ***
Library   Browser
Library   String
Library   Collections
Library   DateTime
Library   BuiltIn
Resource  ././keyword.robot
Resource  ././variable.robot
Resource  ../../keywords.robot
Resource  ../../variables.robot
Resource  .././Salesorder/keywords.robot
Resource  .././Salesorder/variables.robot

*** Keywords ***
Login To ManufApp Site
    # [Arguments]   ${Email}   ${Pass}
    New Browser    chromium    headless=true  channel=chrome   #firefox    #msedge
    New Page    ${DEVURL}
    Set Viewport Size    1500    730
    Fill Text   ${MOBILE OR EMAIL}   admin@smart.com   #${Email}  #nitish@sandbox.com     #pooja_dev@testing.com
    Fill Text   ${PASSWORD}   271828     #Manufapp2023    #${Pass}     #8824427172   #4652049559
    click   ${SIGNIN}

Login To ManufApp Site2
    # [Arguments]   ${Email}   ${Pass}
    New Browser    chromium    headless=True  channel=chrome
    New Page    ${DEVURL}
    Set Viewport Size    1500    730
    Fill Text   ${MOBILE OR EMAIL}   nitu358@gmail.com     #admin@smart.com   #${Email}  #nitish@sandbox.com     #pooja_dev@testing.com
    Fill Text   ${PASSWORD}   9373941282   #271828     #Manufapp2023    #${Pass}     #8824427172   #4652049559
    click   ${SIGNIN}

Login To Dev Site
    New Browser    chromium    headless=True  channel=chrome
    New Page    ${DEVURL}
    Wait For Elements State   ${MOBILE OR EMAIL}  visible    timeout=30s
    Fill Text   ${MOBILE OR EMAIL}   nitish@sandbox.com   #admin@smart.com   #${Email}  #nitish@sandbox.com     #pooja_dev@testing.com
    Fill Text   ${PASSWORD}   8824427172   #271828    #${Pass}     #8824427172   #4652049559
    click   ${SIGNIN}

Login To Prod Site
    New Browser    chromium    headless=True  channel=chrome
    New Page    ${PRODUCTION}
    Wait For Elements State   ${MOBILE OR EMAIL}  visible    timeout=30s
    Fill Text   ${MOBILE OR EMAIL}   admin@smart.com   #admin@smart.com   #${Email}  #nitish@sandbox.com     #pooja_dev@testing.com
    Fill Text   ${PASSWORD}   Manufapp2023   #271828    #${Pass}     #8824427172   #4652049559
    click   ${SIGNIN}

Select Your Site
    [Arguments]    ${select_id}  ${site_name}
     Hover    //span[text()='${site_name}']      #Smart Factory, testingsiteautomation  Main_Automation_Unit
#    Hover    //span[normalize-space(text())='Smart Factory']
#    Wait For Elements State   //a[normalize-space(text())='${select_site}']    visible    timeout=30s
    Click   (//ul[@id='menu-list-grow']//a)[${select_id}]
    Sleep    3s
#    Hover    //span[text()="Masters"]
#    Click    //a[@id="configuration"]
#    Click    //*[@id="undefined_Name_search"]
#    Fill Text    //*[@placeholder="Search Name"]    Main_Automation_Unit
#    Click    (//*[@id="undefined_Name_search"])[2]
#    Click    (//*[text()="Main_Automation_Unit"])[3]


Landing On Purchase Order Page
    Wait For Elements State   ${ORDERS}   visible    timeout=30s
    click    ${ORDERS}
    Wait For Elements State   ${PURCHASE ORDERS}  visible    timeout=30s
    click    ${PURCHASE ORDERS}
#    Click    //*[contains(text(),'All')]

Refresh_Purchase_Order_Page_List
    [Arguments]   ${REFRESH_ELEMENT_LOCATOR}
    Wait For Elements State   ${REFRESH_ELEMENT_LOCATOR}    visible    timeout=30s
    click   ${ITEM_VIEW_TOGGLE_BUTTON}   #Item View toggle button

PO Table Heading List
    Log To Console    [ PO Table Heading List ]
    Scroll To Element   //*[text()="Status"]
    ${elements}=    Get Elements   ${PO TABLE HEADING ELEMENTS2}
    ${count}=    Get Length    ${elements}
    Log To Console   Number of elements: ${count}
    FOR    ${element}    IN    @{elements}
        ${text1}=    Browser.Get Text    ${element}
        Log To Console  ✅ ${text1}   console=true
    END

PO_Page Column_List
    [Arguments]    ${COLUMN_DATA}   ${Column_Name}
    log to console   [ ${Column_Name} ]
    ${get_text_colData}=   Get Elements    ${COLUMN_DATA}     #${PO NUMBER COLUMN DATA LIST}
    ${count}=    Get Length    ${get_text_colData}
    Log To Console   Number of elements: ${count}
    FOR    ${Po_no_List}    IN     @{get_text_colData}
        ${text2}=    Browser.Get Text    ${Po_no_List}
        Log To Console  ✅ ${text2}   console=true
    END
Sorting
    [Arguments]   ${col_xpath1}   ${sort_Button}   ${col_xpath2}   ${Col_Name}
    #sorting PO page column
    log to console   [ ${Col_Name} column Data List (Before Sorting) ]
    @{get_text_colData}=  Get Elements    ${col_xpath1}   #--get the PO column Data list
    FOR    ${colData_List}   IN   @{get_text_colData}
        ${text2}=    Browser.Get Text    ${colData_List}
    Log To Console   ✅ ${text2}
    log   ✅ ${text2}
    END
    #click on Column
    click   //span[text()='${Col_Name}']
    log to console  [ ${Col_Name} column Data List (After Sorting) ]
    @{get_text_colData}=    Get Elements    ${col_xpath2}
    FOR    ${colData_List}    IN    @{get_text_colData}
        ${text3}=    Browser.Get Text    ${colData_List}
    Log To Console    ✅ ${text3}
    END
    Reload
Search In PO_Number Column
    #%%%%%%%%%%%%%%%%%%    PO column Search    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Searching PO Number
    click   ${SEARCH ICON}      #--extenal click icon
    click   ${SEARCH ICON INPUT FIELD}      #--search icon input field text box
    #Take randome value for searching
    ${value}  Evaluate  random.choice($PO_Col)  random             #<------- call data randomely
    # log to console  \nvalue: ${value}
    Fill Text    ${SEARCH ICON INPUT FIELD}   ${value}   #${ENTER SEARCH TEXT}   #--i.e "PO-000"        #--enter input for searching data PO-186
    # ${search text}=    Browser.Get Text     ${SEARCH ICON INPUT FIELD}
    log to console   ..................You search🔎[ ${value} ] in search box................................
    click   ${CLICK ON SEARCH ICON}     #--intenal click icon
    log to console  ...................Text Matching result.........................................................
    # after clicking search we get the list as per text input in the search box
    ${get_text_colData}  Get Elements    ${PO NUMBER COLUMN DATA LIST}
    FOR    ${Po_no_List}    IN     @{get_text_colData}
               ${text2}=    Browser.Get Text   ${Po_no_List}
               log  ✅ ${text2}
    END
    log to console    ........👆 Please Verify Search Data below  ...................................................

Search In PO_Vendor Column
    #------------ Vendor column Search  --------------
    Refresh_Purchase_Order_Page_List    ${REFRESH_ELEMENT_LOCATOR}
    #  Searching Vendor
    click   ${Vendor SEARCH ICON}      #--extenal click icon
    #  click   ${Vendor SEARCH ICON INPUT FIELD}      #--search icon input field text box
    Browser.Press Keys   ${Vendor SEARCH ICON INPUT FIELD}  ARROW_DOWN     ENTER
    #Take randome value for searching
    ${value}  Evaluate  random.choice($Vendor_Col)  random             #<------- call data randomely
    log to console  \nvalue: ${value}
    select option from dropdown using div  (//div[@class='ant-select-selector']//div)[1]     ${Value}
    ${search text}=    Browser.Get Text     ${Vendor SEARCH ICON INPUT FIELD}
    log to console  You search🔎[ ${value} ] in search box.
    click   ${Vendor CLICK ON SEARCH ICON}      #--intenal click icon
    log to console  Text Matching result.
    #after clicking search we get the list as per text input in the search box
    ${get_text_colData}  Get Elements    ${VENDER COLUMN DATA}
    FOR    ${Vendor_Col_List}    IN     @{get_text_colData}
    Log To Console    ✅ ${Vendor_Col_List}
    log     ✅ ${Vendor_Col_List.text}
    END
    log to console   👆 Please Verify Search Data below

Searching PO Number
    click   ${PO PAGINATION}
    click   ${PO PAGINATION 100}
#    Wait For Elements State   ${PO NUMBER COLUMN DATA LIST}  visible   timeout=30s
    ${get_text_colData}  Get Elements    ${PO NUMBER COLUMN DATA LIST}   #--get the PO column Data list -100 entries
    FOR    ${Po_no_List}    IN     @{get_text_colData}
           ${text2}=    Browser.Get Text   ${Po_no_List}
           log  ✅ ${text2}
    END

Searching Vendor
    sleep    2s
    click   ${PO PAGINATION}
    sleep    2s
    click   ${PO PAGINATION 100}
    Wait For Elements State    ${PO_HOLE_PAGE_HIGHLIGHT}   20s
    click   ${Vendor SEARCH ICON}      #--extenal click icon
    ${get_text_colData2}  Get Elements    //div[@id='rc_select_2_list']      #${VENDER COLUMN DATA1}   #--get the PO column Data list -100 entries
    FOR    ${Vendor_Col_List}    IN     @{get_text_colData2}
    sleep    0.05s
    log to console    ${Vendor_Col_List.text}
    END
    RETURN  ${get_text_colData2}
    sleep    1s
    click   ${Vendor SEARCH ICON INPUT FIELD}

#--------------------------------------------------------------------------------
select vendor
    [Arguments]  ${customer}
    input  ${vendordropdown}  ${customer}
    click  //span[text() = "${customer}"]
select vendor2
    [Arguments]  ${customer}
    input  ${vendorDrpdwn}   ${customer}
#    click   //div[contains(text(),'${customer}')]
    click   (//span[text()="${customer}"])[2]

select option from dropdown by inputting333
    [Arguments]  ${vendorDrpdwn}  ${option}
    input  ${vendorDrpdwn}  ${option}
    Wait For Elements State  //span[text() = "${option}"]  visible  timeout=60
    click  //span[text() = "${option}"]/..

Move to Purchase Order Page
    sleep    0.08s
    Hover     //*[text()="Orders "]
    Click    //a[.='Purchase Orders']
    sleep    0.08s
    Wait For Elements State    //h5[text()='purchase orders']    text=Purchase Orders
select Issue Date
    click   ${ISSUE_DATE_CALENDER}
    click   ${CURRENT_DATE}
    sleep   0.5s

Select Multiple Itom_Code Quantity_Price
    [Arguments]     ${i}    ${j}  ${k}  ${quantity}  ${price}
    Browser.Press Keys    //input[@id='purchase_order_${i}_sku']   ARROW_DOWN     ENTER
    click   ${INPUT_QUANTITY_M}[${j}]
    Fill Text   ${INPUT_QUANTITY_M}[${j}]    ${quantity}
    click   ${INPUT_PRICE_M}${k}
    Fill Text  ${INPUT_PRICE_M}[${k}]  ${price}
Verify Text
    ${element_text}    Browser.Get Text    ${VERIFY_TEXT}
    Log    ${element_text}
    Should Be Equal   ${element_text}   ${VERIFY_TEXT}
    log to console  [✅ ${element_text}]

Create_PO_And_Edit_PO
    Wait For Elements State    //a[contains(text(),'NEW')]  visible  timeout=30s
    click    ${CREATE_NEW_BUTTON}
    sleep   1s
    Select Vendor for PO  ${vendor}[0]
    select Delivery Date
#    delivery date entry
    ${today1}    Get Current Date  result_format=%d-%m-%Y
    set ith item in PO  ${ItemData}[0]  ${ItemData}[1]  ${ItemData}[2]  ${ItemData}[3]  ${ItemData}[4]
    click   ${SUBMIT}
    log to console   * PO creation Successfully done *
    Verify Text
    ${order_info}    Browser.Get Text    xpath://div[contains(@style, 'text-align: center;')]
    ${start_index}    Evaluate    "${order_info}".find("Order ") + len("Order ")
    ${end_index}    Evaluate    "${order_info}".find(" has been created!")
    ${order_number}    Evaluate    "${order_info}"[${start_index}:${end_index}]
    click    ${BACK}
    sleep    1s
    Search In PO    ${order_number}
    sleep   1s
    click    //a[@id='purchase_order_label']
    sleep   1s
    click   //*[@data-icon="edit"]
    click   //button[text()='Edit']
    set ith item in PO    ${ItemData2}[0]  ${ItemData2}[1]  ${ItemData2}[2]  ${ItemData2}[3]    ${ItemData2}[4]
    click    (//button[text()='Submit'])[1]
    click    //*[@id='back_btn']
#    click   back_btn
    Wait For Elements State   (//span[text()='DoorItem'])[1]   20s
    Wait For Elements State   //td[text()="15 g"]   20s
    Wait For Elements State   //*[contains(text(),'₹120.00')]   20s
    sleep   1s
    click   back_btn
    sleep   1s
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
    click   ${DELIVERY_DATE_CALENDER}
    sleep    1s
    click    (//a[contains(text(),'Today')])[1]

Select PO Item Code
    Wait Until Element Is Clickable    ${SELECT_ITEMTYPE}   30s
    Browser.Press Keys    //input[@id='purchase_order_${i}_sku']    ARROW_DOWN     ENTER
Select PO Quantity
    [Arguments]  ${quantity}
    click    ${INPUT_QUANTITY}
    Fill Text      ${INPUT_QUANTITY}    ${quantity}
    sleep    0.5s
Select Price
    [Arguments]  ${price}
    click    ${INPUT_PRICE}
    sleep    0.5s
    Fill Text    ${INPUT_PRICE}  ${price}
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
    Fill Text    (//div[@class='ant-select-selector']//div)[1]   ${random_value}
Extract PO ListPage ColumnDetails
    [Arguments]    ${po_columnxpath}
    ${po_details}    Create List
    ${elements}    Get Elements    ${po_columnxpath}
    FOR    ${element}    IN    @{elements}
        ${detail_text}    Browser.Get Text    ${element}
        Append To List    ${po_details}    ${detail_text}
    END
    RETURN    ${po_details}
Search In PO
    [Arguments]    ${order_number}
#    Searching PO Number
    click   ${SEARCH ICON}      #--extenal click icon
    click   ${SEARCH ICON INPUT FIELD}      #--search icon input field text box
    Fill Text    ${SEARCH ICON INPUT FIELD}   ${order_number}   #${ENTER SEARCH TEXT}   #--i.e "PO-000"        #--enter input for searching data PO-186
#    ${search text}=    Browser.Get Text     ${SEARCH ICON INPUT FIELD}
    log to console   You search🔎[ ${order_number} ] in search box
    log   You search🔎[ ${order_number} ] in search box
    click   ${CLICK ON SEARCH ICON}     #--intenal click icon
    log to console  Text Matching result     #after clicking search we get the list as per text input in the search box
    ${get_text_colData}  Get Elements    ${PO NUMBER COLUMN DATA LIST}
    Sleep   3s
    FOR   ${Po_no_List1}    IN    @{get_text_colData}
        Sleep  2s
        ${text3}=    Browser.Get Text    ${Po_no_List1}
    Log To Console   ✅ ${text3}
    END
    log  ✅ ${text3}
    log to console   👆 Please Verify Search Data below
    RETURN    ${order_number}
Search Randomly In PO_Number Column
    #------------  PO column Search  --------------------
    Searching PO Number
    click   ${SEARCH ICON}      #--extenal click icon
    click   ${SEARCH ICON INPUT FIELD}      #--search icon input field text box
    #Take randome value for searching
    ${value}  Evaluate  random.choice($PO_Col)  random             #<------- call data randomely
#    log to console  \nvalue: ${value}
    Fill Text    ${SEARCH ICON INPUT FIELD}   ${value}   #${ENTER SEARCH TEXT}   #--i.e "PO-000"        #--enter input for searching data PO-186
#    ${search text}=    Browser.Get Text     ${SEARCH ICON INPUT FIELD}
    log to console   You search🔎[ ${value} ] in search box.
    click   ${CLICK ON SEARCH ICON}     #--intenal click icon
    log to console  Text Matching result.
    #after clicking search we get the list as per text input in the search box
    ${get_text_colData}  Get Elements    ${PO NUMBER COLUMN DATA LIST}
    FOR    ${Po_no_List}    IN     @{get_text_colData}
    Log To Console    ✅ ${Po_no_List}
    log     ✅ ${Po_no_List}
    END
    sleep    0.05s
    log to console  👆 Please Verify Search Data below
Vendor Search
    [Arguments]  ${Vendor_Name}
    input    ${Vendor SEARCH ICON INPUT FIELD}  ${Vendor_Name}
    click    (//span[contains(text(),'${Vendor_Name}')])[2]
Search Randonmly In Vendor Column
    click   ${PO PAGINATION}
    click   ${PO PAGINATION 100}
    Wait For Elements State    ${PO_HOLE_PAGE_HIGHLIGHT}   visible  timeout=20s
    Reload
    click   ${Vendor SEARCH ICON}
    Vendor Search    Newvendortest01
    click    ${Vendor SEARCH ICON2}
    ${get_text_colData2}  Get Elements    //tr[@class="ant-table-row ant-table-row-level-0"]//td[text()="Newvendortest01"]      #${VENDER COLUMN DATA1}   #--get the PO column Data list -100 entries
    FOR    ${Vendor_Col_List}    IN    @{get_text_colData2}
           ${text2}=    Browser.Get Text    ${Vendor_Col_List}
           log  ✅ ${text2}
           Log To Console    ✅ ${text2}
    RETURN  ${get_text_colData2}
    END
    Wait For Elements State    ${Vendor SEARCH ICON INPUT FIELD}    visible  timeout=30s
    click   ${Vendor SEARCH ICON INPUT FIELD}
    ${value}  Evaluate  random.choice($get_text_colData2)   random             #<------- call data randomely
    log to console  \nvalue: ${value}
    select option from dropdown using div  (//div[@class='ant-select-selector']//div)[1]     ${value}
    ${search text}=    Browser.Get Text     ${Vendor SEARCH ICON INPUT FIELD}
    log to console   You search🔎[ ${value} ] in search box
    click   ${Vendor SEARCH ICON2}      #--intenal click icon
    log to console  Text Matching result
    #after clicking search we get the list as per text input in the search box
    ${get_text_colData}  Get Elements    ${VENDER COLUMN DATA}
    FOR    ${Vendor_Col_List}    IN     @{get_text_colData}
           ${text2}=    Browser.Get Text    ${Vendor_Col_List}
           log  ✅ ${text2}
           Log To Console    ✅ ${text2}
    END
    log to console   👆 Please Verify Search Data below
    log to console   Issue Date Column Data List (After Searching)
#    get the Issue Date column list
    ${get_text_colData}  Get Elements     ${ISSUE DATE COLUMN LIST}      #//td[@class="ant-table-cell"][2]
    FOR    ${Po_no_List}    IN     @{get_text_colData}
           ${text2}=    Browser.Get Text   ${Po_no_List}
           log  ✅ ${text2}
           Log To Console    ✅ ${text2}
    END
    Search Randonmly In Issue Date
    ${search_date}    Browser.Get Text    //span[@class='ant-tag ant-tag-blue']//div[1]
    log to console    You search🔎[ ✅ ${search_date} ] in Issue Date boxSearch
    log to console    Issue Date Column Data List (After Searching)
#    get the Issue Date column list
    ${get_text_colData}  Get Elements     ${ISSUE DATE COLUMN LIST}      #//td[@class="ant-table-cell"][2]
    FOR    ${Po_no_List}    IN     @{get_text_colData}
           ${text2}=    Browser.Get Text   ${Po_no_List}
           log  ✅ ${text2}
           Log To Console    ✅ ${text2}
    END
    log to console   👆 Please Verify PO Column Sorted Data below
#   -------------------
Search Randonmly In Issue Date
    click    //*[@id="purchase_order_Issue Date_search"]
    click    //input[@placeholder='Start date']
    click    //span[text()='Last Week']     #//span[text()='Last Week']
    click    (//*[@id="purchase_order_Issue Date_search"])[2]
Search Randonmly In Delivery Date
    click    (//*[@id="purchase_order_Delivery Date_search"])[1]
    click    (//input[@placeholder='Start date'])[1]
#    click    //li[@class='ant-picker-preset']//span[text()='This Week']
    click    //li[@class='ant-picker-preset']//span[text()='Last Week']
    click    (//*[@id="purchase_order_Delivery Date_search"])[2]    #(//button[contains(@class,'ant-btn ant-btn-circle')])[2]
Searching Issue Date Column
    log to console   Issue Date Column Data List (Before Searching)
#    get the Issue Date column list
    ${get_text_colData}  Get Elements     ${ISSUE DATE COLUMN LIST}      #//td[@class="ant-table-cell"][2]
    FOR    ${Po_no_List}    IN     @{get_text_colData}
           ${text2}=    Browser.Get Text   ${Po_no_List}
           log  ✅ ${text2}
           Log To Console    ${text2}
    END
    Search Randonmly In Issue Date
    ${search_date}    Browser.Get Text    //span[@class='ant-tag ant-tag-blue']//div[1]
    log to console    You search🔎[ ✅ ${search_date} ] in Issue Date boxSearch
    log to console    Issue Date Column Data List (After Searching)
#    get the Issue Date column list
    ${get_text_colData}  Get Elements     ${ISSUE DATE COLUMN LIST}      #//td[@class="ant-table-cell"][2]
    FOR    ${Po_no_List1}    IN     @{get_text_colData}
           ${text2}=    Browser.Get Text   ${Po_no_List1}
           log  ✅ ${text2}
           Log To Console    ${text2}
    END
    log to console   👆 Please Verify PO Column Sorted Data below
Searching Delivery Date Column
    #----------------------------Delivery Date column List--------------------------------
    log to console   Delivery Date Column Data List (Before Searching)
    ${get_text_colData}  Get Elements     ${DELIVERY DATE COLUMN DATA2}   #//td[@class="ant-table-cell"][3]
    FOR    ${Po_no_List}    IN     @{get_text_colData}
    ${text1}=    Browser.Get Text    ${Po_no_List}
    Log To Console   ✅ ${text1}
    END
    Search Randonmly In Delivery Date
    log to console   Delivery Date Column Data List (After Searching)
    Sleep    1.5s
    ${get_text_colData}  Get Elements     ${DELIVERY DATE COLUMN DATA2}   #//td[@class="ant-table-cell"][3]
    FOR    ${Po_no_List}    IN     @{get_text_colData}
    ${text2}=    Browser.Get Text    ${Po_no_List}
    Log To Console   ✅ ${text2}
    END
    log to console   [👆 Please Verify PO Column Sorted Data below ]
Searching Item Details Column
    #---- Item Details column List ----
    log to console   Item Details Column Data List (Before Searching)
    ${get_text_colData}  Get Elements     ${ITEM DETAILS COLUMN DATA}   #//td[@class="ant-table-cell"][3]
    FOR    ${Po_no_List_a}    IN     @{get_text_colData}
           ${text2_a}=    Browser.Get Text   ${Po_no_List_a}
           log  ✅ ${text2_a}
           Log To Console   ✅ ${text2_a}
    END
    Search Randonmly In Item Details columns
    log to console   Item Details Column Data List (After Searching)
    Sleep    1s
    ${get_text_colData}  Get Elements    ${ITEM DETAILS COLUMN DATA}   #//td[@class="ant-table-cell"][3]
    FOR    ${Po_no_List_b}    IN    @{get_text_colData}
           ${text2_b}=    Browser.Get Text   ${Po_no_List_b}
           log  ✅ ${text2_b}
           Log To Console   ✅ ${text2_b}
    END
Search Randonmly In Item Details columns   
    click    //*[@id="purchase_order_Item Details_search"]
    click    (//input[@type='search'])[2]
#    click   //input[@id="rc_select_40"]
    input   (//input[@class="ant-select-selection-search-input"])[2]   HR00004
    click    (//*[@id="purchase_order_Item Details_search"])[2]
    Sleep    1s
Fill Text Validation
    ${order_info}    Browser.Get Text    xpath://div[contains(@style, 'text-align: center;')]
    ${start_index}    Evaluate    "${order_info}".find("Order ") + len("Order ")
    ${end_index}    Evaluate    "${order_info}".find(" has been created!")
    ${order_number}    Evaluate    "${order_info}"[${start_index}:${end_index}]
    search Ponumber in PoListpage for validation   ${order_number}
    RETURN  ${order_number}
Verify Row Data
    ${rows1} =  get element count   ant-table-row ant-table-row-level-0
    sleep  2
    log to console   Total Rows= ${rows1}
    log  ✅ ${rows1}
    ${get_text_colData}  Get Elements  ant-table-row ant-table-row-level-0
    FOR    ${getdata}  IN   @{get_text_colData}
    sleep  0.05s
    Log To Console  ✅ ${getdata}
    log   ✅ ${getdata}
    END
#    ${ItemDetails}    Browser.Get Text     //td[@class="ant-table-cell"][1]
#    log to console  Item Details is ✅ ${ItemDetails}}
#    ${quantity}    Browser.Get Text     //td[@class="ant-table-cell"][2]
#    log to console  Item Details is ✅ ${quantity}
    log to console    ✅ Item_Code, Quantity, Price editing successfully completed On PO Page
Verify_ItemCode_Price_Quantity_ Should_Be_Edited
    [Arguments]   ${xpath}
    click   ${xpath}
    click   //*[@data-icon="edit"]
    click   //button[text()='Edit']
    select itom code_quantity_price   0   10   25
    click   //*[@id="back_btn"]
    Wait For Elements State   (//span[text()='CR00009'])[1]   visible   timeout=30s
    Wait For Elements State   //td[text()="10 piece"]   visible   timeout=30s
    Wait For Elements State   //*[contains(text(),'25.00')]   visible   timeout=30s
    click   //*[@id="back_btn"]
    Wait For Elements State   ${xpath}   visible   timeout=30s
    ${Po_num}=  Browser.Get Text    ${xpath}
    log to console    ${Po_num}
    click    (//*[@id="purchase_order_PO Number_search"])[1]
    click   ${SEARCH ICON INPUT FIELD}
    Wait For Elements State    ${SEARCH ICON INPUT FIELD}   visible   timeout=30s
#    sleep   5s
    Fill Text    ${SEARCH ICON INPUT FIELD}   ${Po_num}
    click    (//*[@id="purchase_order_PO Number_search"])[2]
    Verify Row Data
Select Itom Code_Quantity_Price
    [Arguments]   ${i}   ${quantity}   ${price}
    Wait For Elements State   ${SELECT_ITEMTYPE}  visible   timeout=30s
#    select vendor    Niteshmoon
    Clear Text    //input[@id="purchase_order_0_sku"]
    Fill Text    //input[@id="purchase_order_0_sku"]   CR00009
    click   ${INPUT_QUANTITY}
    Clear Text    ${INPUT_QUANTITY}
#    browser.Press Keys   ${INPUT_QUANTITY}   Control+A
#    browser.Press Keys   ${INPUT_QUANTITY}   Backspace
    Fill Text    ${INPUT_QUANTITY}    ${quantity}
    click   ${INPUT_PRICE}
    browser.Press Keys   ${INPUT_PRICE}   Control+A
    browser.Press Keys   ${INPUT_PRICE}   Backspace
    Fill Text  ${INPUT_PRICE}  ${price}
    click    ${submit1}

set ith item in PO
    [Arguments]  ${i}  ${recievedName}  ${recievedQuantity}   ${price}  ${hsn_code}
    browser.press keys  //input[@id="purchase_order_${i}_sku"]/../../span[2]  Control+A
    browser.press keys  //input[@id="purchase_order_${i}_sku"]/../../span[2]  Backspace
    input   //input[@id="purchase_order_${i}_sku"]   ${recievedName}
    Wait For Elements State    //input[@id="purchase_order_${i}_sku"]   visible  timeout=30s
    browser.press keys  //input[@id="purchase_order_${i}_sku"]  Enter
    browser.press keys    //input[@id="purchase_order_${i}_quantity"]  Control+A
    browser.press keys    //input[@id="purchase_order_${i}_quantity"]  Backspace
    input    //input[@id="purchase_order_${i}_quantity"]    ${recievedQuantity}
    browser.Press Keys    //*[@id="purchase_order_${i}_price_per_unit"]   Control+A
    browser.Press Keys    //*[@id="purchase_order_${i}_price_per_unit"]   Backspace
    input    //*[@id="purchase_order_${i}_price_per_unit"]    ${price}
    browser.Press Keys    //*[@id="purchase_order_${i}_hsn"]   Control+A
    browser.Press Keys    //*[@id="purchase_order_${i}_hsn"]   Backspace
    Fill Text    //*[@id="purchase_order_${i}_hsn"]    ${hsn_code}
    click   //th[text()="HSN Code"]

Select Vendor for PO
    [Arguments]  ${vendorname}
    Wait For Elements State    ${vendorselectiondropdown}  visible    timeout=30s
    input  ${vendorselectiondropdown}  ${vendorname}
    click  //span[text() = "${vendorname}"]
Multiple PO Creation
    [Arguments]    ${vendor}  ${ItemData}
    Sleep    3s
    click    ${CREATE_NEW_BUTTON}
    Sleep    3s
    Wait For Load State    domcontentloaded    timeout=60s
    Select Vendor for PO  ${vendor}[0]
    select Delivery Date
    ${today1}    Get Current Date  result_format=%d-%m-%Y
    Fill Text    //*[@id="purchase_order_remarks"]    Urgent
    Select From Dropdown    (//*[@class="ant-select-selection-search-input"])[3]    Plant 2
    set ith item in PO  ${ItemData}[0]  ${ItemData}[1]  ${ItemData}[2]  ${ItemData}[3]  ${ItemData}[4]
    set ith item in PO  ${ItemData1}[0]  ${ItemData1}[1]  ${ItemData1}[2]  ${ItemData1}[3]  ${ItemData1}[4]
    set ith item in PO  ${ItemData2}[0]  ${ItemData2}[1]  ${ItemData2}[2]  ${ItemData2}[3]  ${ItemData2}[4]
    set ith item in PO  ${ItemData3}[0]  ${ItemData3}[1]  ${ItemData3}[2]  ${ItemData3}[3]  ${ItemData3}[4]
    click   ${SUBMIT}
    log to console    --- * PO creation Successfully done * --
    ${order_info}    Browser.Get Text   xpath=//div[contains(@style, 'text-align: center;')]
    ${start_index}   Evaluate   "${order_info}".find("Order ") + len("Order ")
    ${end_index}    Evaluate    "${order_info}".find(" has been created!")
    ${order_number}   Evaluate   "${order_info}"[${start_index}:${end_index}]
    log to console    --- * Multiple PO creation is Sucessfully done * --
    click    ${BACK}
    Wait For Elements State    ${SEARCH ICON}  visible    timeout=30s
    Search In PO   ${order_number}
    RETURN  ${order_number}

Create_PO
    [Arguments]    ${ItemData}  ${vendor}
    Sleep   4s
    Wait For Load State    domcontentloaded    timeout=30s
    click   ${CREATE_NEW_BUTTON}
    Sleep   4s
    Wait For Load State    domcontentloaded    timeout=30s
    Select Vendor for PO  ${vendor}[0]
    select Delivery Date
    ${today1}    Get Current Date  result_format=%d-%m-%Y
    Fill Text    //*[@id="purchase_order_remarks"]    Normal
    Select From Dropdown    (//*[@class="ant-select-selection-search-input"])[3]    Plant 2
    set ith item in PO  ${ItemData}[0]  ${ItemData}[1]  ${ItemData}[2]  ${ItemData}[3]  ${ItemData}[4]
    click   ${SUBMIT}
    log to console   PO creation Successfully done
#    Verify Text
    ${order_info}    Browser.Get Text   xpath=//div[contains(@style, 'text-align: center;')]
    ${start_index}   Evaluate   "${order_info}".find("Order ") + len("Order ")
    ${end_index}    Evaluate    "${order_info}".find(" has been created!")
    ${order_number}   Evaluate   "${order_info}"[${start_index}:${end_index}]
    click    ${BACK}
    Wait For Elements State    ${SEARCH ICON}  visible    timeout=30s
    Search In PO   ${order_number}
    RETURN  ${order_number}
Text validation
    [Arguments]    ${expected_text}
    ${actual_text}    Browser.Get Text    ${PO_STATUS}
    log to console  ✅ ${actual_text}
    log   ${actual_text}
    IF    '${actual_text}' == '${expected_text}'
        Log    ✅ Status validation passed
        log to console  ✅ Status validation passed
    END

Verify PO Details
    [Documentation]    Validates PO details
#    [Arguments]   ${vendor}   ${date}   ${ItemData}[1]
    Click   ${ITEM_VIEW_TOGGLE_BUTTON}
    Sleep    1.5s
    ${PO_details}    Browser.Get Text    (//tr[@class='ant-table-row ant-table-row-level-0'])[1]
    @{list}=    Create List    ${PO_details}
    Log To Console   ------------------------
    Log To Console    ✅ ${list}   #${PO_details}
    Click    ${ITEM_VIEW_TOGGLE_BUTTON}
    Click    ${PO_ORDER_DETAIL}
    Sleep    1s
    ${validate_Details}    Browser.Get Text    //div[contains(@class,'MuiPaper-root MuiPaper-outlined')]
    Log To Console  ----------------------
    Log To Console    ✅ ${validate_Details}
    @{Item}=    Create List    //div[contains(@class,'MuiPaper-root MuiPaper-outlined')]
    FOR    ${Item}    IN    ${list}
        Wait For Elements State    ${Item}  visible    timeout=30s
    END
    IF    '${list}' IN   '${Item}'
        log    ${list}
    END

Verify Withdraw Status
    ${order_number}=    Create_PO   ${ItemData}  ${vendor}
    Text validation   ${expected_text}
    click    //*[@id='purchase_order_withdraw ']
    ${conform_msg}      Browser.Get Text    //*[@id='confirm-site-delete-title']
#    Wait For Elements State    //*[@id='confirm-site-delete-title']    text=${conform_msg}
    click    (//*[@id='undefined__deactivate_btn'])[2]
    sleep    1s
    ${Widthdraw_Note}   Browser.Get Text    //div[@class='MuiAlert-message css-1xsto0d']
    sleep    1s
    log to console    ✅ ${Widthdraw_Note}
    i should see text on page    ${withdraw-Status}
    ${Status}  Browser.Get Text    ${withdraw-Status}
    log    Status is ✅ ${Status}
    log to console    Status is ✅ ${Status}
    click   //*[@id='purchase_order_closed_filter_chip']
    search in po   ${order_number}

PO_Inward_Flow_Using_Single_Item
    ${order_number}=    Create_PO   ${ItemData}   ${vendor}
    click   (//*[@id="purchase_order_approve"])[1]
    Wait For Elements State   ${inward_button}   visible    timeout=30s        #${inward_button}[1]   30s
    safely click element    ${inward_button}
    Wait For Elements State    //span[text()='Inward Against ${order_number} / ${vendor}[0]']
    ${text}=    Browser.Get Text    //span[text()='Inward Against ${order_number} / ${vendor}[0]']
    log to console    ✅ ${text}
    log   ✅ ${text}
    should contain    ${text}   ${order_number} / ${vendor}[0]
    Select from inspected by dropdown PO_inward   ${inspected_By}[0]
    ${randomrefNumber}=   Generate Random number    4
    input   ${invoice_number}    ${randomrefNumber}
    ${random_string}=    Generate Random Number_String
    input   ${truck_number}    ${random_string}
#   selct all item details using checkbox
    Check Checkbox    ${checkbox}
    click    ${Auto_fill}
    Click    ${submit}
    sleep    0.5s
    Wait For Elements State    ${inward_note_msg}
    ${inward_note}  Browser.Get Text  ${inward_note_msg}
    log   ✅ ${inward_note}
    sleep    1s

PO Inward_Flow
    ${order_number}=   Multiple PO Creation    ${vendor}   ${ItemData}
    click   ${CLICK_PO_DETAILS}
    click   ${CLICK_APPROVE}
    sleep   2s
#    ${Status}   Browser.Get Text    //div[normalize-space(text())='${order_number} Issued']
    Wait For Elements State   ${inward_button}   visible     timeout=60s        #${inward_button}[1]   30s
    click   ${inward_button}
    ${text}=    Browser.Get Text    //span[text()='Inward Against ${order_number} / ${vendor}[0]']
    log to console    ✅ ${text}
    log   ✅ ${text}
    should contain    ${text}   ${order_number} / ${vendor}[0]
    Select from inspected by dropdown PO_inward   ${inspected_By}[0]
    ${randomrefNumber}=   Generate Random number   4
    input   ${invoice_number}    ${randomrefNumber}
    ${random_string}=    Generate Random Number_String
    input   ${truck_number}    ${random_string}
#   selct all item details using checkbox
    Check Checkbox    ${checkbox}
    click    ${Auto_fill}
    Wait For Elements State   //input[@value='${ItemData}[2]']  visible   timeout=30s
    Wait For Elements State   //input[@value='${ItemData1}[2]']  visible   timeout=30s
    Wait For Elements State   //input[@value='${ItemData2}[2]']  visible   timeout=30s
    Wait For Elements State   //input[@value='${ItemData3}[2]']  visible   timeout=30s
    log    ✅Entered Quantity = ${ItemData}[2]
    log    ✅Entered Quantity = ${ItemData1}[2]
    log    ✅Entered Quantity = ${ItemData2}[2]
    log    ✅Entered Quantity = ${ItemData3}[2]
    Uncheck Checkbox     ${checkbox}
    Check Checkbox    (//input[@type="checkbox"])[5]       #${checkbox}[5]
    click    ${Auto_fill}
    click    ${move to top}
    click    ${submit}
    Wait For Elements State   ${inward_note_msg}  visible  timeout=30s
    ${inward_note}  Browser.Get Text  ${inward_note_msg}
    log   ✅ ${inward_note}

Inward from Inventory
    [Arguments]    ${xpath}   ${PO_No}
    click   ${xpath}
    ${text}=    Browser.Get Text    //span[text()='Inward Against ${PO_No} / ${vendor}[0]']
    log   ✅ ${text}
    should contain    ${text}   ${PO_No} / ${vendor}[0]
    Select from inspected by dropdown PO_inward   ${inspected_By}[0]
    ${randomrefNumber}=   Generate Random number   4
    input   ${invoice_number}    ${randomrefNumber}
    ${random_string}=    Generate Random Number_String
    input   ${truck_number}    ${random_string}
    # selct all item details using checkbox
    Check Checkbox    (//input[@type='checkbox'])[2]
    click    ${Auto_fill}
    click    //th[@class='ant-table-cell']//button[1]
    # click    ${move to top}
    Click    ${submit}
    ${inward_note}  Browser.Get Text    ${inward_note_msg}
    log   ✅ ${inward_note}
    Hover     ${INVENTRY}
    click    //a[contains(text(),'Transactions')]
    click    //*[@id="transaction_refresh_icon"]
    # Note:   ${T_Status2} means (Transaction status2)
    # Note:   ${T_Status1} means (Transaction status1)
    ${T_Status2}  Browser.Get Text    (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[10]
    log    ✅ Before Approved Inward Request Status = ✅ ${T_Status2}
    Click on Transaction Actions Buttons    (//*[@id="transaction_credit_approve"])[1]
    Wait For Elements State   //div[text()='MRN approved SuccesFully']    visible    timeout=30s
    ${ApprovedNote}  Browser.Get Text    //div[text()='MRN approved SuccesFully']
    ${T_Status1}  Browser.Get Text    (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[10]
    log    ✅ After Approved Inward Request Status = ✅ ${T_Status1}
    ${GRN_No}  Browser.Get Text    (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[1]
    log    ✅ ${ApprovedNote}
    log    GRN = ✅ ${GRN_No}
    Landing On Purchase Order Page
    click   (//*[@id="purchase_order_details"])[1]
    log    Orderd Quantity = ✅ ${ItemData}[2] pallet
    log    Delivered Quantity = ✅ ${ItemData}[2] pallet
    Wait For Elements State    (//a[text()="${PO_No}"])[2]//following::span[text()="${vendor}[0]"]    visible    timeout=30s
    Wait For Elements State    (//span[text()="${ItemData}[1]"])[1]//following::td[text()="10"]//following::td[text()="${ItemData}[2] kg"]//following::td[text()="${ItemData}[3] kg"]  visible    timeout=30s
    log    ${vendor}[0] - ${PO_No} - ${ItemData}[2] kg - ${ItemData}[0]
    click    //*[@data-testid="CancelIcon"]
#    Note:   ${P_Status} means (Purchase Order Page status)
    ${P_Status}  Browser.Get Text    ((//tr[@class='ant-table-row ant-table-row-level-0'])//td[7])[1]
    log   ✅ After Approved Inward Request Status = ✅ ${P_Status} (On PO Page)
    sleep   0.05s

Select from inspected by dropdown PO_inward
    [Arguments]  ${inspected_By}
    input  //input[@id='credit__form__inspected_by']  ${inspected_By}
    click  //*[text()='${inspected_By}']

Select from inspected by dropdown PO_inward2
    [Arguments]  ${inspected_By}
    input   //*[@id="inward__form__inspected_by"]    ${inspected_By}
    click   //span[text()='${inspected_By}']

Input into Invoice No Dropdown PO_inward    #generate random no
    [Arguments]  ${invoice_No}
    input  //input[@id='credit__form__invoice_number']  ${invoice_No}
#    click  //span[text() = "${invoice_No}"]

Input Into Purchase Order Dropdown PO_inward
    [Arguments]  ${PO_No}
    input  //input[@id='inward__form__purchase_order']  ${PO_No}
    click  //span[text()='${PO_No}']

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

Generate Random number
    [Arguments]    ${length}
    ${ran_int}=    Generate Random String    length=${length}    chars=[NUMBERS]
    ${ran_int}=    Convert To Integer    ${ran_int}
#    log to console    This is a random number between 1000 and 9999: ${ran_int}
    RETURN    ${ran_int}

Generate Randomely_1_digit_number
    ${random_number}=    Evaluate    random.randint(1, 9)    random
    Log    Generated Random Number: ${random_number}
    RETURN    ${random_number}

Generate Random Number_String
    ${random_string}=    Generate Random String    length=6    chars=[UPPER][NUMBERS]
    Log    Random String: ${random_string}
#    log to console    Random String: ${random_string}
    RETURN    ${random_string}

Verify Inward Request details(Withdraw)
#    ${order_number}=    multiple po creation    ${vendor}  ${ItemData}
    Sleep    1s
    ${order_number}=    Create_PO   ${ItemData}  ${vendor}
    click   ${CLICK_PO_DETAILS}
    click   ${CLICK_APPROVE}
    ${Status}   Browser.Get Text    (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[8]      #//div[normalize-space(text())='${order_number} Issued']
    Wait For Elements State   ${inward_button}    visible    timeout=30s          #${inward_button}[1]
    Safely Click Element   ${inward_button}
    Select from inspected by dropdown PO_inward   ${inspected_By}[0]
    ${randomrefNumber}=   Generate Random number   4
    input   ${invoice_number}    ${randomrefNumber}
    ${random_string}=    Generate Random Number_String
    input   ${truck_number}    ${random_string}
    Check Checkbox    ${checkbox}
    ${order_qnt}    Browser.Get Text    (//*[@class="ant-input-group-addon"])[2]
    log   ✅ ${order_qnt}
    ${qt}=    Generate Random number  1
    log to console    ${qt}
    Fill Text    (//*[@id="po_inward_0_quantity"])[2]  ${qt}
    Click    ${submit}
    Wait For Elements State   ${inward_note_msg}  visible    timeout=30s
    ${inward_note}  Browser.Get Text  ${inward_note_msg}
    log to console  ✅ ${inward_note}
    Hover     //span[text()='Inventory']
    click    //*[@id="transactions"]
    click    //*[@id="transaction_refresh_icon"]
    click    (//*[@id="transaction_item_view"])
#    ${Dquantity}   Browser.Get Text    (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[5]
#    Log    ${Dquantity}
    Wait For Elements State    (//*[@id="transaction_item_view"])   visible   30s
    click    (//*[@id="transaction_item_view"])
    click    (//td[@class='ant-table-cell'])[3]
    Wait For Elements State   //span[text()='${order_number}']  visible   timeout=30s
    Wait For Elements State   //span[text()='${vendor}[0]']   visible   timeout=30s
    Wait For Elements State   //a[normalize-space(text())='${ItemData}[1]']   visible   timeout=30s
    Wait For Elements State   //div[text()='${qt} pallet']   visible   timeout=30s
#    Wait For Elements State    (//td[text()='${qt} pallet')])[2]   visible   timeout=30s
    log   Order no = '${order_number}' , Vendor is = '${vendor}[0]' , Item Name is = '${ItemData}[1]')]) , Quantity is = '${qt} pallet'
    Click on Transaction Actions Buttons    //button[text()='Withdraw']
    ${disApprovedNote}  Browser.Get Text    //div[text()='Request note disapproved SuccesFully']
    ${Status}  Browser.Get Text    (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[10]
    ${GRN_No}  Browser.Get Text    (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[1]
    log     ✅ ${disApprovedNote}
    log    Status = ✅ ${Status}
    log    GRN = ✅ ${GRN_No}
    click   //*[@id="transaction_GRN_search"]
    Fill Text    //input[@placeholder='Search GRN']    ${GRN_No}
    click    (//*[@id="transaction_GRN_search"][1])[2]
    Landing On Purchase Order Page
    click   ${inward_button}
    Wait For Elements State    //span[text()='${order_qnt}']    visible   30s
    log    ✅ ${order_qnt}
    sleep    0.05s

Verify Inward Request details(Partially_Received)
    Sleep    1s
    ${order_number}=    Create_PO   ${ItemData}  ${vendor}
    click   ${CLICK_PO_DETAILS}
    click   ${CLICK_APPROVE}
    ${Status}   Browser.Get Text    (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[8]
    Wait For Elements State   ${inward_button}    visible    timeout=30s
    Safely Click Element   ${inward_button}
    Select from inspected by dropdown PO_inward   ${inspected_By}[0]
    ${randomrefNumber}=   Generate Random number    4
    input   ${invoice_number}    ${randomrefNumber}
    ${random_string}=    Generate Random Number_String
    input   ${truck_number}    ${random_string}
    Check Checkbox    ${checkbox}
    ${order_qnt}    Browser.Get Text    (//*[@class="ant-input-group-addon"])[2]
    log to console  ✅ ${order_qnt}
    ${qt}=    Generate Randomely_1_digit_number
    Fill Text    (//*[@id="po_inward_0_quantity"])[2]  ${qt}
    Click    ${submit}
    ${inward_note}  Browser.Get Text  ${inward_note_msg}
    log to console  ✅ ${inward_note}
    Hover     //span[text()='Inventory']
    click    //*[@id="transactions"]
    click    //*[@id="transaction_refresh_icon"]
    click    (//*[@id="transaction_item_view"])
#    ${Dquantity}   Browser.Get Text    (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[5]
    click    (//*[@id="transaction_item_view"])
    Click on Transaction Actions Buttons    (//*[@id="transaction_credit_approve"])[1]
    Wait For Elements State    //*[text()="perform IQC first"]    visible    timeout=30s
    Safely Click Element    //*[text()="perform IQC first"]
    click   //*[@id="credit__rejections__edit"]
#    Click    ${EDIT}
    sleep   2s
    Select From Dropdown    ${REJECTION_REASON}   Cleaning Not Proper
    sleep   2s
    Fill Text   ${REJECTION_INPUTBOX}   1     #${Rej_Qty_randomNumber}
    log   ✅ Entered Rejection Qty is = ✅ 1      #${Rej_Qty_randomNumber}
    click    ${SUBMIT3}
    Wait For Elements State    ${TRANSACTION_NOTE}
    ${text}=    Browser.Get Text    ${TRANSACTION_NOTE}
    log  ✅ ${text}
    click   ${BACK2}
    ${Status}  Browser.Get Text    (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[10]
    ${GRN_No}  Browser.Get Text    (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[1]
#    set selenium speed    0.8s
    click   ${ACTION_BUTTON}
    Wait For Elements State   //div[text()='MRN approved SuccesFully']    visible    timeout=30s
    ${ApprovedNote}  Browser.Get Text    //div[text()='MRN approved SuccesFully']
    log     ✅ ${ApprovedNote}
    log    Status = ✅ ${Status}
    log    GRN = ✅ ${GRN_No}
    Landing On Purchase Order Page
    click   (//*[@id="purchase_order_details"])[1]  #${inward_button}
    ${remain}=  Evaluate  ${ItemData}[2] - ${qt}
    log    ✅ ${remain}
    Wait For Elements State    //*[text()='${remain} pallet']  visible  timeout=30s
    Wait For Elements State    //td[text()='${ItemData}[2] pallet']   visible   timeout=30s
    Wait For Elements State    //td[text()='${qt} pallet']  visible   timeout=30s
    log    Orderd Quantity = ✅ ${ItemData}[2] pallet , Delivered Quantity = ✅ ${qt} pallet , Remaining Quantity = ✅ /${remain} pallet
    sleep   0.5s
    click    //*[@data-testid="CancelIcon"]
    ${T_Status}  Browser.Get Text    ((//tr[@class='ant-table-row ant-table-row-level-0'])//td[7])[1]
    log    Status = ✅ ${T_Status}

Verify Inward Request details(Received)
    sleep   1s
    ${order_number}=    Create_PO   ${ItemData}   ${vendor}
    click   ${CLICK_PO_DETAILS}
    click   ${CLICK_APPROVE}
#    ${Status}   Browser.Get Text    //div[normalize-space(text())='${order_number} Issued']
    ${P_Status}  Browser.Get Text    (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[7]
    log    ✅ After Create PO Status = ✅ ${P_Status}
    Wait For Elements State   ${inward_button}  visible  30s
    click   ${inward_button}
    ${text}=    Browser.Get Text    //span[text()='Inward Against ${order_number} / ${vendor}[0]']
    log   ✅ ${text}
    should contain  ${text}   ${order_number} / ${vendor}[0]
    Select from inspected by dropdown PO_inward   ${inspected_By}[0]
    ${randomrefNumber}=   Generate Random number   4
    input   ${invoice_number}    ${randomrefNumber}
    ${random_string}=    Generate Random Number_String
    input   ${truck_number}    ${random_string}
    Check Checkbox    ${checkbox}
    click    ${Auto_fill}
    Click    ${submit}
    sleep    1s
    ${inward_note}  Browser.Get Text    ${inward_note_msg}
    log   ✅ Inward Note Msg = ✅ ${inward_note}
    Hover     //span[text()='Inventory']
    click    //*[@id="transactions"]
    click    //*[@id="transaction_refresh_icon"]
    Wait For Elements State   (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[10]   visible    timeout=30s
    ${T_StatusB}  Browser.Get Text    (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[10]
    log    ✅ Before Approved Inward Request Status = ✅ ${T_StatusB}
    Click on Transaction Actions Buttons    (//*[@id="transaction_credit_approve"])[1]
    Wait For Elements State    //*[text()="perform IQC first"]    visible    timeout=30s
    Safely Click Element    //*[text()="perform IQC first"]
    click  ${EDIT}
    click  ${ALL_OK}
    Wait For Elements State    ${TRANSACTION_NOTE}    visible    timeout=30s
    ${text}=    Browser.Get Text    ${TRANSACTION_NOTE}
    log  ✅ ${text}
    click  ${BACK2}
    sleep  1s
    ${Status}  Browser.Get Text  (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[10]
    ${GRN_No}  Browser.Get Text  (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[1]
#    set selenium speed    0.8s
    click  ${ACTION_BUTTON}
    sleep  0.5s
    Wait For Elements State  //div[text()='MRN approved SuccesFully']    visible    timeout=30s
    ${ApprovedNote}  Browser.Get Text  //div[text()='MRN approved SuccesFully']
    log  ✅ ${ApprovedNote}
    log  Status = ✅ ${Status}
    sleep  0.5s
    ${ApprovedNote}  Browser.Get Text  //div[text()='MRN approved SuccesFully']
    ${T_StatusA}  Browser.Get Text  (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[10]
    log  ✅ After Approved Inward Request Status = ✅ ${T_StatusA}
    ${GRN_No}  Browser.Get Text  (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[1]
    log  ✅ ${ApprovedNote}
    log  GRN = ✅ ${GRN_No}
    sleep  0.05s
    Landing On Purchase Order Page
    click  (//*[@id="purchase_order_details"])[1]
    log  Orderd Quantity = ✅ ${ItemData}[2] pallet
    log  Delivered Quantity = ✅ ${ItemData}[2] pallet
    Wait For Elements State  //span[text()='${vendor}[0]']
    Wait For Elements State  (//*[text()="${order_number}"])[2]
    Wait For Elements State  (//td[text()='${ItemData}[2] pallet'])[1]
    Wait For Elements State  (//td[text()='${ItemData}[2] pallet'])[2]
    Wait For Elements State  //span[normalize-space(text())='${ItemData}[1]']
    log   ✅ ${vendor}[0] - ✅ ${order_number} - ✅ ${ItemData}[2] pallet - ✅ ${ItemData}[1]
    click    //*[@data-testid="CancelIcon"]
    ${P_Status}  Browser.Get Text    ((//tr[@class='ant-table-row ant-table-row-level-0'])//td[7])[1]
    log   ✅ After Approved Inward Request Status = ✅ ${P_Status} (On PO Page)

Verify Inward Request details
    ${order_number}=   Create_PO  ${ItemData}  ${vendor}
    click  ${CLICK_PO_DETAILS}
    click  ${CLICK_APPROVE}
    sleep  1s
    ${P_Status}  Browser.Get Text  (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[7]
    log  ✅ After Create PO Status = ✅ ${P_Status}
    Wait For Elements State   ${inward_button}  visible  timeout=30s
    click  ${inward_button}
    ${text}=  Browser.Get Text  //span[text()='Inward Against ${order_number} / ${vendor}[0]']
    log  ✅ ${text}
    should contain  ${text}  ${order_number} / ${vendor}[0]
    Select from inspected by dropdown PO_inward   ${inspected_By}[0]
    ${randomrefNumber}=  Generate Random number   4
    input   ${invoice_number}  ${randomrefNumber}
    ${random_string}=  Generate Random Number_String
    input  ${truck_number}  ${random_string}
    Check Checkbox  ${checkbox}
    click  ${Auto_fill}
    click  ${submit}
    ${inward_note}  Browser.Get Text    ${inward_note_msg}
    log  ✅ Inward Note Msg = ✅ ${inward_note}
    Hover   ${INVENTORY}
    click  ${TRANSACTIONS}
    click  ${REFRESH1}
    Wait For Elements State  (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[10]   visible    timeout=30s
    ${T_StatusB}  Browser.Get Text  (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[10]
    log  ✅ Before Approved Inward Request Status = ✅ ${T_StatusB}
    Click on Transaction Actions Buttons  (//*[@id="transaction_credit_approve"])[1]
    Wait For Elements State  ${PERFORM_IQC_FIRST}    visible    timeout=30s
    Safely Click Element  ${PERFORM_IQC_FIRST}
    Wait For Elements State  ${EDIT}    visible    timeout=30s
    click   ${EDIT}
    click  ${ALL_OK}
    Wait For Elements State   ${TRANSACTION_NOTE}    visible    timeout=30s
    ${text}=   Browser.Get Text   ${TRANSACTION_NOTE}
    log  ✅ ${text}
    click  ${BACK2}
    Wait For Elements State   (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[10]   visible    timeout=30s
    ${Status}  Browser.Get Text  (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[10]
    Wait For Elements State   (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[1]   visible    timeout=30s
    ${GRN_No}  Browser.Get Text  (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[1]
    click   (//*[@id="transaction_GRN_search"])[1]
    input    //*[@placeholder="Search GRN"]    ${GRN_No}
    click   (//*[@id="transaction_GRN_search"])[2]
    Wait For Elements State    ${ACTION_BUTTON}   visible   timeout=30s
    click  ${ACTION_BUTTON}
    Wait For Elements State  ${MRN_APPROVE_NOTE}    visible    timeout=30s
    ${ApprovedNote}  Browser.Get Text  ${MRN_APPROVE_NOTE}
    log  ✅ ${ApprovedNote}
    log  Status = ✅ ${Status}
#    ${ApprovedNote}  Browser.Get Text  ${MRN_APPROVE_NOTE}
    ${T_StatusA}  Browser.Get Text  (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[10]
    log  ✅ After Approved Inward Request Status = ✅ ${T_StatusA}
    ${GRN_No}  Browser.Get Text  (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[1]
    log  ✅ ${ApprovedNote}
    log  GRN = ✅ ${GRN_No}
    Wait For Elements State    //*[@id="transaction_credit_return"]   visible   30s
    click  //*[@id="transaction_credit_return"]
    ${actual_text} =  Browser.Get Text  //*[text()="Return Request against ${GRN_No}"]
    Should Be Equal As Strings  ${actual_text}  Return Request against ${GRN_No}
    Should Contain  ${actual_text}  ${GRN_No}
    input   (//*[@class="ant-input-number-input"])[2]  5
    click  ${submit}
    Wait For Elements State  //div[normalize-space(text())='Return request submitted']  visible    timeout=30s
    ${text}=  Browser.Get Text  //div[normalize-space(text())='Return request submitted']
    log  ${text}
    Sleep    1s
    click  ${OUTWARD}
    Wait For Elements State    (//*[@class="ant-table-row ant-table-row-level-0"])[1]//td[8]   visible  timeout=30s
    sleep   1s
    click  (//*[@class="ant-table-row ant-table-row-level-0"])[1]//td[3]
    Wait For Elements State  //*[text()="Return Against Inward"]//following::*[text()="${GRN_No}"]    visible    timeout=30s
    Wait For Elements State  (//*[text()="${ItemData}[1]"]//following::*[text()="5 pallet"])[1]  visible    timeout=30s
#    Wait For Elements State  (//*[text()="${ItemData}[1]"]//following::*[text()="5 pallet"])[2]  visible    timeout=30s
    click  ${CANCELICON}
    click  (//*[@id="transaction_debit_approve"])[1]
    Wait For Elements State  //div[text()='MRN approved SuccesFully']    visible    timeout=30s
    ${ApprovedNote}  Browser.Get Text  //div[text()='MRN approved SuccesFully']
    log  ✅ ${ApprovedNote}
    click  (//*[@class="ant-table-row ant-table-row-level-0"])[1]//td[3]
    Wait For Elements State  (//*[text()="${ItemData}[1]"]//following::*[text()="5 pallet"])[1]  visible    timeout=30s
#    Wait For Elements State  (//*[text()="${ItemData}[1]"]//following::*[text()="5 pallet"])[2]  visible    timeout=30s
    Landing On Purchase Order Page
    click  (//*[@id="purchase_order_details"])[1]
    log  Orderd Quantity = ✅ ${ItemData}[1] pallet
    log  Delivered Quantity = ✅ ${ItemData}[1] pallet
    Wait For Elements State  //span[text()='${vendor}[0]']    visible    timeout=30s
    Wait For Elements State  (//*[text()="${order_number}"])[2]   visible    timeout=30s
    Wait For Elements State  //*[text()="${ItemData}[1]"]//following::*[text()="${ItemData}[2]"]//following::*[text()="${ItemData}[2] pallet"]//following::*[text()="${ItemData}[2] pallet"]   visible    timeout=30s
    ${deleverd}=  Evaluate  ${ItemData}[2] - 5
    Wait For Elements State  //*[text()="${ItemData}[1]"]//following::*[text()="${deleverd} pallet"]//following::*[text()="5 pallet"]   visible    timeout=30s
    log  ✅ ${vendor}[0] - ✅ ${order_number} - ✅ ${ItemData}[2] pallet - ✅ ${ItemData}[0]
    click  ${CANCELICON}
    ${P_Status}  Browser.Get Text  ((//tr[@class='ant-table-row ant-table-row-level-0'])//td[7])[1]
    log   ✅ After Approved Inward Request Status = ✅ ${P_Status} (On PO Page)

Click on Transaction Actions Buttons
    [Arguments]    ${xpath}
    click    ${xpath}
    #(//*[@id="transaction_credit_approve"])[1]      approve
Verify Status Column
    [Arguments]    ${xpath}
    ${Status}   Browser.Get Text    ${xpath}
    log    ✅ ${Status}

PO_Row_data
    click   //button[@id='purchase_order_item_view_switch']//div[1]
    ${po_num}=  Browser.Get Text    (//a[@id='purchase_order_label'])[1]
    ${item_Name}=  Browser.Get Text    (//span[text()='HR00004'])[1]
    ${vendor_name}=  Browser.Get Text    (//tr[@class='ant-table-row ant-table-row-level-0']//td)[2]
    ${I_date}=  Browser.Get Text    (//tr[@class='ant-table-row ant-table-row-level-0']//td)[3]
    ${po_num}=  Browser.Get Text    (//a[@id='purchase_order_label'])[1]

Click_On_Warehouse
    sleep  2s
    Hover    ${INVENTRY}
    Wait For Load State    domcontentloaded    timeout=60s
    sleep   3s
    click    //a[@id='warehouses']
    Click    //*[@class="header_logo__OwsGs"]   #click manug logo
#    search item in item details searchbox    ${ItemData}[1]
    Wait For Load State    domcontentloaded    timeout=60s
    sleep   3s
    Wait For Elements State   (//*[@id="live_inventory_Item Details_search"])[1]   visible    timeout=30s
    click    (//*[@id="live_inventory_Item Details_search"])[1]
    Fill Text    //input[@placeholder='Search Item Details']   LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK
    click    (//*[@id="live_inventory_Item Details_search"])[2]
    Sleep    2s
    @{data}=  Get Elements    (//tr[@class='ant-table-row ant-table-row-level-0'])[1]
    ${itemName}   Browser.Get Text    (//td[@class="ant-table-cell ant-table-cell-fix-left ant-table-cell-fix-left-last"])[1]   #(//td[@class='ant-table-cell'])[1]
    ${Orderd_Qt}   Browser.Get Text    (//td[@class='ant-table-cell'])[1]   #(//td[@class='ant-table-cell'])[6]
    ${Quantity_number}  Evaluate  ''.join(c for c in "${Orderd_Qt}" if c.isdigit()) if ''.join(c for c in "${Orderd_Qt}" if c.isdigit()) else '0'
    ${integer_value}  Convert To Integer  ${Quantity_number}
    log   ${integer_value}
    log   Item Name = ✅ ${itemName}
    log   Initial Orderd Quantity = ✅ ${integer_value}
    RETURN  ${integer_value}
    
Select From Dropdown
    [Arguments]  ${InputboxXpath}   ${SelectionName}
    input  ${InputboxXpath}  ${SelectionName}
    click  //span[text()='${SelectionName}']

Insert Value
    [Arguments]  ${InputboxXpath}   ${value}
    input  ${InputboxXpath}  ${value}

Search Item in Item Details SearchBox
    [Arguments]    ${ItemName}    ${index1}   ${index2}   ${index3}
    Safely Click Element   (//*[@id="live_inventory_Item Details_search"])[${index1}]
    Fill Text    (//input[@placeholder='Search Item Details'])[${index2}]   ${ItemName}
    sleep   0.05s
    Safely Click Element    (//*[@id="live_inventory_Item Details_search"])[${index3}]
select partner1
    [Arguments]  ${partner}
    Wait For Elements State    //div[@class='ant-select-selection-search']//input[1]    visible    timeout=30s     #(//*[@class="ant-select-selection-search-input"])[4]   visible    timeout=30s
    input  //div[@class='ant-select-selection-search']//input[1]    ${partner}   #(//*[@class="ant-select-selection-search-input"])[4]    AAA    #${partner}
    click   (//Span[text()="${partner}"])[2]
Select Item Code
    [Arguments]  ${item_code}
    input  //input[@id='credit__details__0__sku']  ${item_code}
    click    (//span[text()='${item_code}'])[2]

Select Machine
    [Arguments]    ${Machine_Name}
    input   //input[@id="rc_select_56"]    ${Machine_Name]
    click   //div[text()='${Machine_Name}']

Select Item Code From PO
    [Arguments]  ${index}  ${item_code}  #${Qty}  ${price}
    input  //input[@id='purchase_order_${index}_sku']  ${item_code}
    Wait For Elements State    //span[contains(text(),'${item_code}')]    visible    timeout=30s
    sleep   0.05s
    click    //span[contains(text(),'${item_code}')]

Safely Click Element
    [Arguments]  ${locator}
    # Try to click the element, relocating it if necessary.
    FOR  ${i}  IN RANGE  1  4
        ${result}=  Run Keyword And Ignore Error  Click  ${locator}
        ${status}=  Set Variable  ${result}[0]
        Run Keyword If  '${status}' == 'PASS'  Exit For Loop
        Log  ⚠️ Stale Element Exception. Retrying to click element: ${locator} (Attempt ${i})
        Sleep  1s
    END
    Run Keyword If  '${status}' != 'PASS'  Fail  Failed to click element after 3 attempts: ${locator}

Safely Element Should Be Visible
    [Arguments]  ${locator}  ${timeout}=30s
    # Try to check if the element is visible, relocating it if necessary.
    FOR  ${i}  IN RANGE  1  4
        ${result}=  Run Keyword And Ignore Error  Element Should Be Visible  ${locator}  ${timeout}
        ${status}=  Set Variable  ${result}[0]
        Run Keyword If  '${status}' == 'PASS'  Exit For Loop
        Log  ⚠️ Stale Element Exception. Retrying to check visibility of element: ${locator} (Attempt ${i})
        Sleep  1s
    END
    Run Keyword If  '${status}' != 'PASS'  Fail  Failed to check visibility of element after 3 attempts: ${locator}

Safely Element Should Not Be Visible
    [Arguments]  ${locator}  ${timeout}=30s
    # Try to check if the element is not visible, relocating it if necessary.
    FOR  ${i}  IN RANGE  1  4
        ${result}=  Run Keyword And Ignore Error   Element Should Not Be Visible  ${locator}  ${timeout}
        ${status}=  Set Variable  ${result}[0]
        Run Keyword If  '${status}' == 'PASS'  Exit For Loop
        Log  ⚠️ Stale Element Exception. Retrying to check non-visibility of element: ${locator} (Attempt ${i})
        Sleep  1s
    END
    Run Keyword If  '${status}' != 'PASS'  Fail  Failed to check non-visibility of element after 3 attempts: ${locator}

PO_Status
    ${status1}=  Set Variable  Pending
    ${status2}=  Set Variable  Issued
    Run Keyword If    '${status1}' == 'Pending'    Click    //*[@id="purchase_order_approve"]
    Sleep   1s
    ${status}=  Browser.Get Text   //div[@class="MuiAlert-message css-1xsto0d"]
    Run Keyword If    '${status1}' == 'Pending'    Log To Console    ${status}    ELSE    Log To Console    ${status2}

