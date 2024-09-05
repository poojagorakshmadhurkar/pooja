*** Settings ***
Library    SeleniumLibrary
Library     String
Library     Collections
Library     DateTime
Resource    ../../planning/PurchaseOrder/keyword.robot
Resource    ../../planning/PurchaseOrder/variable.robot
Resource    ../../keywords.robot
Resource    ../../variables.robot

*** Variables ***
@{date}   ${D_Date}
@{Item_TypeName}  Raw Material  FG
@{Vendor}  Newvendortest01
@{ItemData}  0  LDPP STRETCH ROLL (FLEXIBLE PIPES) BLK  150   30
${expected_text}    Issued
@{inspected_By}   Akash

*** Test Cases ***
