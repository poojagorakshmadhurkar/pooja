*** Settings ***
Library     Browser
Resource    ./keyword.robot
Resource    ././variable.robot
Resource    ././keyword.robot
Resource    ././variable.robot

*** Variables ***
#${Date}
${Item Name}   CR00009
#${Vendor name}
@{rowNum}   0
@{Quantity}   250
@{price}   20
@{xpath}    (//a[@id='purchase_order_label'])[1]

*** Test Cases ***
Edit PO_ItemCode_Price_quantity
    Login To ManufApp Site
#    select site    testingsiteautomation
    Landing On Purchase Order Page
#    click    purchase_order_refresh
    Verify_ItemCode_Price_Quantity_ Should_Be_Edited    (//a[@id='purchase_order_label'])[1]
    [Teardown]    Browser.Close Browser