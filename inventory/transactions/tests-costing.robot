*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections

*** Variables ***
@{itemData1}  RMItem-5  30  40
@{itemData2}  Am_testing1  50  67
@{itemData3}  CAP  100  90
@{itemData4}  C1-22-404  11   12
@{itemData5}  Compound1  13  14
@{itemData6}  SMC Compound  100  10

*** Test Cases ***
costing inward request
    login
    select warehouse name from dropdown  ${smartFactory}  5
    open trasactions page
    click  ${newInwardNote}
    select item type  Raw Material
    select inspector  Aditya Gupta
    ${randomGrn}=  generate random string  5-10  [NUMBERS]
    input  ${grnNumber}  ${randomGrn}
    select partner  Newvendor_10
    input  ${invoiceNumber}  inv1001
    set ith item in costing  0  ${itemData1}
#    set ith item  2  ${itemData2}
    click  ${submit}
    click  ${newRequest}
    click  ${inventoryDropdown}
    click  ${inventoryTransactions}
#    reload page
#    sleep  5
    #wait until page contains  ${newInwardNote}
    click  ${1stapprove}

costing and racking inward request
    #login
    select warehouse name from dropdown  ${smartFactory}  6
    open trasactions page
    click  ${newInwardNote}
    select item type  Raw Material
    select inspector  Aditya Deewan
    ${randomGrn}=  generate random string  5-10  [NUMBERS]
    input  ${grnNumber}  ${randomGrn}
    select partner  Newvendor_10
#    input  ${invoiceNumber}  inv1001
    set ith item in costing  0  ${itemData6}
#    set ith item  2  ${itemData2}
    click  ${submit}
    click  ${newRequest}
    click  ${inventoryDropdown}
    click  ${inventoryTransactions}
    click  ${1stapprove}
    racking approval  0  FG/1 20
    click  ${approveRequest}
    i should see text on page  MRN approved SuccesFully