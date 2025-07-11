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
@{Vendor}   Newvendortest01  Gupta Store        #Nandu   #Newvendortest02   Unnati
@{ItemData}  0  HR00004   50  25   101     #CR00004
@{ItemData1}  1  HR00003  20  5    102     #CR00003
@{ItemData2}  2  HR00002  30  7    103    #CR00002
@{ItemData3}  3  HR00001  40  10   104    #CR00001
${expected_text}   Issued
@{inspected_By}   Akshay   Testingname    Akash   #Afzal   Cindy   Demo Employee
*** Test Cases ***
Verify the Value shouls not be add in Orderd Qty After PO Return
#   Login To ManufApp Site     # Login To Dev Site
#    select site    testingsiteautomation    #Smart Factory        #testingsiteautomation
    Login To ManufApp Site2
    Select Your Site    4    Main_Automation_Unit
    Landing On Purchase Order Page
    Verify Inward Request details
    [Teardown]    Browser.Close Browser



