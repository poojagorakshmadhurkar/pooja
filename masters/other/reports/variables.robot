*** Variables ***
${addNewReports}  //button[@id="undefined_add"]
${reportName}  //input[@id='report__name']
${parameter}  //span[text() = "Parameter"]/../../div[2]/div/div
${frequency}  //input[@id = "report__frequency"]/../..
${scheduledTime}  //input[@id = "scheduled_time"]
${startTime}  //input[@id = "start_time"]
${endTime}  //input[@id = "end_time"]
${Submit}  //button[text() = "Submit"]
${back}  //a[@aria-label = "back-button"]
${filterButton}  (//*[name()='svg'][@id='undefined_Report Title_search'])[1]
${report_email}  //textarea[@id='report__email']
${reportTitle}  //input[@placeholder='Search Report Title']
${shiftDropdown}  (//input[@id='report__shift'])[1]/../../span[2]
${edit}  //button[normalize-space()='Edit']
${deactivateReports}  //button[text() = "Deactivate"]