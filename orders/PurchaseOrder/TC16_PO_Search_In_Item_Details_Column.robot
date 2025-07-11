*** Settings ***
Library     Browser
Resource    ./keyword.robot
Resource    ././variable.robot

*** Variables ***
*** Test Cases ***
Search List Page Column
    Login To ManufApp Site
    Landing On Purchase Order Page
#    click    purchase_order_refresh
    Refresh_Purchase_Order_Page_List    ${REFRESH_ELEMENT_LOCATOR}
    Searching Item Details Column
#    Search Randonmly In Item Details columns
    [Teardown]    Browser.Close Browser