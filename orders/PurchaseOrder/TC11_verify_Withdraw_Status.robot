*** Settings ***
Documentation    Verify Status Of PO
Library    Browser
Resource    ./././keyword.robot
Resource    ./././variable.robot
Resource    ../../keywords.robot

*** Variables ***
@{date}   ${D_Date}
@{Item_TypeName}  Raw Material  FG
@{Vendor}  Newvendortest01
@{ItemData}  0   LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK   300   30   3781             #
${expected_text}    Issued

*** Test Cases ***
Verify PO Status
    Login To ManufApp Site
    Select Your Site  11   Smart Factory    #testingsiteautomation
    Sleep    1s
    Landing On Purchase Order Page   #testingsiteautomation
    Verify Withdraw Status
    [Teardown]    Browser.Close Browser

