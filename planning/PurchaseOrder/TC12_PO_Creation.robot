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
@{Vendor}  Newvendortest01  Niteshmoon
@{ItemData}  0  LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK  150   30
#@{ItemData}  0  CR00005  150   30      #LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK
*** Test Cases ***
PO Creation
    Open Browser Site
    Login To ManufApp Site
    Select Your Site    testingsiteautomation
#    select site    testingsiteautomation  #Smart Factory
    Landing On Purchase Order Page
    create_po   ${ItemData}  ${vendor}





