*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections

*** Variables ***
@{itemData1}  RackTest1123  30  40
@{itemData2}  Am_testing1  50  67
@{itemData3}  CAP  100  90
@{itemData4}  C1-22-404  11   12
@{itemData5}  Compound1  13  14
@{itemData6}  Compound2  15  16

*** Test Cases ***
#Validation lot case with IQC
Lot inward request for 1 item single lot
    login
    select site  testing_site_automation_l_o_tcase4
    open trasactions page
    click  ${newInwardNote}
    select item type  Raw Material
    select inspector  Test_Employee04
#    ${randomGrn}=  generate random string  5-10  [NUMBERS]
#    input  ${grnNumber}  ${randomGrn}
    select partner  Pooja01
    input  ${invoiceNumber}  inv1001
    set ith item in Lot case  0  ${itemData1}[0]  ${itemData1}[1]
    click  ${submit}
    click  ${newRequest}
    open transactions page
    sleep  2
    inward tr status no method 2  IQC Pending  1
    # Validation for if IQc enble than without it should not get approved
    click  //div[@id = "item__tabs-panel-credit"]//tbody/tr[2]//button[@aria-label="Approve"]
    wait until page contains    perform IQC first
    click  //div[@id = "item__tabs-panel-credit"]//tbody/tr[2]/td/div/span/a
    click  ${qualityChecktab}
    sleep  2
    click  ${inwardEdit}
    click  ${allOk}
    wait until element is visible  //span[text() = "No Rejections"]
    i should see text on page  Transaction Edited SuccesFully
    open transactions page
    wait until element is visible  ${newInwardNote}
    sleep  2
    inward tr status no method 2  Pending  1
    inward approve number  1
    i should see text on page  MRN approved SuccesFully
    sleep  2
    inward tr status no method 2  Approved  1


#Lot inward request for 2 item individual lot
#    click  ${newInwardNote}
#    select item type  Raw Material
#    select inspector  Admin_Manager
#    ${randomGrn}=  generate random string  5-10  [NUMBERS]
#    input  ${grnNumber}  ${randomGrn}
#    select partner  Newvendor_10
#    input  ${invoiceNumber}  inv1012
#    set ith item in Lot case  1  ${itemData2}
#    set ith item in Lot case  2  ${itemData3}
#    click  ${submit}
#    click  ${newRequest}
#    click  ${inventoryDropdown}
#    click  ${inventoryTransactions}
#    reload page
#    sleep  5
#    #wait until page contains  ${newInwardNote}
#    click  ${1stapprove}
#    i should see text on page  MRN approved SuccesFully
#
#Lot inward request for 1 item multiple lot
#    click  ${newInwardNote}
#    select item type  Raw Material
#    select inspector  Admin_Manager
#    ${randomGrn}=  generate random string  5-10  [NUMBERS]
#    input  ${grnNumber}  ${randomGrn}
#    select partner  Newvendor_10
#    input  ${invoiceNumber}  inv10411
#    set ith item in multiple Lot case  0  1  ${itemData4}
#    click  ${submit}
#    click  ${newRequest}
#    click  ${inventoryDropdown}
#    click  ${inventoryTransactions}
#    reload page
#    sleep  5
#    #wait until page contains  ${newInwardNote}
#    click  ${1stapprove}
#    i should see text on page  MRN approved SuccesFully
#
#Lot inward request for 2 item multiple lot
#    click  ${newInwardNote}
#    select item type  Raw Material
#    select inspector  Admin_Manager
#    ${randomGrn}=  generate random string  5-10  [NUMBERS]
#    input  ${grnNumber}  ${randomGrn}
#    select partner  Newvendor_10
#    input  ${invoiceNumber}  inv0812
#    set ith item in multiple Lot case  0  1  ${itemData5}
#    set ith item in multiple Lot case  1  2  3  ${itemData6}
#    click  ${submit}
#    click  ${newRequest}
#    click  ${inventoryDropdown}
#    click  ${inventoryTransactions}
#    reload page
#    sleep  5
#    #wait until page contains  ${newInwardNote}
#    click  ${1stapprove}
#    i should see text on page  MRN approved SuccesFully
#
#Lot inward with rejection
#    login
#    select warehouse name from dropdown  ${smartFactory}  3
#    open trasactions page
#    click  ${newInwardNote}
#    select item type  Raw Material
#    select inspector  Admin_Manager
#    ${randomGrn}=  generate random string  5-10  [NUMBERS]
#    input  ${grnNumber}  ${randomGrn}
#    select partner  Newvendor_10
#    input  ${invoiceNumber}  inv1001
#    set ith item in Lot case  0  ${itemData1}
#    click  ${submit}
#    click  ${addDetailsToThisRequest}
#    click  ${edit}
#    rejection reason  0  Bubbles  1
#    click  ${submit}
#    i should see text on page  Transaction Edited SuccesFully
#    click  ${inventoryDropdown}
#    click  ${inventoryTransactions}
#    reload page
#    sleep  5
#    #wait until page contains  ${newInwardNote}
#    click  ${1stapprove}
#    i should see text on page  MRN approved SuccesFully
