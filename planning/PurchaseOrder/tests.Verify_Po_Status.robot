*** Settings ***
Documentation    Verify Status Of PO
Library    SeleniumLibrary
Resource    ./././keyword.robot
Resource    ./././variable.robot
Resource    ../../keywords.robot

*** Variables ***
@{date}   15-05-2024
@{Item_TypeName}  Raw Material  FG
@{Vendor}  Newvendortest01  Xyzzz   Nandu   Unnati  Vendor55
@{ItemData}  0  LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK  15   3
${expected_text}    Issued


*** Test Cases ***
Verify PO Status
    Open Browser Site
    Login To ManufApp Site
    select site    testingsiteautomation  #Smart Factory
    Move to Purchase Order Page
    Create_PO   ${vendor}  ${date}   ${ItemData}
    sleep    1s
    Text validation   ${expected_text}
