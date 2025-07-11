*** Settings ***
Documentation    create Purchase Order
Library  Browser
Library  String
Library  Collections
Resource  ./././keyword.robot
Resource  ./././variable.robot
Resource  ../../keywords.robot
Resource  ../../variables.robot
Resource  ../../inventory/transactions/keywords.robot

*** Variables ***
@{date}   ${D_Date}
@{Item_TypeName}  Raw Material  FG
@{Vendor}  Newvendortest01  Niteshmoon
@{ItemData}  0  LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK  150   30   121
#@{ItemData}  0  CR00005  150   30      #LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK
*** Test Cases ***
PO Creation
    Login To ManufApp Site2
    Wait For Load State
    Select Your Site   4   Main_Automation_Unit    #purchase_order_unit  #testingsiteautomation  #Smart Factory
    Sleep    1s
    Landing On Purchase Order Page
    Create_PO   ${ItemData}  ${vendor}
    [Teardown]    Browser.Close Browser





