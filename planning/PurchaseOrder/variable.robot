*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}  http://192.46.212.39/signin?path=/masters/sites
${BROWSER}  chrome    #Edge
${MANUFAPPLOGO}     xpath://img[@alt="Manufapp Logo"]
${SIGN IN TO YOUR MANUFAPP ACCOUNT}     xpath://h5[text()='Sign in to your ManufApp Account']
${MOBILE OR EMAIL}      id:mobileEmail
${PASSWORD}     name:password
${FORGET PASSWORD}      xpath://button[text()='Forgot password?']
${SIGNIN}       xpath://button[text()='Sign In']

#    Dashboard Elements
${MASTERS}   xpath://button[text()='Masters']
${iNTELLIGENT MONITORING}   xpath://button[text()='Intelligent Monitoring']
${PRODUCTION}   xpath://button[text()='Production']
${PLANNING}     xpath://button[text()='Planning']
${INVENTRY}     xpath://button[text()='Inventory']
${JOBWORK}      xpath://button[text()='Jobwork']
${DASHBOARD}    xpath://button[text()='Dashboards']

#    IN planning
${SALES ORDERS}  id:sales_orders
${PURCHASE ORDERS}  id:purchase_orders
${SCHEDULING}    id:scheduling
${ITEM TRACKER}    id:item_tracker
${TOOL TRACKER}     id:tool_tracker
${CONVERSION TRACKER}   id:conversion_tracker
${EXPECTED PRODUCTION}  id:expected_production
${MRP}  id:m_r_p

