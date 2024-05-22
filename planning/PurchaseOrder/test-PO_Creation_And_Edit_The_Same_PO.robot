*** Settings ***
Documentation    create Purchase Order
Library    SeleniumLibrary
Resource    ./././keyword.robot
Resource    ./././variable.robot
Resource    ../../keywords.robot

*** Variables ***
@{date}   ${D_Date}
@{Item_Type}    Raw Material  FG
@{Vendor}  Newvendortest01  Nandu
@{ItemData}  0  LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK  10   100
@{ItemData2}  0  LDPP STRETCH ROLL (FLEXIBLE PIPES)   15   120      #RAW00013

*** Test Cases ***
PO Creation And Edit The Same PO
    Open Browser Site
    Login To ManufApp Site
    select site    testingsiteautomation  #Smart Factory
    Landing On Purchase Order Page
    Create_PO_And_Edit_PO
