*** Variables ***
${inwardTab}  //div[@id = "item__tabs-tab-credit"]
${outwardTab}  //div[@id = "item__tabs-tab-debit"]
${stockSummaryTab}  //button[text() = "Stock Summary"]
${selectWarehouseDropdown}  (//span[text() = "Warehouse"]/../../div)[2]
${startDate}  //input[@placeholder = "Start date"]
${endDate}  //input[@placeholder = "End date"]
${refreshTransactions}  //button[@title= "Refresh Transactions"]
${addFilters}  //button[@aria-label = "Add Filters"]
${clearAllFilters}  //button[@aria-label = "Clear All Filters"]
${newInwardNote}  //button[text() = "Inward" and @aria-label = "New Inward Note"]
${newOutwardNote}  //button[text() = "Outward" and @aria-label = "New Outward Note"]
${downloadStockSummary}  //button[@aria-label = "Download Stock Summary"]
${editWarehouse}  //button[@aria-label = "icon-label"]
${itemTypeDropdown}  (//span[text()="Item Type *"])/../../../div[2]/div/span[2]
${inspectedByDropdown}  (//span[text()="Inspected By "])/../../../div[2]/div/span[2]
${inspectedByDropdownTIN}  (//span[text()="Inspected By "])/../../../div[2]/div/span[2]
${grnNumber}  //input[@placeholder = "GRN Number"]
${dropdownofpatner}  (//span[text()="Vendor *"])/../../../div[2]/div/span[2]
${partnerDropdown}  //input[@id = "credit__form__partner"]
${invoiceNumber}  //span[text() = "Invoice Number "]/../../input
${addDetailsInNote}  //div[text() = "Add Details to this Request"]/..
${inwardEdit}  //button[@id = "credit__rejections__edit"]
${rackingEdit}  //button[@id = "credit__racking__edit"]
${addNewItem}  //a[text() = "Add new Item"]
${refereshItemList}  //button[@title = "Refresh Item List"]
${refreshTransactions}  //button[@title ="Refresh Transactions"]
${addNewRows}  //button[text() = "Add New Rows"]
${newRowsCount}  //input[@id= "count"]
${remarks}  //button[text() = "Remarks:"]
${inwardSubmit}  //button[@id = "credit__details__submit"]
${outwardSubmit}  //button[@id = "debit__details__submit"]
${inwardRejSubmit}  //button[@id = "credit__rejections__submit"]
${rackingSubmit}  //button[@id = "credit__racking__submit"]
${cancel}  //button[text() = "Cancel"]
${newRequest}  //div[text() = "New Request"]/..
${addDetailsToThisRequest}  //div[text() = "Add Details to this Request"]/..
${addDetailsToThisitem}  //div[text() = "Add Details to this Item"]/..
${back}  //*[local-name() = "svg" and @data-testid = "KeyboardArrowLeftOutlinedIcon"]/..
${outwardToDropdown}  //span[text() = "Outward to"]/../../../div/div/span[2]
#${reciepientWarehouseDropdown}  (//span[text() = "Recipient Warehouse "]/../../div)[2]
${reciepientWarehouseDropdown}  (//span[text() = "Recipient Warehouse "]/../../../div[2]/div[1]/span[1]/input)
${jobworkVendorDropdown}  (//span[text() = "Jobwork Vendor "]/../../../div[2]/div[1]/span[1]/input)
${jobworkCustomerDropdown}  (//span[text() = "Jobwork Customer "]/../../../div[2]/div[1]/span[1]/input)
${machineDropdown}   (//span[text() = "Machines *"]/../../div[2]/div[1]/span[1]/input)
${smartFactory}  //button[text() = "Smart Factory"]
${1stapprove}  (//button[@aria-label= "Approve"])[1]
${rackingEdit}   //button[@id = "credit__racking__edit"]
${approveButton}  //button[text()= "Approve"]
${approveRequest}  //span[text() = "Approve request"]/..
${InwardGRNfield}  //input[@id = "credit__form__grn"]
${withdrawButton}  //button[normalize-space()='Withdraw Request']
${OutwardGRNfield}  //input[@id = "debit__form__grn"]
${addNewLot}  //button[@aria-label = "new reason"]
${addRack}  //input[@id = "add rack"]
${rackApprove}  //button[@id = "rackApprove"]

${newIcon}  //button[text() = "NEW"]
${itemCode}  //input[@id = "item__label"]
${itemName}  //textarea
#${type}  (//span[text() = "Type"]/../../div)[2]
${itemGroupType}  //input[@id = "item__itemGroup"]/../..
${itemgroup}  (//span[text() = "Item Group"]/../../div)[2]
${back}  //a[@aria-label = "back-button"]
${packSizeTab}  //div[@id = "item__tabs-tab-4"]
${outwardTab}  //button[@id = "Outward"]

${outwardCustomerToDropdown}  //input[@id = "debit__form__recipient"]/../../..
${packSize}  //input[@id = "item__packsize_0"]
${minPack}  //button[text() = "Request Min Pack Size"]
${next}  //button[text() = "Next"]
${nextButton}  //span[text() = "Next"]/..
${shortage}  //tbody/tr[1]/td[7]/span
${scrapTab}  //button[text() = "Scrap"]

#${convName}  //th[text() = "Total Quantity"]/../../../tbody/tr[${i}]/td/div/div/span/input
#${convQuan}  (//th[text() = "Total Quantity"]/../../../tbody/tr[${i}]/td)[2]/span/span/input
${outwardGrn}  //*[@id="enhanced-table-checkbox-0"]
${inwardGrn}  //tbody/tr[2]/th[1]
${crossButton}  /html/body/div[4]/div[3]/div/span/button
${autoSelectRack}  //button[@id = "credit__racking__autofill_rack"]
${itemFilter}  //button[@id ="item__filterBtn"]
${itemDetailsTextBox}  //input[@id = "item_details"]
${newIcon}  //button[text() = "NEW"]
${itemCode}  //input[@id = "label"]
${itemName}  //textarea
${itemGroup}  (//span[text() = "Item Group"]/../../div)[2]
${autoRackTab}  //div[text() ="Racks"]/../..
${addNewAutoRack}  //button[@id ="item_addrackBtn"]
${DateInward1}  //input[@id = "credit__form__DateInward1"]
${DateInward2}  //input[@id = "credit__form__DateInward2"]
${qualityChecktab}  //span[text() = "Quality Check"]/..
${allOk}  //button[@id ="credit__rejections__all_ok"]
${addRejIcon}  //button[@id ="credit__rejections__0__add_reason"]
${RMItemFilter}  //div[@id = "item__tabs-panel-1"]//span[text() = "Item Details"]/../../..//*[@data-testid="SearchOutlinedIcon"]
${RMitemName}  (//input[@placeholder = "Search Item Details"])[1]
${dateOutward}  //span[text() = "Date *"]/../../div[2]/div/input
${buttonSubmit}  //button[@type = "submit"]
${cross}  //*[@data-testid = "CancelIcon"]/..
