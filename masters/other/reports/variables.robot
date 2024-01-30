*** Variables ***
${addNewReports}  //button[@id='Add New Report']
${reportName}  //input[@id='report__name']
${parameter}  //span[text() = "Parameter"]/../../div[2]/div/div
${frequency}  //input[@id = "report__frequency"]/../..
${scheduledTime}  //input[@id = "scheduled_time"]
${startTime}  //input[@id = "start_time"]
${endTime}  //input[@id = "end_time"]
${Submit}  //button[text() = "Submit"]
${back}  //a[@aria-label = "back-button"]
${filterButton}  //button[@id = "undefined__filterBtn"]
${report_email}  //textarea[@id='report__email']
${reportTitle}  //input[@id = "report_title"]
${shiftDropdown}  //input[@id = "report__shift"]
${edit}  //button[normalize-space()='Edit']
${deactivateReports}  //button[text() = "Deactivate"]