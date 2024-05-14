*** Settings ***
Library    SeleniumLibrary
Library     String
Library     String
Library     Collections
Resource    ./keyword.robot
Resource    ././variable.robot

*** Test Cases ***
Verify List Page Column
    Open Browser Site
    Login To ManufApp Site
    Landing On Purchase Order Page
    Refresh_Purchase_Order_Page_List    ${REFRESH_ELEMENT_LOCATOR}
#    LIST PAGE COLUMNS
    Sorting
    Close The Browser



