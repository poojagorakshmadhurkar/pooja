*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Library  String
Library  Collections
Resource  ../../inventory/transactions/keywords.robot
Resource  ../../variables.robot
Resource  ./variables.robot

*** Variables ***
@{customername}  Test01
@{itemData1}  Fgitem1  100
@{itemData2}  FGitem3  100
@{itemData3}  FGitem2  100




*** Test Cases ***
Creation of SO
    login devsite
    select site  testingsiteautomation
    Create SO with multiple items  ${customername}  ${itemData1}  ${itemData2}  ${itemData3}
