*** Settings ***
Documentation    create Purchase Order
Library    SeleniumLibrary
Resource    ./././keyword.robot
Resource    ./././variable.robot
Resource    ../../keywords.robot


*** Variables ***
@{date}   09-05-2024
@{Item_Type}    Raw Material  FG
@{Vendor}  Newvendortest01  Nandu
@{ItemData}  0  LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK  10   100
@{ItemData2}  0  LDPP STRETCH ROLL (FLEXIBLE PIPES)   15   120      #RAW00013

*** Test Cases ***
#PO Creation
#    Open Browser Site
#    Login To ManufApp Site
#    Select Your Site    testingsiteautomation  #Smart Factory
#    Move to Purchase Order Page
##   Enter the following data :[ DATE--Item_Type--Vendor--RowNum--Quantity--price ]
#    Create_PO   30-04-2024  FG  Unnati  0   100  14  #${date}  ${Item_Type}  ${Vendor}  ${ItemData}[0]  ${ItemData}[1]  ${ItemData}[2]

PO Creation And Edit The Same PO
    Set Selenium Speed    0.1
    Open Browser Site
    Login To ManufApp Site
    Select Your Site    testingsiteautomation  #Smart Factory
    Landing On Purchase Order Page
    Create_PO_And_Edit_PO
#    wait until page contains element    //a[contains(text(),'NEW')]  timeout=10s
#    click    ${CREATE_NEW_BUTTON}
#    Select Vendor for PO  ${vendor}[0]
#    select Delivery Date  ${date}[0]
##    delivery date entry
#    ${today1}    Get Current Date  result_format=%d-%m-%Y
#    set ith item in PO  ${ItemData}[0]  ${ItemData}[1]  ${ItemData}[2]  ${ItemData}[3]
#    click   ${SUBMIT}
#    log to console    --- * PO creation Successfully done * --
#    Verify Text
#    sleep    0.05s
#    ${order_info}    Get Text    xpath://div[contains(@style, 'text-align: center;')]
#    ${start_index}    Evaluate    "${order_info}".find("Order ") + len("Order ")
#    ${end_index}    Evaluate    "${order_info}".find(" has been created!")
#    ${order_number}    Evaluate    "${order_info}"[${start_index}:${end_index}]
#
#    click    ${BACK}
#    Search In PO    ${order_number}
#    sleep   1s
#    click    //a[@id='purchase_order_label']
#    sleep   1s
#    click   //button[text()='Edit']
#    set ith item in PO    ${ItemData2}[0]  ${ItemData2}[1]  ${ItemData2}[2]  ${ItemData2}[3]
#    click    (//button[text()='Submit'])[1]
#    click    //*[@id='back_btn']
#    log to console    --- * PO editing Successfully done * --
#    sleep    0.05s
#    Search In PO    ${order_number}
