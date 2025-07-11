*** Settings ***
Library     SeleniumLibrary
Resource    ./keyword.robot
Resource    ././variable.robot
*** Variables ***
*** Test Cases ***
Search List Page Column
    Login To ManufApp Site    # Login To Dev Site
#    select site    testingsiteautomation
    Landing On Purchase Order Page
#    click    purchase_order_refresh
    Searching Issue Date Column
    [Teardown]    Browser.Close Browser
