*** Settings ***

Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections

*** Variables ***
@{EmployeeName}  Employeee_120  Planning  Supervisor  0809782120  poojaemail20@test.com     #for employee name firstletter is capital and other small
@{EditEmployeeName}  Employee_48  Admin  Manager  0809782748  test_email48@test.com     #change name emailid Others letter should be small

*** Test Cases ***
open Employees page
    login
    select site  smart_factory
    open Employees page
    wait until page contains  NEW  15
    click  ${addNewEmployee}
#    ${randomEmployeeName}=  generate random string  5-10  [LETTERS]
#    input  ${employeeName}  ${randomEmployeeName}
    input  ${Name}  ${EmployeeName}[0]
#    ${randomEmployeeNumber}=  generate random string  10  [NUMBERS]
#    input  ${mobile}  ${randomEmployeeNumber}
    input  ${mobile}  ${EmployeeName}[3]

    input  ${employeeEmail}  ${EmployeeName}[4]
    click  ${department}
    click  //span[text() = "${EmployeeName}[1]"]
    click  ${role}
    click  //span[text() = "${EmployeeName}[2]"]
#    click  ${sites}
#    click  //span[text() = "Haridwar Unit"]
#    click  ${warehouse}
#    click  //span[text() = "Bundle_check"]
    click  ${Submit}
    i should see text on page  Employee added
    click  ${back}
    reload page
    sleep  5
    employee should be added  ${EmployeeName}[0]  ${EmployeeName}[1]  ${EmployeeName}[2]  ${EmployeeName}[3]  ${EmployeeName}[4]
##    sleep  2
##    click  ${siteIcon}
##    click  ${logout}
##    input  ${email}  9087654300@testemployee.com
##    input  ${password}  9087654300
##    click  ${signIn}
##    sleep  2
##    wait until element is visible  //button[text() = "Production"]




employee edition

    edit employee  ${EmployeeName}[0]  ${EditEmployeeName}[0]  ${EditEmployeeName}[1]  ${EditEmployeeName}[2]  ${EditEmployeeName}[3]  ${EditEmployeeName}[4]
    employee should be added  ${EditEmployeeName}[0]  ${EditEmployeeName}[1]  ${EditEmployeeName}[2]  ${EditEmployeeName}[3]  ${EditEmployeeName}[4]


employee deletion
    delete employee  ${EditEmployeeName}[0]
    i should see text on page  Employee deactivated successfully
    employee should be in deactivated slot  ${EditEmployeeName}[0]
