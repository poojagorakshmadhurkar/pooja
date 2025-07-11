*** Settings ***

#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Resource  ../../keywords.robot
Library  ../RandomEmailLibrary.py
Library  Browser

*** Variables ***
@{EmployeeName}  Planning  Supervisor     #for employee name firstletter is capital and other small
#@{EditEmployeeName}  Employee_48  Admin  Manager  0809782748  test_email48@test.com     #change name emailid Others letter should be small
${EMAIL_LENGTH}    8  # Length of the username part of the email
${EMAIL_DOMAIN}   example.com


*** Test Cases ***
open Employees page
    login devsite
    select site  testingsiteautomation
    open Employees page
    click  ${addNewEmployee}
    ${randomEmployeeName}=  Generate Random string of name
    Fill Text    ${Name}  ${randomEmployeeName}
#    input  ${Name}  ${EmployeeName}[0]
    ${randomEmployeeNumber}=  generate random string  10  [NUMBERS]
    Fill Text    ${mobile}  ${randomEmployeeNumber}
#    input  ${mobile}  ${EmployeeName}[3]

    ${random_email}=    Generate Random Email    ${EMAIL_LENGTH}    ${EMAIL_DOMAIN}
    # Example of using the random email in a test case
    Fill Text     ${employeeEmail}    ${random_email}
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
    Reload
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
