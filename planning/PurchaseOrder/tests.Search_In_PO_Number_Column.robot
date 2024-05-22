*** Settings ***
Library     SeleniumLibrary
Resource    ./keyword.robot
Resource    ././variable.robot

*** Variables ***
@{PO_Col}  PO-131  PO-130  PO-129  PO-128  PO-127  PO-126  PO-125  PO-00056    PO-00055    PO-00053    PO-00054    PO-124  PO-00052    PO-00051    PO-00050    PO-123  PO-122  PO-121
@{Vendor_Col}   Vendor 5    Newvendor_10    Bajaj   Cust-005    Customer_10     Dikshit Bbb     Dikshit Ll  Dixit   Intensiv Vendor 67  Newvendor_10


*** Test Cases ***
Search List Page Column
    Open Browser Site
    Login To ManufApp Site
    Landing On Purchase Order Page
    Search In PO_Number Column
    Close The Browser