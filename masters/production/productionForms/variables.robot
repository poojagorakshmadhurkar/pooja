*** Variables ***
${addNewproductionForm}  (//button[normalize-space()='NEW'])[1]
${title}  //input[@id='customForm__label']
${groupBy}  //span[text() = "Group By"]/../../div[2]/div
${addMoreLabel}  //button[@id='customForm__addMoreLabelBtn']
${Submit}  //button[text() = "Submit"]
${productioneditbuton}  //button[@id='__edit']
${back}  //a[@aria-label = "back-button"]
${deactivate_productionForm}  //button[@id = 'customForms__deactivate_btn']
${Type}  //span[normalize-space()='Type']/../../div[2]