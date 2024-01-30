*** Variables ***
${newButton}  //button[@id = "Add New Site"]
${siteName}  //input[@id = "site__label"]
${siteAddress}  //input[@id = "site__address"]
${siteEmail}  //input[@id = "site__email"]
${siteCountry}  //span[text() = "Country"]/../../../div[2]/div
#${siteCountry}  //span[normalize-space()='Country']
${siteState}  //span[text() = "State"]/../../../div[2]/div
${siteCity}  //span[text() = "City"]/../../../div[2]/div
${Gstnname}  //input[@id='site__gstin']
${woInProTrue}  //input[@id = "site__wo_true_checkbox"]/..
${costingTrue}  //input[@id = "site__costing_true_checkbox"]/..
${mrnToIssueTrue}  //input[@id = "site__mrn_issue_true_checkbox"]/..
${bundleTrue}  //input[@id = "site__bundle_tracking_true_checkbox"]/..
${rackTrue}  //input[@id = "site__rackTrackingTrueCheckbox"]/..
${woInProFalse}  //input[@id = "site__wo_false_checkbox"]/..
${costingFalse}  //input[@id = "site__costing_false_checkbox"]/..
${mrnToIssueFalse}  //input[@id = "site__mrn_issue_false_checkbox"]/..
${bundleFalse}  //input[@id = "site__bundleTrackingFalseCheckbox"]/..
${rackFalse}  //input[@id = "site__rackTrackingFalseCheckbox"]/..
${Submit}  //button[@id = "site__submitBtn"]
${back}  //a[@aria-label = "back-button"]
${site_deactivate}  //button[text() = "Deactivate"]
${Edit}  //button[text() = "Edit"]





