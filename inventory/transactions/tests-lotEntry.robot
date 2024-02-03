*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections

*** Variables ***
@{itemData1}  RM-1   30  40
@{itemData2}  Am_testing1  50  67
@{itemData3}  CAP  100  90
@{itemData4}  C1-22-404  11   12
@{itemData5}  Compound1  13  14
@{itemData6}  Compound2  15  16

*** Test Cases ***
Lot inward request for 1 item single lot
    login
    select site  moulding
    open trasactions page
    click  ${newInwardNote}
    select item type  Raw Material
    select inspector  P
    ${randomGrn}=  generate random string  5-10  [NUMBERS]
    input  ${grnNumber}  ${randomGrn}
    select partner  Vendor1113
    input  ${invoiceNumber}  inv1001
    set ith item in Lot case  0  ${itemData1}
    click  ${submit}
    click  ${newRequest}
    click  ${inventoryDropdown}
    click  ${inventoryTransactions}
    reload page
    sleep  5
    #wait until page contains  ${newInwardNote}
    click  ${1stapprove}
    i should see text on page  MRN approved SuccesFully

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
