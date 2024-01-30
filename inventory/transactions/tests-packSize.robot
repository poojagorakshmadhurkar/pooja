*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections

*** Variables ***
@{itemData1}  pckkkkkkkkkkkk_testing  44

*** Test Cases ***
Making a new item and defining pack size then making outward for the same
    login
#    select site  Smart Factory
    select warehouse name from dropdown  ${smartFactory}  2
    open item page
    sleep  2
    mouse over  ${rowsPerPage}
    click  ${newIcon}
    #${randomItemCode}=  generate random string  5-10  [NUMBERS]
    input  ${itemCode}  pckkkkkkkkkkkk_testing
    ${randomItemName}=  generate random string  5-10  [LETTERS][NUMBERS]
    input  ${itemName}  ${randomItemName}
    click  ${itemGroupType}
    click  //span[text() = "Compounds"]
    click  ${Submit}
    click  ${addDetailsToThisitem}
    wait until page contains  ${itemData1}[0]  10
    click  ${edit}
    click  ${packSizeTab}
    sleep  1
    ${randompackSize}=  generate random string  1  [NUMBERS]
    input  ${packSize}  ${randompackSize}
    click  ${Submit}
#Creation of  item is complted now this is inward for the same item
    open trasactions page
    click  ${newInwardNote}
    select item type  Raw Material
    select inspector  Employee 1
    ${randomGrn}=  generate random string  5-10  [NUMBERS]
    input  ${grnNumber}  ${randomGrn}
    select partner  Newvendor_10
    input  ${invoiceNumber}  inv1001
#    ${quantity}=  generate random string  2-3  [NUMBERS]

    set ith item  1  ${itemData1}
#    set ith item  2  ${itemData2}
    click  ${submit}
    click  ${newRequest}
    click  ${inventoryDropdown}
    click  ${inventoryTransactions}
    sleep  3
    #wait until page contains  ${newInwardNote}
    click  ${1stapprove}
    racking approval  0  M/1  ${itemData1}[1]
    click  ${approveRequest}
    i should see text on page  MRN approved SuccesFully
    reload page
#    Run Keywords  Outward to customer
#Creation of  item is complted inward for same is also completed now this is outward for the same item
    open trasactions page
    click  ${outwardTab}
    click  ${newOutwardNote}
    select outward to  Customer
    select outward customer to  Fbt Electronics
    packSize outward  1  ${itemData1}  ${randompackSize}
    click  ${submit}
    click  ${newRequest}
    approve outward
    sleep  1
    click  ${approveRequest}
    i should see text on page  MRN approved SuccesFully
minimum pack size outward
    click  ${outwardTab}
    click  ${newOutwardNote}
    min packSize outward  1  ${itemData}  ${randompackSize}
    click  ${minPackk}
    click  ${submit}
    click  ${newRequest}
    approve outward rack case
    i should see text on page  MRN approved SuccesFully

