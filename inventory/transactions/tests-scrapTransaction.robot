*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections

*** Variables ***
@{itemData1}  12345678  100  50
@{itemData2}  Scrap001  20

*** Test Cases ***
inward request for scraps
    login
    click  ${inventoryDropdown}
    click  ${inventoryWarehouses}
    sleep  5
    click  ${scrapTab}
    sleep  5
    ${save}  item current stock for scraps  12345678
    open trasactions page
    click  ${newInwardNote}
    sleep  5
    select item type  Scrap
    select inspector  Adam Baur
#    ${randomGrn}=  generate random string  5-10  [NUMBERS]
#    input  ${grnNumber}  ${randomGrn}
    select partner  Newvendor_10
    set ith item  1  ${itemData1}
#    set ith item  2  ${itemData2}
    click  ${submit}
    click  ${newRequest}
    click  ${inventoryDropdown}
    click  ${inventoryTransactions}
#    reload page
#    sleep  5
    #wait until page contains  ${newInwardNote}
    click  ${1stapprove}
    click  ${approveRequest}
    i should see text on page  MRN approved SuccesFully
    click  ${inventoryDropdown}
    click  ${inventoryWarehouses}
    sleep  3
    click  ${scrapTab}
    sleep  2
    ${save2}  item new stock for scraps  12345678
    Run Keyword If    ${save2} == ${save} + ${itemData1}[1]    Pass Execution    ${save2}
    Log    Wrong calculation
    sleep  2

outward request for scraps
    open trasactions page
    click  ${outwardTab}
    click  ${newOutwardNote}
    select outward to  Customer
    select outward customer to  Toshiba
    input  (//button[@aria-label = "Open"]/../../input)[1]  ${itemData}[0]
    press keys  (//button[@aria-label = "Open"]/../../input)[1]  ENTER
    sleep  1
    #element should be visible  //input[@value = "${itemData}[0]"]
    #element should be enabled  (//input[@type = "number"])[${i}]
    #click  (//input[@type = "number"])[${i}]
    input  (//input[@type = "number"])[1]  ${itemData1}[2]
    click  ${submit}
    click  ${newRequest}
    click  ${1stapprove}
    i should see text on page  MRN approved SuccesFully
    ${save3}  item new stock for scraps  ${itemData1}[0]
    Run Keyword If    ${save3} == ${save2} - ${itemData1}[2]    Pass Execution    ${save3}
    Log    Wrong calculation

