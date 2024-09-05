*** Settings ***
Documentation    Verify Status Of PO
Library    SeleniumLibrary
Library    String
Resource    ./././keyword.robot
Resource    ./././variable.robot
Resource    ../../keywords.robot
*** Variables ***
@{date}   ${D_Date}
@{Item_Type}  Raw Material  FG
@{Vendor}   Gupta Store  Niteshmoon   Nandu   Unnati  Newvendortest02
@{ItemData}  0   HR00005   1000  25          #CR00002
@{ItemData1}  1  HR00004  2000  50          #HR00003
@{ItemData2}  2  HR00003  3000  75          #HR00002
@{ItemData3}  3  HR00002  4000  100
${expected_text}    Issued
@{inspected_By}   Testingname   #Afzal   Cindy   Demo Employee
@{Deliverd_qnt}   5  10  15   20

*** Test Cases ***
PO Inward_Flow
    set selenium speed    0.05s
    Open Browser Site
    Login To ManufApp Site
    select site    testingsiteautomation    #Smart Factory        #testingsiteautomation
    Landing On Purchase Order Page
    PO Inward_Flow




