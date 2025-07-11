*** Settings ***
Documentation    create Purchase Order
Library    Browser
Resource    ./././keyword.robot
Resource    ./././variable.robot
Resource    ../../keywords.robot

*** Variables ***
#@{date}   ${D_Date}
@{Item_Type}  Raw Material  FG
@{Vendor}   Gupta Store  Niteshmoon   Nandu   Unnati  Newvendortest02          #HR00003
@{ItemData}  0  HR00003  3000  75   101       #HR00002
@{ItemData1}  1  HR00002  4000  100   102
@{ItemData2}  2  MR1_7_ABC_18  112  25   103       #CR00002
@{ItemData3}  3  PR_22_RED  2000  50   104  #HR00001

*** Test Cases ***
Create Multiple PO
    Login To ManufApp Site
#    select site    testingsiteautomation
    Landing On Purchase Order Page
    Multiple PO Creation   ${vendor}   ${ItemData}  #${ItemData1}  ${ItemData2}   ${ItemData3}
    # Create_PO   ${vendor}   ${ItemData}
    [Teardown]    Browser.Close Browser



