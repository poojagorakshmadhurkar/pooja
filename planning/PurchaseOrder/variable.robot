*** Settings ***
Library    SeleniumLibrary

*** Variables ***
#   LOGIN PAGE
${URL}  http://192.46.212.39/signin
${DEVURL}   https://dev.manuf.app/
${BROWSER}  chrome    #Edge
${MANUFAPPLOGO}   //img[@alt="Manufapp Logo"]
${SIGN IN TO YOUR MANUFAPP ACCOUNT}   //h5[text()='Sign in to your ManufApp Account']
${MOBILE OR EMAIL}   mobileEmail
${PASSWORD}   password
${FORGET PASSWORD}   //button[text()='Forgot password?']
${SIGNIN}   //button[text()='Sign In']

#    Dashboard Elements
${MASTERS}   //button[text()='Masters']
${INTELLIGENT MONITORING}   //button[text()='Intelligent Monitoring']
${PRODUCTION}   //button[text()='Production']
${PLANNING}   //button[text()='Planning']
${ORDERS}   //*[text()='Orders']
${INVENTRY}  //span[text()='Inventory']
${JOBWORK}   //button[text()='Jobwork']
${DASHBOARD}  //button[text()='Dashboards']

#   Inventory
${WAREHOUSES}   //a[contains(text(),'Warehouses')]
${TRANSACTIONS}   //a[contains(text(),'Transactions')]
${INWARD_REQUEST}   //a[contains(text(),'Inward Request')]
${VENDOR_PARTNER}   //*[@id="inward__form__partner"]
${ENTER_DELEVERD_QTY}   //input[@id='credit__details__0__quantity']
${REFRESH}   live_inventory_refresh
${REFRESH1}  //button[@title='Refresh Transactions']
${RAW_MATERIAL}  //div[text()='Raw Material']

#    IN planning
${SALES ORDERS}  //*[@id="sales_orders"]
${PURCHASE ORDERS}  //a[.='Purchase Orders']    #id:purchase_orders
${SCHEDULING}   scheduling
${ITEM TRACKER}  item_tracker
${TOOL TRACKER}  tool_tracker
${CONVERSION TRACKER}   conversion_tracker
${EXPECTED PRODUCTION}  expected_production
${MRP}  m_r_p

