*** Variables ***
${addNewVendor}  //button[text() = "NEW"]
${vendorName}  //input[@id = "partner__name"]
${typeOfPartner}  //span[text() = "Type"]/../../../div[2]/div/span[2]
${vendorEmail}  //input[@name = "email"]
${vendorAddress}  //input[@name = "address"]
${vendorCountry}  //span[text() = "Country"]/../../../div[2]/div/span[2]
${vendorState}  //span[text() = "State"]/../../../div[2]/div/span[2]
${vendorCity}  //span[text() = "City"]/../../../div[2]/div/span[2]
${vendorGSTN}  //input[@id='partner__gstin']
${savePartner}  //button[text() = "Save Partner"]
${back}  //a[@aria-label = "back-button"]
${deactivate_vendor}  //button[@id = "vendors__deactivate_btn"]
${Submit}  //button[text() = "Submit"]
${newRequest}  //div[text() = "Create New"]/..