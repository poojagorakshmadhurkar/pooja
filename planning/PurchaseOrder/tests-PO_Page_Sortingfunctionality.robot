*** Settings ***
Library    SeleniumLibrary
Library     String
Library     String
Library     Collections
Resource    ./keyword.robot
Resource    ././variable.robot

*** Variables ***

*** Test Cases ***
Verify List Page Column
    Open Browser Site
    Login To ManufApp Site
    Landing On Purchase Order Page
    Refresh_Purchase_Order_Page_List    ${REFRESH_ELEMENT_LOCATOR}
    Sorting   ${PO NUMBER COLUMN DATA LIST}   PO_Number
    Sorting   ${ITEM DETAILS COLUMN DATA}   Item_Details
    Sorting   ${ORDERD COLUMN DATA}   Ordered
    Sorting   ${DELIVERED COLUMN DATA}   Delivered
    Sorting   ${REJECTED COLUMN DATA}   Rejected
    Sorting   ${REMAINING COLUMN DATA}   Remaining
    Sorting   ${VENDER COLUMN DATA}   Vendor
    Sorting   ${ISSUE DATE COLUMN DATA}   Issue Date
    Sorting   ${DELIVERY DATE COLUMN DATA}   Delivery Date
    Sorting   ${PRICE COLUMN DATA}   Price
    Sorting   ${CREATED BY COLUMN DATA}   Created by
    Sorting   ${STATUS COLUMN LIST}   Status
    Close The Browser



