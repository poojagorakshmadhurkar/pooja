*** Settings ***

Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Resource  ../../keywords.robot
Library  ../RandomEmailLibrary.py

*** Variables ***
@{EmployeeName}  Planning  Supervisor     #for employee name firstletter is capital and other small
#@{EditEmployeeName}  Employee_48  Admin  Manager  0809782748  test_email48@test.com     #change name emailid Others letter should be small
${EMAIL_LENGTH}    8  # Length of the username part of the email
${EMAIL_DOMAIN}   example.com


*** Test Cases ***
open Employees page
    Set Selenium Speed    0.1
    login
    select site  smart_factory
    open Employees page
    wait until page contains  NEW  15
    click  ${addNewEmployee}
    ${randomEmployeeName}=  Generate Random string of name
    input  ${Name}  ${randomEmployeeName}
#    input  ${Name}  ${EmployeeName}[0]
    ${randomEmployeeNumber}=  generate random string  10  [NUMBERS]
    input  ${mobile}  ${randomEmployeeNumber}
#    input  ${mobile}  ${EmployeeName}[3]

    ${random_email}=    Generate Random Email    ${EMAIL_LENGTH}    ${EMAIL_DOMAIN}
    # Example of using the random email in a test case
    Input Text    ${employeeEmail}    ${random_email}
    click  ${department}
    click  //span[text() = "${EmployeeName}[0]"]
    click  ${role}
    click  //span[text() = "${EmployeeName}[1]"]
#    click  ${sites}
#    click  //span[text() = "Haridwar Unit"]
#    click  ${warehouse}
#    click  //span[text() = "Bundle_check"]
    click  ${Submit}
    i should see text on page  Employee added
    click  ${back}
    reload page
    sleep  5
    employee should be added  ${randomEmployeeName}  ${EmployeeName}[0]  ${EmployeeName}[1]  ${randomEmployeeNumber}
##    sleep  2
##    click  ${siteIcon}
##    click  ${logout}
##    input  ${email}  9087654300@testemployee.com
##    input  ${password}  9087654300
##    click  ${signIn}
##    sleep  2
##    wait until element is visible  //button[text() = "Production"]






    edit employee  ${randomEmployeeName}
#    employee should be added  ${EditEmployeeName}[0]  ${EditEmployeeName}[1]  ${EditEmployeeName}[2]  ${EditEmployeeName}[3]  ${EditEmployeeName}[4]



#    delete employee  ${randomEmployeeName}
#    i should see text on page  Employee deactivated successfully
#    employee should be in deactivated slot  ${randomEmployeeName}
