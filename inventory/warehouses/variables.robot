*** Variables ***
${filter}  //*[@data-testid="MoreVertIcon"]/..
${reconcileinventory}  //div[text() = "Reconcile Inventory"]
${fileupload}  //button[@id="undefined__upload_file_btn"]
${warehouseFilter}  //span[@role="button"][1]
${warehouseFilterItemName}  //input[@placeholder='Search Item Details']
${searchicon}  //button[@class='ant-btn ant-btn-circle ant-btn-primary ant-btn-sm ant-btn-icon-only']//*[name()='svg']
${dateOutward}  //span[text() = "Date *"]/../../div[2]/div/input
${inventorybutton}  //button[normalize-space()='Inventory']
${Transactiobutton}  (//a[normalize-space()='Transactions'])[1]
${outwardtab}  //div[@id='item__tabs-tab-debit']
${inwardtab}  //div[@id='item__tabs-tab-credit']
${formbutton}  //button[normalize-space()='Form']
${uploadbutton}  //button[@id="undefined__upload_file_btn"]
