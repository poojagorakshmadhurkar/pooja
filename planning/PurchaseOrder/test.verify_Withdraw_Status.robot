*** Settings ***
Documentation    Verify Status Of PO
Library    SeleniumLibrary
Resource    ./././keyword.robot
Resource    ./././variable.robot
Resource    ../../keywords.robot

*** Variables ***
@{date}   ${D_Date}
@{Item_TypeName}  Raw Material  FG
@{Vendor}  Newvendortest01
@{ItemData}  0  LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK    300   30
${expected_text}    Issued

*** Test Cases ***
Verify PO Status
    Open Browser Site
    Login To ManufApp Site
    select site    testingsiteautomation
    Landing On Purchase Order Page   #testingsiteautomation
    Create_PO   ${ItemData}  ${vendor}   ${date}
    Verify Withdraw Status


