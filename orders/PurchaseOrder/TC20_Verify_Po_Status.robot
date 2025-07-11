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
@{ItemData}  0  LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK  150   30    101
${expected_text}    Issued

*** Test Cases ***
Verify PO Status
    Login To ManufApp Site
#    select site    testingsiteautomation  #Smart Factory
    Landing On Purchase Order Page
    Create_PO   ${ItemData}   ${vendor}
    click   ${PO_Approve}
    sleep    2s
    ${actual_text}    Browser.Get Text    ${PO_STATUS}
    log to console  ✅ ${actual_text}
    log   ✅ ${actual_text}
    IF    '${actual_text}' == '${expected_text}'
        Log    ✅ Status validation passed
        log to console  ✅ Status validation passed
    END
    [Teardown]    Browser.Close Browser

