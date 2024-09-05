*** Settings ***
Library    SeleniumLibrary
Library     String
Library     Collections
Resource    ./keyword.robot
Resource    ./variable.robot


*** Test Cases ***
TC01_Refresh_Purchase_Order_Page
#    Open Browser In Headless Mode
    Open Browser Site
    Login To ManufApp Site
    Landing On Purchase Order Page
    Refresh_Purchase_Order_Page_List    ${REFRESH_ELEMENT_LOCATOR}
    Close The Browser

