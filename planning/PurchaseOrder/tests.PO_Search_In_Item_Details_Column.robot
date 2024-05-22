*** Settings ***
Library     SeleniumLibrary
Resource    ./keyword.robot
Resource    ././variable.robot

*** Variables ***


*** Test Cases ***
Search List Page Column
    Open Browser Site
    Login To ManufApp Site
    Landing On Purchase Order Page
    click    purchase_order_refresh
    Refresh_Purchase_Order_Page_List    ${REFRESH_ELEMENT_LOCATOR}
    Search Randonmly In Item Details columns