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
#    sleep    1s
    Searching Issue Date Column
#    sleep    1s