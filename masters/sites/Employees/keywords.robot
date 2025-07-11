*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Library   ../../customkeyword1capitalletter.py
Library  String
Library  Collections
Library  ../RandomEmailLibrary.py
Library  Browser


*** Variables ***

${EMAIL_LENGTH}    8  # Length of the username part of the email
${EMAIL_DOMAIN}   example.com


*** Keywords ***
open Employees page
    click  ${mastersDropdown}
    sleep  1
    Wait For Elements State    ${mastersEmployees}
    click  ${mastersEmployees}
    Reload

employee should be added
    [Arguments]  ${employeeName}  ${Department}  ${Role}  ${Mobile}
    click  (//*[name()='svg'][@id='undefined_Name_search'])[1]
    Click    (//input[@placeholder='Search Name'])[1]
    Fill Text    (//input[@placeholder='Search Name'])[1]  ${employeeName}
    Browser.Press Keys    xpath=(//input[@placeholder='Search Name'])[1]    Enter
    Wait For Elements State    //a[text()="${employeeName}"]


#login for employee
#    open browser  ${url}  chrome
#    maximize browser window
#    input  ${email}  admin@smart.com
#    input  ${password}  271828
#    click  ${signIn}
#    wait until page contains  Masters  10

edit employee
    [Arguments]    ${oldEmployee}
    click  //a[text() = "${oldEmployee}"]
    click  //button[text() = "Edit"]
    Wait For Elements State    //input[@value = "${oldEmployee}"]
#    Press keys  ${Name}  CTRL+A  BACKSPACE  ${newEmployee}
    ${randomnewEmployeeName}=  Generate Random string of name
    Clear Text    ${Name}
    Type Text    ${Name}    ${randomnewEmployeeName}
    ${randomnewEmployeeNumber}=  generate random string  10  [NUMBERS]
    Clear Text   ${mobile}
    Type Text    ${mobile}   ${randomnewEmployeeNumber}
#    Wait Until Page Contains Element  //input[@value = "${EmployeeName}[3]"]
#    press keys  ${mobile}  CTRL+A  BACKSPACE  ${newMobile}
#    Wait Until Page Contains Element  //input[@value = "${EmployeeName}[4]"]
    ${random_email}=    Generate Random Email    ${EMAIL_LENGTH}    ${EMAIL_DOMAIN}
    # Example of using the random email in a test case
    Clear Text     ${employeeEmail}
     Type Text    ${employeeEmail}   ${random_email}
#    press keys  ${employeeEmail}  CTRL+A  BACKSPACE  ${newEmail}
#    Wait Until Page Contains  ${EmployeeName}[1]
#    Wait Until Page Contains  ${EmployeeName}[2]
    select option from dropdown using span  ${Department}  Admin
    select option from dropdown using span  ${Role}  Manager
#    click  (//span[@aria-label="close-circle"])[3]
#    input  ${sites}  //span[text() = ="Metal Unit"]
#    click  (//span[@aria-label="close-circle"])[4]
#    input  ${warehouses}  //span[text() = ="Moulding"]
    click  ${Submit}
    i should see text on page  Employee edited
    open Employees page
    Reload
    employee should be added  ${randomnewEmployeeName}  Admin  Manager  ${randomnewEmployeeNumber}
    delete employee  ${randomnewEmployeeName}
    i should see text on page  Employee deactivated successfully
    employee should be in deactivated slot  ${randomnewEmployeeName}

delete employee
    [Arguments]  ${employeeName}
    click  //a[text() = "${employeeName}"]/../../../../../../../../../td[6]//button
    click  ${deactivate_employee}

employee should be in deactivated slot
    [Arguments]  ${employeeName}
    open Employees page
    Reload
    click  (//*[name()='svg'][@class='MuiSvgIcon-root MuiSvgIcon-fontSizeMedium ant-dropdown-trigger css-vubbuv'])[1]
    click  //div[contains(text(),'Deactivated employees')]

#    employee should be added  ${employeeName}  ${Department}  ${Role}  ${Mobile}
# TO REactivate the Employee


Generate Random string of name
    ${random_string}=  Generate Random String  7  [LOWER]
    ${random_customer_name}=  Capitalize First Letter  ${random_string}
    RETURN  ${random_customer_name}