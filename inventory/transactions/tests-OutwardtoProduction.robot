*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Library    DateTime



*** Variables ***
@{itemData1}  RMitemA  20
@{itemData2}  RMitemB  30
@{edititemData1}  RawmaterialA  11
@{edititemData2}  RawmaterialB  32
@{inwarditem1}  RawmaterialA  500
@{inwarditem2}  RawmaterialB  500

*** Test Cases ***

outward to prod
    Set Selenium Speed    ${DELAY}
    login
    select site  testingsiteautomation
    open trasactions page
    click  ${outwardTab}
    click  ${newOutwardNote}
    reload page
    select outward to  Production
    select machine  WIP MACHINE
    date entry
    set ith item in outward  0  ${itemData1}[0]  ${itemData1}[1]
    click  ${submit}
    click  ${newRequest}
    open trasactions page
    click  ${outwardTab}
    sleep  2
    outward tr status no method 2  Pending  1
    click  //div[@id = "item__tabs-panel-debit"]//tr[2]//td[1]//a
    click  ${edit}
    edit ith item in outward  0  ${edititemData1}[0]  ${edititemData1}[1]
    click  ${submit}
    i should see text on page  Transaction Edited SuccesFully
    approve outward