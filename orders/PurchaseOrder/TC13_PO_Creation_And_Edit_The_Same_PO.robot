*** Settings ***
Documentation    create Purchase Order
Library    Browser
Resource    ./././keyword.robot
Resource    ./././variable.robot
Resource    ../../keywords.robot
*** Variables ***
@{date}   ${D_Date}
@{Item_Type}    Raw Material  FG
@{Vendor}  Newvendortest01  Nandu
@{ItemData}  0  LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK  150   30    116
@{ItemData2}  0   DoorItem  15   120   112

*** Test Cases ***
PO Creation And Edit The Same PO
    Login To ManufApp Site
#    select site    testingsiteautomation  #Smart Factory
    Select Your Site  11   Smart Factory   #testingsiteautomation
    Landing On Purchase Order Page
    Create_PO_And_Edit_PO
    [Teardown]    Browser.Close Browser
