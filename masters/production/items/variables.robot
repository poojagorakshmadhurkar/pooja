*** Variables ***
${itemGroupHeader}  //h5[text() = "Item Group"]/..
${newIcon}  //button[text() = "NEW"]
${itemGroupname}  //input[@id = "itemGroup__label"]
${itemType}  //span[text() = "Item Type"]/../../span/div
${units}  //span[text() = "Unit"]/../../div[2]
${sites}  (//span[text() = "Sites"]/../../div)[2]
${saveForm}  //button[text() = "Save Form"]
${back}  //a[@aria-label = "back-button"]
${itemGroupDropdown}  (//span[text() = "Item Group"]/../../div)[2]
${itemgroup}  (//span[text() = "Item Group"]/../../div)[2]
${itemCode}  //input[@id = "item__label"]
${itemName}  //textarea[@id = "item__itemName"]
${type}  (//span[text() = "Type"]/../../div)[2]
${image}  //input[@placeholder = "Image Url"]
${Submit}  //button[text() = "Submit"]
${backButton}  //button[@type='button']//button[@aria-label='back-button']//*[name()='svg']
${addAttribute}  //button[@id = "itemGroup__addAttributeBtn"]
${itemFilters}  //button[@aria-label="Add Filters"]
${editBom}  (//span[text() = "012"]/../../../../../../../../../../td/div/button)[1]
${addBom}  //button[text()="Add BOM"]
${bomQuantity}  //input[@id="bom__quantity"]
${inputItemBom}  (//input[@id="rawMaterialBom__selectItem"])
${setSelfTag}  //input[@id = "itemGroup__selfTag"]/..
${setNomenclature}   //input[@id = "itemGroup__addNomenclature"]/..
${codePrefix}  //input[@id = "itemGroup__label__prefix"]
${namePrefix}  //input[@id = "itemGroup__description__prefix"]
${nameSeparator}  //input[@id = "itemGroup__description__seperator"]
${inBomNameQuantity}  (//input[@id="rawMaterial__quantity"])
${submitBom}  //button[@id="bom__submitBtn"]
${submitButtonIdCsv}  //button[@id="item__uploadCsvBtn"]
${itemGroupDropdownCsv}  //div[@id="item__upload_csv_group"]
${itemUploadCsv}  (//button[@id="undefined__upload_file_btn"])[3]
${selectItemGroup}  //input[@id="rc_select_1"]/../..
#${getLastPage}  //div[@title="10 / page"]/../div[last()]
${deactivate_itemGroup}  //button[@id='itemGroup__deactivate_btn']
${deactivate_item}  //button[@id='item__deactivate_btn']
${Edit}  //button[normalize-space()='Edit']
${searchItem}  //input[@placeholder='Search Item Details']

