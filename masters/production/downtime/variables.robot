*** Variables ***
${addNewDowntime}  //button[text() = "NEW"]
${downtimeName}  //input[@id = "downtime__label"]
${downtimeTags}  //input[@id = "downtime__tags"]
${downtimeDepartment}  //div[@name="department"]
${downtimeSeverity}  //div[@name="severity"]
${downtimeBlame}  //div[@name="blame"]
${downtimeNature}  //div[@name="nature"]
${Submit}  //button[text() = "Submit"]
${back}  //a[@aria-label = "back-button"]
${allIssues}  //div[text()="All Issues "]
${deactivate_downtime}  //tbody/tr[1]/td[7]/div[1]/button[1]//*[name()='svg']
${deactivate_button}  //button[@id='downtime__deactivate_btn']

