*** Settings ***
Documentation    create Purchase Order
Library    SeleniumLibrary
Library  String
Library  Collections
Resource    ./././keyword.robot
Resource    ./././variable.robot
Resource    ../../keywords.robot
Resource  ../../variables.robot
Resource  ../../inventory/transactions/keywords.robot

*** Variables ***
@{date}   ${D_Date}
@{Item_TypeName}  Raw Material  FG
@{Vendor}  Newvendortest01  Xyzzz   Nandu   Unnati  Vendor55
@{ItemData}  0  LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK  150   30

*** Test Cases ***
User Should Not add duplicate Item using (+) sign
    Open Browser Site
    Login To ManufApp Site
    select site    testingsiteautomation  #Smart Factory
    Landing On Purchase Order Page
#    Create_PO_And_Edit_PO

    set selenium speed    0.05
    wait until page contains element    //a[contains(text(),'NEW')]  timeout=10s
    click    ${CREATE_NEW_BUTTON}
    Select Vendor for PO  ${vendor}[0]
    select Delivery Date  ${date}[0]
#    delivery date entry
    ${today1}    Get Current Date  result_format=%d-%m-%Y
    set ith item in PO  ${ItemData}[0]  ${ItemData}[1]  ${ItemData}[2]  ${ItemData}[3]
    click   ${SUBMIT}
    log to console    --- * PO creation Successfully done * --
    Verify Text
    set selenium speed    0.05s
    ${order_info}    Get Text    xpath://div[contains(@style, 'text-align: center;')]
    ${start_index}    Evaluate    "${order_info}".find("Order ") + len("Order ")
    ${end_index}    Evaluate    "${order_info}".find(" has been created!")
    ${order_number}    Evaluate    "${order_info}"[${start_index}:${end_index}]

    click    ${BACK}
    sleep    1s
    Search In PO    ${order_number}
    sleep   1s
    click    //a[@id='purchase_order_label']
    sleep   1s
    click   //button[text()='Edit']
#    set ith item in PO    ${ItemData2}[0]  ${ItemData2}[1]  ${ItemData2}[2]  ${ItemData2}[3]
    click    //*[@id="purchase_order_add_new_rows"]
    click    //*[@id="purchase_order_add_sku"]



    click    (//button[text()='Submit'])[1]
    click    //*[@id='back_btn']
    log to console    --- * PO editing Successfully done * --
    sleep    0.05s
    Search In PO    ${order_number}


