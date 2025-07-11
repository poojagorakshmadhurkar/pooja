*** Settings ***
Documentation    Verify Status Of PO
Library    Browser
Library    String
Resource    ./././keyword.robot
Resource    ./././variable.robot
Resource    ../../keywords.robot
*** Variables ***
@{date}   ${D_Date}
@{Item_Type}  Raw Material  FG
@{Vendor}   Newvendortest01  Gupta Store  Niteshmoon  Nandu   Unnati  Newvendortest02
@{ItemData}  0   HR00005  1000  25  1098    #CR00002
@{ItemData1}  1  HR00004  2000  50  8976    #HR00003
@{ItemData2}  2  HR00003  3000  75  6754    #HR00002
@{ItemData3}  3  HR00002  4000  100  3090
${expected_text}    Issued
@{inspected_By}   Akshay    Testingname   #Afzal   Cindy   Demo Employee
@{Deliverd_qnt}   5  10  15   20

*** Test Cases ***
PO Inward_Flow
    Login To ManufApp Site2
    Select Your Site    4    Main_Automation_Unit
#    Login To ManufApp Site    # Login To Dev Site
#    Select Your Site  11    #Smart Factory  #testingsiteautomation
    sleep   1s
    Landing On Purchase Order Page
    PO Inward_Flow
    [Teardown]    Browser.Close Browser