#   Purchse order page elements
${PURCHASE ORDER TEXT}  xpath://span[text()='Purchase Order']
${REFRESH_ELEMENT_LOCATOR}  xpath:(//*[name()='path'])[11]
${REFRESH PAGE ICON}    xpath:(//button[contains(@class,'MuiButtonBase-root MuiIconButton-root')])[2]
${PO HOLE TABLE DATA}   xpath://div[@class="ant-table-container"]
${PO HOLE TABLE DATA2}  xpath://div[contains(@class,'ant-table ant-table-small')]
${LIST OF PO TABLE HEADING ELEMENTS}    xpath:(//div[@class='ant-table-container']//div)[1]
${PO TABLE HEADING ELEMENTS}    (//thead[@class='ant-table-thead'])//th     #-----heading -9
${PO TABLE HEADING ELEMENTS2}   (//div[@class='ant-table-container'])//th       #((//div[contains(@class,'ant-table ant-table-small')]//div)[1])/div[1]
${PO PAGINATION}    //li[@class='ant-pagination-next']/following-sibling::li[1]
${PO PAGINATION 100}    //div[text()='100 / page']

#   Vender coulmn
${PO TABLE HEADING ELEMENTS2}   (//div[@class='ant-table-container'])//th       #((//div[contains(@class,'ant-table ant-table-small')]//div)[1])/div[1]
${PO NUMBER COLUMN DATA LIST}     id:purchase_order_label
${ITEM DETAILS COLUMN DATA}     //td[@class="ant-table-cell"][1]
${ORDERD COLUMN DATA}   //td[@class="ant-table-cell"][2]
${DELIVERY COLUMN DATA}     //td[@class="ant-table-cell"][3]
${REJECTED COLUMN DATA}     //td[@class="ant-table-cell"][4]
${REMAINING COLUMN DATA}    //td[@class="ant-table-cell"][5]
${VENDER COLUMN DATA}  //td[@class="ant-table-cell"][6]
${ISSUE DATE COLUMN DATA}   //td[@class="ant-table-cell"][7]
${ISSUE DATE COLUMN LIST}   //td[@class="ant-table-cell"][2]
${DELIVERY DATE COLUMN DATA}    //td[@class="ant-table-cell"][8]
${PRICE COLUMN DATA}    //td[@class="ant-table-cell"][9]
${CREATED BY COLUMN DATA}   //td[@class="ant-table-cell"][10]
${STATUS COLUMN LIST}   //td[@class="ant-table-cell"][11]

${VENDER COLUMN DATA1}   xpath:(//td[contains(@class,'ant-table-cell ant-table-column-sort')])
${VENDER COLUMN DATA2}   (//td[@class='ant-table-cell ant-table-column-sort'])

${SORTING CARET-UP}   xpath:(//span[contains(@class,'anticon anticon-caret-up')])[1]
${SORTING CARET-DOWN}   xpath:(//span[contains(@class,'anticon anticon-caret-down')])[1]
${SORTING kEY}      xpath://span[@class="ant-table-column-sorter-inner"][1]

${SORT_PO}      xpath://span[text()='PO Number']
${SORT_VENDER}      xpath://span[text()='Vendor']
${SORT_ISSUE_DATE}      xpath://span[text()='Issue Date']
${SORT_DELIVERY_DATE}   xpath://span[text()='Delivery Date']

#   PO search icon related xpath
${SEARCH ICON}      id:purchase_order_PO Number_search
${SEARCH ICON INPUT FIELD}   xpath://input[@placeholder='Search PO Number']
${CLICK ON SEARCH ICON}     //input[@class='ant-input']/following-sibling::button[1]  #--intenal click icon
${ENTER SEARCH TEXT}   Suraj

@{SRSHDATA}      PO-131  PO-130  PO-129  PO-128  PO-127  PO-126  PO-125  PO-00056    PO-00055    PO-00053    PO-00054    PO-124  PO-00052    PO-00051    PO-00050    PO-123  PO-122  PO-121

#   Vendor search icon related xpath
${Vendor SEARCH ICON}   (//span[@role='button'])[2]
${Vendor SEARCH ICON INPUT FIELD}   (//div[@class='ant-select-selector'])[2]
${Vendor SEARCH ICON INPUT FIELD1}    (//div[@class='ant-select-selector']//div)[1]
${Vendor CLICK ON SEARCH ICON}  (//button[contains(@class,'ant-btn ant-btn-circle')])[2]
${Vendor ENTER SEARCH TEXT}     (//div[contains(@class,'ant-select ant-select-multiple')]//div)[1]
${Vendor div List}  (//div[@class='rc-virtual-list-holder']//div)


${newPO}  //button[@id = "Add New PO"]
${newSO}  //button[normalize-space()='NEW']
${poTab}  //button[@id = "PO Tracker"]
${soTab}  //button[@id = "SO Tracker"]
${purchaseorderdropdown}  //ul[@id="menu-list-grow"]//a[@id="purchase_orders"]
${vendordropdown}  (//div[@id="__next"]//input[@class="ant-select-selection-search-input"])[2]

@{customername}  Cust-003
@{itemData1}  09170_G  100
@{vendor}  Vendor 5



#PO_Crreation_
${PO_VendorDropdown}    (//span[@class='ant-select-selection-item'])[2]
${PAGE TEXT CHECK}  //h5[text()='Sign in to your ManufApp Account']
${ISSUE_DATE_CALENDER}     (//input[@placeholder='Select date'])[1]
${DELIVERY_DATE_CALENDER}   (//input[@placeholder='Select date'])[2]
${CURRENT_DATE}     //a[contains(text(),'Today')]
${ITEM_CODE}    (//span[@class='ant-select-selection-item'])[3]
${ITEM_CODE_List}   (//div[@class='rc-virtual-list-holder-inner'])[1]


${PO_HOLE_PAGE_HIGHLIGHT}   (//div[contains(@class,'ant-table ant-table-small')]//div)[1]


${INPUT_QUANTITY}   (//input[@class='ant-input'])[2]
${INPUT_PRICE}  (//input[@class='ant-input'])[3]
${INPUT_QUANTITY_M}   (//input[@class='ant-input'])
${INPUT_PRICE_M}  (//input[@class='ant-input'])
${VERIFY_TEXT}  //*[contains(text(),' has been created!')]
${BACK}     (//button[@aria-label='back-button'])[2]
${BACK2}    //*[@id='back_btn']
${SUBMIT}   //button[@type='submit']
${SELECT_VENDOR_NAME}   (//span[text()='${Vendor-Name}'])
${CREATE_NEW_BUTTON}   //a[.='NEW']
${SELECT_ITEMTYPE}  (//span[@class='ant-select-selection-item'])[1]

${Item_Type}    FG
${Vendor-Name}  Bajaj
${targetDate}   Jun2024
${dateValue}    //div[text()='${D_value}']
${D_value}  11
${Item_Code}    A000
${Date}    25


#SO PAGE ELEMENTS
${SO_ITEMCODE_LIST}     (//div[@class='rc-virtual-list-holder-inner'])[1]


#Item Type
${ITEM TYPE}    (//div[@class='rc-virtual-list-holder-inner'])[3]
${VENDOR LIST}  (//div[@class='rc-virtual-list-holder-inner'])[2]
#${ITEM CODE1}    (//div[contains(@class,'ant-select-dropdown ant-select-dropdown-placement-bottomLeft')])[1]
                #(//div[@class='rc-virtual-list-holder']//div)[2]
${ITEM CODE}    //input[@id='purchase_order_0_sku']
#${Vendor}  //span[text()='Newvendortest02']
${vendorselectiondropdown}  //input[@id="purchase_order_vendor"]
${PO_ORDER_DETAIL}  //*[@id='purchase_order_details'][1]
${ITEM_VIEW_TOGGLE_BUTTON}    //*[@id='purchase_order_item_view_switch']


${PO_inward_row}    //tr[@data-row-key='3']
${inward_note_msg}  //div[text()='Inward note created Successfully']
${submit}   //button[@type='submit']
${move to top}  //button[text()='Move to Top']
${checkbox}    (//input[@type="checkbox"])[1]
${Auto_fill}    //button[text()='AutoFill']
${withdraw-Status}   (//span[text()='Withdrawn'])[1]
${inward_button}  (//*[@id='purchase_order_inward'])[1]
${invoice_number}   //input[@id='credit__form__invoice_number']
${truck_number}   //input[@id='credit__form__truck_number']
