*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections

*** Variables ***
@{itemData1}  compounds011  10
@{itemData2}  itemX  20

*** Test Cases ***
W2W transfer
    login
    open trasactions page
    click  ${outwardTab}
    click  ${newOutwardNote}
    select outward to  Other Warehouse
    select recipient warehouse  HARIDWAR-UNIT
    set ith item  1  ${itemData1}
    set ith item  2  ${itemData2}
    click  ${submit}
    sleep  2
    click  ${newRequest}
    open trasactions page
    click  ${outwardTab}
    click  ${1stapprove}
    i should see text on page  MRN approved SuccesFully
    #approve w2w transaction  HARIDWAR-UNIT
    select warehouse name from dropdown  ${smartFactory}  2
    click  ${inwardTab}
    #wait until element is visible  //span[text() = "Item View"]
    click  ${1stapprove}
    select inspector while TIN  Employee 2
    input  ${grnNumber}  GRN0101
    click  ${approveButton}
    i should see text on page  IQC approved SuccesFully




