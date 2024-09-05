*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Library   ../../customkeyword1capitalletter.py
Library  String
Library  Collections
Library  ../RandomEmailLibrary.py



*** Variables ***

${EMAIL_LENGTH}    8  # Length of the username part of the email
${EMAIL_DOMAIN}   example.com


*** Keywords ***
open Employees page
    click  ${mastersDropdown}
    sleep  1
    click  ${mastersEmployees}
    reload page

employee should be added
    [Arguments]  ${employeeName}  ${Department}  ${Role}  ${Mobile}
    click  //button[@id='employee__filterBtn']

    press keys  //input[@id='name']  CTRL+A  BACKSPACE
    input  //input[@id='name']  ${employeeName}

#    press keys  (//span[contains(text(),'Mobile')])[1]  CTRL+A  BACKSPACE
#    input  (//span[contains(text(),'Mobile')])[1]  ${Mobile}
#
#    press keys  (//span[contains(text(),'Email')])[1]  CTRL+A  BACKSPACE
#    input  (//span[contains(text(),'Email')])[1]  ${Email}

    wait until page contains element  //a[text()="${employeeName}"]/../../../../../../../../../../td[1][text()="${Department}"]/../td[2][text()="${Role}"]/../td[3][text()="${Mobile}"]  timeout=15s



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
    sleep  3
    click  //button[text() = "Edit"]
    sleep  5
    Wait Until Page Contains Element  //input[@value = "${oldEmployee}"]
#    Press keys  ${Name}  CTRL+A  BACKSPACE  ${newEmployee}
    ${randomnewEmployeeName}=  Generate Random string of name
    Press keys  ${Name}  CTRL+A  BACKSPACE  ${randomnewEmployeeName}
    ${randomnewEmployeeNumber}=  generate random string  10  [NUMBERS]
    Press keys  ${mobile}  CTRL+A  BACKSPACE  ${randomnewEmployeeNumber}
#    Wait Until Page Contains Element  //input[@value = "${EmployeeName}[3]"]
#    press keys  ${mobile}  CTRL+A  BACKSPACE  ${newMobile}
#    Wait Until Page Contains Element  //input[@value = "${EmployeeName}[4]"]
    ${random_email}=    Generate Random Email    ${EMAIL_LENGTH}    ${EMAIL_DOMAIN}
    # Example of using the random email in a test case
    press keys    ${employeeEmail}  CTRL+A  BACKSPACE   ${random_email}
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
    reload page
    sleep  5
    employee should be added  ${randomnewEmployeeName}  Admin  Manager  ${randomnewEmployeeNumber}
    delete employee  ${randomnewEmployeeName}
    i should see text on page  Employee deactivated successfully
    employee should be in deactivated slot  ${randomnewEmployeeName}

delete employee
    [Arguments]  ${employeeName}
    click  //a[text() = "${employeeName}"]/../../../../../../../../../../td[5]/div/button
    click  ${deactivate_employee}

employee should be in deactivated slot
    [Arguments]  ${employeeName}
    open Employees page
    reload page
    sleep  3
    click  (//*[name()='svg'][@class='MuiSvgIcon-root MuiSvgIcon-fontSizeMedium ant-dropdown-trigger css-vubbuv'])[1]
    click  //div[contains(text(),'Deactivated employees')]
    sleep  5
#    employee should be added  ${employeeName}  ${Department}  ${Role}  ${Mobile}
# TO REactivate the Employee


Generate Random string of name
    ${random_string}=  Generate Random String  7  [LOWER]
    ${random_customer_name}=  Capitalize First Letter  ${random_string}
    [Return]  ${random_customer_name}