*** Variables ***
${addNewEmployee}  //button[@id="undefined_add"]
${Name}  //input[@id = "employee__name"]
${mobile}  //input[@id = "employee__mobile"]
${employeeEmail}  //input[@id = "employee__email"]
${department}  //input[@id = "employee__department"]/../..
${role}  //input[@id = "employee__role"]/../..
#${sites}  (//span[text() = "Sites"]/../../div)[2]
${sites}  //div[@name='site_ids']//div[@class='ant-select-selection-overflow']
${warehouse}  //div[@name='warehouses']//div[@class='ant-select-selection-overflow']
${Submit}  //button[@id = "employee__submitBtn"]
${back}  //a[@aria-label = "back-button"]
${deactivate_employee}  //button[text() = "Deactivate"]
${siteIcon}  //div[@id = "long-menu"]/span
${logout}  //li[text() = "Logout"]

