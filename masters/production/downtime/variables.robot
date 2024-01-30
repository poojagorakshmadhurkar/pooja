*** Variables ***
${addNewDowntime}  //button[text() = "NEW"]
${downtimeName}  //input[@id = "downtime__label"]
${downtimeTags}  //input[@id = "downtime__tags"]
${downtimeDepartment}  //div[@id = "downtime__department"]
${downtimeSeverity}  //div[@id = "downtime__severity"]
${downtimeBlame}  //div[@id = "downtime__blame"]
${downtimeNature}  //div[@id = "downtime__nature"]
${Submit}  //button[text() = "Submit"]
${back}  //a[@aria-label = "back-button"]
${allIssues}  //div[@aria-label = "scrollable auto tabs example"]/button[2]
${deactivate_downtime}  //tbody/tr[1]/td[7]/div[1]/button[1]//*[name()='svg']
${deactivate_button}  //button[@id='downtime__deactivate_btn']

