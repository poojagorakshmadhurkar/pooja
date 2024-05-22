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
${planningDropdown}  //button[text()="Planning"]
${salesorderoption}  //ul[@id="menu-list-grow"]//a[@id="sales_orders"]
${customerDropdown}  (//div[@id="__next"]//input[@class="ant-select-selection-search-input"])[1]
${refnumber}  //input[@id='cust_ref']
${submit}  //div[@id="__next"]//button[text()="Submit"]
${backbutton}  //button[@aria-label="back-button"]
${SOdetailsFilter}  //table//*[@id="sales_order_SO Details_search"]
${Soinputfield}  //input[@placeholder="Search SO Details"]
${EditSobutton}  //button[normalize-space()='Edit SO']
${Editbutton}  //button[text()="Edit"]
${AddnewRow}  //button[@class='ant-btn ant-btn-default']//span[text()="Add New Rows"]
${Editbackbutton}  //button[@aria-label='back-button']//*[@id="back_btn"]
${SomachinesDropdwon}  //span[text() = "Machine"]/../../div[2]//input
${shiftSo}  //span[text()="Shift"]/../../../../div[3]//input
${salesorderproductiondropdown}  //span[text()="Sales Order"]/../../div[2]//input
${dateentryproduction}  //span[text()="Date"]/../../div//input
${intervalDropdown}  //span[text()="Intervals"]/../../../div[@labelid="select-shift-label"]
${loaderinterval}  xpath=//div[@class='ant-select ant-select-single ant-select-allow-clear ant-select-show-arrow ant-select-loading ant-select-open ant-select-show-search']/span[@class='ant-select-arrow ant-select-arrow-loading']/span[@role='img' and @aria-label='loading']
${productionreportdropown}  //ul[@id="menu-list-grow"]//a[@id="production_reports"]
${productionDropdown}    //button[text()="Production"]
${RejectedButton}  //button[text()="Rejected Quantity"]
${productionsubmitbutton}  (//button[text()="Submit"])[1]
${productionformsubmitbtn}  (//button[text()="Submit"])[2]
${rejectedsection}  //div[@id="live_inventory_item__tabs-tab-0"]
${rejectedsearchfilter}  (//div[@id="live_inventory_item__tabs-panel-0"]//*[name()='svg'][@id='live_inventory_Item Details_search'])
${rejectedfilterinput}  (//input[@placeholder='Search Item Details'])[1]
${detailedviewbutton}  //button[text()="Detailed View"]
${bookedinventorybutton}  //button[text()=" Book Inventory"]
${BookAllbutton}  //button[text()="Book All"]