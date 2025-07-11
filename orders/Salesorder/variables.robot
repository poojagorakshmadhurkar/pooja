*** Variables ***
${newPO}  //button[@id = "Add New PO"]
${newSO}  //button[normalize-space()='NEW']
${poTab}  //button[@id = "PO Tracker"]
${soTab}  //button[@id = "SO Tracker"]
${customerName}  //span[text() = "Customer Name"]/../../div[3]/div/div[2]/div/input
${poNumber}  //input[@id = "label"]
${poIssueDate}  //span[text() = "PO Issue Date"]/../../div[2]/div/input
${poExpiryDate}  //span[text() = "PO Expiry Date"]/../../div[2]/div/input
${type}  //div[@id = "po_type"]
${saveOrderButton}  //button[text() = "Save Order"]
${planThisOrder}  //div[text() = "Plan This Order"]/..
${createNewOrder}  //div[text() = "Create New Order"]/..
${newSoButton}  //button[text() = "New SO"]
${soStartDate}  //span[text() = "SO Start Date"]/../../../div[2]/div[2]/div/input
${soDeliveryDate}  //span[text() = "SO Delivery Date"]/../../div[2]/div/input
${soTrackerTab}  //button[text() = "SO Tracker"]
${createWo}  //button[text() = " Create WO"]
${woQuantity}  //input[@id = "label"]
${previewWo}  //button[text() = "Preview"]
${Create}  //button[text() = "Create"]
${mrnRequest}  //button[@aria-label = "Material Request"]
${planningDropdown}  //header[@id="manufapp-main-header"]//span[text()="Orders"]
${salesorderoption}  //ul[@id="menu-list-grow"]//a[@id="sales_orders"]
${customerDropdown}  (//div[@id="__next"]//input[@class="ant-select-selection-search-input"])[1]
${refnumber}  //input[@id='cust_ref']
${submit}  //button[@id='__submit']
${backbutton}    (//button[@aria-label="back-button"])[2]
${SOdetailsFilter}  //table//*[@id="sales_order_SO Details_search"]
${Soinputfield}  //input[@placeholder="Search SO Details"]
${EditSobutton}  (//div[normalize-space()='Edit SO'])[1]
${Editbutton}  (//button[normalize-space()='Edit'])[1]
${AddnewRow}  //button[@class='ant-btn ant-btn-default']//span[text()="Add New Rows"]
${Editbackbutton}  //button[@aria-label='back-button']//*[@id="back_btn"]
${SomachinesDropdwon}  //span[text() = "Machine"]/../../div[2]//input
${shiftSo}  //span[text()="Shift"]/../../../../div[3]//input
${salesorderproductiondropdown}  //span[text()="Sales Order"]/../../div[2]//input
${dateentryproduction}  //span[text()="Date"]/../../div//input
${intervalDropdown}  //span[text()="Intervals"]/../../../div[@labelid="select-shift-label"]

${productionreportdropown}  //ul[@id="menu-list-grow"]//a[@id="production_reports"]
${productionDropdown}    //span[normalize-space()='Production']
${RejectedButton}  //button[text()="Rejected Quantity"]
${productionsubmitbutton}  (//div[text()="Submit"])[1]
${productionformsubmitbtn}  (//div[text()="Submit"])[2]
${rejectedsection}  //div[@id="live_inventory_item__tabs-tab-0"]
${rejectedsearchfilter}  (//div[@id="live_inventory_item__tabs-panel-0"]//*[name()='svg'][@id='live_inventory_Item Details_search'])
${rejectedfilterinput}  (//input[@placeholder='Search Item Details'])[1]
${detailedviewbutton}  //button[text()="Detailed View"]
${bookedinventorybutton}  //button[text()=" Book Inventory"]
${BookAllbutton}  //button[text()="Book All"]
${bookrawmaterialtab}  //div[@id="so__book_items__tabs-tab-3"]
${RawmaterialTabSo}   //div[@id="item__tabs-tab-2"]
${closebutton}  //div[normalize-space()='Close SO']
${closereasoninput}  //input[@type="text"]
${deactivatebutton}  //button[text()="Deactivate"]
${PrintSobutton}  //button[normalize-space()='Print SO']//*[name()='svg']
${rejectedreasonfiltersearchbar}  (//*[name()='svg'][@id='live_inventory_Rejection Reason_search'])
${rejectedreasoninputsearch}  (//input[@type="search"])[2]
${uploadCSVbuttonSO}  (//*[name()='svg'][@id='sales_order_upload_csv'])[1]
${uploadbuttonSO}  (//button[normalize-space()='upload file'])[1]
${Sodetailsfield}  //input[@id='meta.details']
${itemviewscrollbar}  //button[@id='sales_order_item_view']