#   Purchse order page elements
${PURCHASE ORDER TEXT}  //span[text()='Purchase Order']
${REFRESH_ELEMENT_LOCATOR}  //*[@id="purchase_order_refresh"]
${REFRESH PAGE ICON}    (//button[contains(@class,'MuiButtonBase-root MuiIconButton-root')])[2]
${PO HOLE TABLE DATA}   //div[@class="ant-table-container"]
${PO HOLE TABLE DATA2}  //div[contains(@class,'ant-table ant-table-small')]
${LIST OF PO TABLE HEADING ELEMENTS}    xpath:(//div[@class='ant-table-container']//div)[1]
${PO TABLE HEADING ELEMENTS}    (//thead[@class='ant-table-thead'])//th     #-----heading -9
${PO TABLE HEADING ELEMENTS2}   (//div[@class='ant-table-container'])//th       #((//div[contains(@class,'ant-table ant-table-small')]//div)[1])/div[1]
${PO PAGINATION}    //li[@class='ant-pagination-next']/following-sibling::li[1]
${PO PAGINATION 100}    //div[text()='100 / page']

#   Vender coulmn
${PO TABLE HEADING ELEMENTS2}   (//div[@class='ant-table-container'])//th       #((//div[contains(@class,'ant-table ant-table-small')]//div)[1])/div[1]
${PO NUMBER COLUMN DATA LIST}   //a[@id='purchase_order_label']
${ITEM DETAILS COLUMN DATA}     //td[@class="ant-table-cell"][1]
${ORDERD COLUMN DATA}   //td[@class="ant-table-cell"][2]
${DELIVERED COLUMN DATA}    //td[@class="ant-table-cell"][3]
${REJECTED COLUMN DATA}     //td[@class="ant-table-cell"][4]
${REMAINING COLUMN DATA}    //td[@class="ant-table-cell"][5]
${VENDER COLUMN DATA}  //td[@class="ant-table-cell"][6]
${ISSUE DATE COLUMN DATA}   //td[@class="ant-table-cell"][7]
${ISSUE DATE COLUMN LIST}   //td[@class="ant-table-cell"][2]
${DELIVERY DATE COLUMN DATA}    //td[@class="ant-table-cell"][8]
${DELIVERY DATE COLUMN DATA2}    //td[@class="ant-table-cell"][3]
${PRICE COLUMN DATA}    //td[@class="ant-table-cell"][9]
${CREATED BY COLUMN DATA}   //td[@class="ant-table-cell"][10]
${STATUS COLUMN LIST}   //td[@class="ant-table-cell"][11]
${VENDER COLUMN DATA1}   xpath:(//td[contains(@class,'ant-table-cell ant-table-column-sort')])
${VENDER COLUMN DATA2}   (//td[@class='ant-table-cell ant-table-column-sort'])

${SORTING CARET-UP}   (//span[@aria-label='caret-up'])[1]
${SORTING CARET-DOWN}   (//span[contains(@class,'anticon anticon-caret-down')])[1]
${SORTING kEY}      //span[@class="ant-table-column-sorter-inner"][1]

${SORT_PO}  (//span[@class='ant-table-column-sorter-inner'])[1]
${SORT_ITEM_DETAILS}    (//span[@class='ant-table-column-sorter-inner'])[2]
${SORT_VENDER}  (//span[@class='ant-table-column-sorter-inner'])[3]
${SORT_ISSUE_DATE}  (//span[@class='ant-table-column-sorter-inner'])[4]
${SORT_DELIVERY_DATE}   (//span[@class='ant-table-column-sorter-inner'])[5]


${SORT_PO1}      //span[text()='PO Number']
${SORT_VENDER1}      //span[text()='Vendor']
${SORT_ISSUE_DATE1}      //span[text()='Issue Date']f
${SORT_DELIVERY_DATE1}   //span[text()='Delivery Date']
${SORT_ITEM_DETAILS1}    //span[text()='Item Details']   #(//span[@aria-label='caret-up'])[2]

#   PO search icon related xpath
${SEARCH ICON}      id:purchase_order_PO Number_search
${SEARCH ICON INPUT FIELD}   //input[@placeholder='Search PO Number']
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
${PAGE TEXT CHECK}    //h5[text()='Sign in to your ManufApp Account']
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
${BACK}   (//button[@aria-label='back-button'])[2]
${BACK3}   //button[@aria-label='back-button']
${BACK2}    //*[@id='back_btn']
${SELECT_VENDOR_NAME}   (//span[text()='${Vendor-Name}'])
${CREATE_NEW_BUTTON}   //a[.='NEW']
${SELECT_ITEMTYPE}  (//span[@class='ant-select-selection-item'])[1]

#************** FOR ALL Script **********************
${Item_Type}    FG
${Vendor-Name}  Bajaj
${targetDate}   Jun2024
${dateValue}    //div[text()='${D_value}']
${D_value}  11
${Item_Code}    A000
${D_Date}    27-07-2024

#************** FOR ALL Script **********************

#   SO PAGE ELEMENTS
${SO_ITEMCODE_LIST}     (//div[@class='rc-virtual-list-holder-inner'])[1]
#   Item Type
${ITEM TYPE}    (//div[@class='rc-virtual-list-holder-inner'])[3]
${VENDOR LIST}  (//div[@class='rc-virtual-list-holder-inner'])[2]
#${ITEM CODE1}    (//div[contains(@class,'ant-select-dropdown ant-select-dropdown-placement-bottomLeft')])[1]
                #(//div[@class='rc-virtual-list-holder']//div)[2]
${ITEM CODE}    //input[@id='purchase_order_0_sku']
#${Vendor}  //span[text()//a[contains(text(),'Transactions')]='Newvendortest02']
${vendorselectiondropdown}  //input[@id="purchase_order_vendor"]
${PO_ORDER_DETAIL}  //*[@id='purchase_order_details'][1]
${ITEM_VIEW_TOGGLE_BUTTON}    //*[@id='purchase_order_item_view_switch']

#${INWARD_REQUEST}   //a[.='Inward Request']
${PO_inward_row}    //tr[@data-row-key='3']
${inward_note_msg}    //div[text()='Inward note created Successfully']
${submit}   //button[@type='submit']
${SUBMIT2}   (//button[@type='submit'])[2]

${SUBMIT1}   (//button[text()='Submit'])[1]
${SUBMIT5}  (//button[text()='Submit'])[3]
${SUBMIT3}   credit__rejections__submit
${SUBMIT4}  //span[text()='Submit']


${BACK1}   (//*[@id='back_btn'])[2]


${move to top}  //button[text()='Move to Top']
${checkbox}    (//input[@type="checkbox"])[1]
${Auto_fill}    //button[text()='AutoFill']
${withdraw-Status}   (//span[text()='Withdrawn'])[1]
${inward_button}  (//*[@id='purchase_order_inward'])[1]
${invoice_number}   //input[@id='credit__form__invoice_number']
${truck_number}   //input[@id='credit__form__truck_number']
${partnerdropdown}  (//*[@class="ant-select-selection-search-input"])[4]
${INWARD_ICON}   purchase_order_inward

#    REJECTION AND SCRAP
${GRN_SEARCH}   (//*[@id="transaction_GRN_search"])[1]
${GRN_SEARCH_INPUT_BOX}   //input[@placeholder='Search GRN']
${GRN_SEARCH_INPUT_BOX2}    (//*[@id="transaction_GRN_search"][1])[2]
${PERFORM_IQC}  //a[contains(text(),'Perform IQC')]
#${IQC_PENDING}  //a[contains(text(),'${GRN_No}')]/../../../..//td[10]    #//span[text()='IQC Pending'])[1]
${MRN_APPROVE_NOTE}   //div[text()='MRN approved SuccesFully']
${REJECTION_QTY2}    //span[text()='4 kg']
${OUTWARD}  //div[text()='Outward']
${CLICK_ON_ROW}    (//tr[@class="ant-table-row ant-table-row-level-0"])[11]//td[3]
${CLICK_ON_ROW1}    (//tr[@class="ant-table-row ant-table-row-level-0"])[3]//td[3]
${REWORK_INPUTBOX}  (//input[@id="rejected__Quantity_0"])[2]
${REWORK}   (//*[@text="Rework"])[11]
${CLICK_PARTNER_SEARCH_ICON1}   (//*[@id="live_inventory_Partner_search"])[2]
${CLICK_PARTNER_SEARCH_ICON2}   (//*[@id="live_inventory_Partner_search"])[3]
${CLICK_PARTNER_INPUT_BOX}  (//div[@class='ant-select-selection-overflow'])[1]
${ITEM_DETAILS_SEARCHBOX}   (//*[@id="live_inventory_Item Details_search"])[2]
${DETAILS_VIEW}   //button[text()='Detailed View']
${REJECTED}   //div[text()='Rejected']
${REJECTION_QTY}    //*[@data-row-key="124581"]//td[5]      #//span[text()='2 kg']
${REFRESH2}  //button[@title='Refresh Live Inventory']
${APPROVE}  (//button[@icon='[object Object]'])[3]
${TRANSACTION_NOTE}   //div[text()='Transaction Edited SuccesFully']
${REJECTION_INPUTBOX}   credit__rejections__0__0__quantity
${REJECTION_REASON}   //input[@id="credit__rejections__0__0__reason"]
${NO_REJECTION}     //span[text()='No Rejections']
${IQC_PENDING}  //a[contains(text(),'GR24GRN-0723')]/../../../..//td[10]


${GRN_No1}   (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[1]
${GRN_No2_TEXT}  (//div[contains(@class,'MuiGrid-root MuiGrid-item')]//span)[3]
${inward_note_txt}  xpath://div[contains(@style, 'text-align: center;')]
${TRANSACTION_STATUS}   (//tr[@class='ant-table-row ant-table-row-level-0'])[1]//td[10]
${ACTION_BUTTON}    //*[@id="transaction_credit_approve"]
#${ACTION_BUTTON2}   //div[@id='item__tabs-panel-debit']//button//*[name()="svg"][@id="transaction_debit_approve"][1]
${IQC_PENDING1}   (//span[text()='IQC Pending'])[1]
${EDIT}     credit__rejections__edit
${ALL_OK}   credit__rejections__all_ok
${ADD_NEW_ROW}  //*[@id="purchase_order_add_new_rows"]
${+ICON}    //*[@id="purchase_order_add_sku"]
${ENTER_ITEM}   //input[@id="purchase_order_scan_items"]
${SELECT_ITEMS}     //span[text()='Select Items']
${LIVE_INVENTORY_ORDERED}   (//div[@id='live_inventory_ordered'])[1]
${WITHDRAW}     (//*[name()='svg'][@id='purchase_order_withdraw '])
${ITEM_DETAILAS_INPUTFIELD}    //input[@placeholder='Search Item Details']
${ITEM_DETAILS_SEARCH_ICON}     (//*[@id="live_inventory_Item Details_search"])[3]
${PARTNER_NAME}  (//td[text()='Newvendortest01'])[2]
${ENTER_REJECTED_QTY}   (//input[@id='rejected__Quantity_6'])[2]
${REWORK_ALL}   (//button[text()='Rework All'])[3]
${REJECTED_QTY}     (//*[@class="ant-table-row ant-table-row-level-0"])[11]//td[9]
#${VERIFY_ORDER_NO}      //a[text()="${order_number}"]
#${VERIFY_VENDOR}    //span[text()="${Vendor}[0]"]
#${DATE}    //span[text()="${date}[0]"]
#${ITEN_NAME}   //span[text()='${ItemData}[1]']
#${ORDERED_QTY}    (//td[text()='${ItemData}[2] kg'])[1]
${INWARD}   (//*[@id="purchase_order_inward"])[1]

${SCROLL}       Execute JavaScript  document.evaluate("(//div[@class='ant-table-body'])[2]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollLeft = document.evaluate("(//div[@class='ant-table-body'])[2]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollWidth;

