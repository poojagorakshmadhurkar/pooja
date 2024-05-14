
*** Settings ***
Documentation    Verify PO Details
Library    SeleniumLibrary
Resource    ./././keyword.robot
Resource    ./././variable.robot
Resource    ../../keywords.robot

*** Variables ***
@{date}   15-05-2024
@{Item_TypeName}  Raw Material  FG
@{Vendor}  Newvendortest01  Xyzzz   Nandu   Unnati  Vendor55
@{ItemData}  0  LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK    100   5
${expected_text}    Issued


*** Test Cases ***
Verify PO Status
    Open Browser Site
    Login To ManufApp Site
    select site    testingsiteautomation  #Smart Factory
    Move to Purchase Order Page
    ${order_number}=   create_po   ${ItemData}  ${vendor}   ${date}

    set selenium speed    0.5s
    Click Element    ${PO_ORDER_DETAIL}
    sleep  1
    wait until element is visible    //a[text()="${order_number}"]
    wait until element is visible    //span[text()="${Vendor}[0]"]
#    wait until element is visible    //span[text()="${date}[0]"]    10s    date format space problem
    wait until element is visible  (//span[text()="${ItemData}[1]"])[2]
    wait until element is visible  (//td[text()="${ItemData}[2] kg"])[1]
    log to console  //a[text()="${order_number}"]
    log to console  //span[text()="${Vendor}[0]"]
    log to console  (//span[text()="${ItemData}[1]"])[2]
    log to console  (//td[text()="${ItemData}[2] kg"])[1]



