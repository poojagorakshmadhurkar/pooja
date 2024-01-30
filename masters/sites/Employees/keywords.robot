*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot

*** Keywords ***
open Employees page
    click  ${mastersDropdown}
    sleep  1
    click  ${mastersEmployees}
    reload page

employee should be added
    [Arguments]  ${employeeName}  ${Department}  ${Role}  ${Mobile}  ${Email}
    click  //button[@id='employee__filterBtn']

    press keys  //input[@id='name']  CTRL+A  BACKSPACE
    input  //input[@id='name']  ${employeeName}

#    press keys  (//span[contains(text(),'Mobile')])[1]  CTRL+A  BACKSPACE
#    input  (//span[contains(text(),'Mobile')])[1]  ${Mobile}
#
#    press keys  (//span[contains(text(),'Email')])[1]  CTRL+A  BACKSPACE
#    input  (//span[contains(text(),'Email')])[1]  ${Email}

    wait until page contains element  //a[text()="${employeeName}"]/../../../../../../../../../../td[1][text()="${Department}"]/../td[2][text()="${Role}"]/../td[3][text()="${Mobile}"]/../td[4][text()="${Email}"]  timeout=15s



#login for employee
#    open browser  ${url}  chrome
#    maximize browser window
#    input  ${email}  admin@smart.com
#    input  ${password}  271828
#    click  ${signIn}
#    wait until page contains  Masters  10

edit employee
    [Arguments]    ${oldEmployee}  ${newEmployee}  ${newDepartment}  ${newRole}  ${newMobile}  ${newEmail}
    click  //a[text() = "${oldEmployee}"]
    sleep  3
    click  //button[text() = "Edit"]
    sleep  5
    Wait Until Page Contains Element  //input[@value = "${oldEmployee}"]
    Press keys  ${Name}  CTRL+A  BACKSPACE  ${newEmployee}
    Wait Until Page Contains Element  //input[@value = "${EmployeeName}[3]"]
    press keys  ${mobile}  CTRL+A  BACKSPACE  ${newMobile}
    Wait Until Page Contains Element  //input[@value = "${EmployeeName}[4]"]
    press keys  ${employeeEmail}  CTRL+A  BACKSPACE  ${newEmail}
    Wait Until Page Contains  ${EmployeeName}[1]
    Wait Until Page Contains  ${EmployeeName}[2]
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
    employee should be added  ${EditEmployeeName}[0]  ${EditEmployeeName}[1]  ${EditEmployeeName}[2]  ${EditEmployeeName}[3]  ${EditEmployeeName}[4]
# TO REactivate the Employee


