*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections


*** Test Cases ***
Creation of SO
    login
    open order tracker page
    click  ${soTrackerTab}
    click  ${newSO}
    wait until page contains element  Add New SO  20
    input  ${customerName}  Royal India
    press keys  ${customerName}  Enter
    ${randomPoNumber}=  generate random string  5-10  [NUMBERS]
    input  ${poNumber}  ${randomPoNumber}
    input  ${poIssueDate}  07092023
    input  ${poExpiryDate}  07102023
    Creating of So