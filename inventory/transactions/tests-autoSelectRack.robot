*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections

*** Variables ***
@{itemData1}  RackTest  30

*** Test Cases ***
Auto select rack
    Set Selenium Speed    ${DELAY}
    login
    click  ${mastersDropdown}
    click  ${mastersItems}
    click  ${newIcon}
    input  ${itemCode}  ${itemData1}[0]
    input  ${itemName}  This is for auto rack Test111111111
#    click  ${itemFilter}
    select option from dropdown using span  ${itemgroup}  Compounds
    click  ${Submit}
    i should see text on page  Item added
    click  ${addDetailsToThisitem}
    sleep  10
    click  ${edit}
    click  ${autoRackTab}
    Defining Auto rack  0  R/1
    click  ${Submit}
    i should see text on page  Item edited
    open trasactions page
    Wait Until Page Contains Element  ${newInwardNote}  60
    click  ${newInwardNote}
    Wait Until Page Contains  Inward Request  20
    select item type  Raw Material
    select inspector  Adam Baur
#    ${randomGrn}=  generate random string  5-10  [NUMBERS]
#    input  ${grnNumber}  ${randomGrn}
    select partner  Fbt Electronics
    input  ${invoiceNumber}  inv1001
    input  //input[@id = "credit__details__0__sku"]  ${itemData1}[0]
    press keys  //input[@id = "credit__details__0__sku"]  ENTER
#    input  //input[@id = "credit__details__0__quantity"]  ${itemData1}[1]
    sleep  1
    ${randomQuantity}=  generate random string  1-2  [NUMBERS]
    input  //input[@id = "credit__details__0__quantity"]  ${randomQuantity}
    click  ${submit}
    click  ${newRequest}
    click  ${inventoryDropdown}
    click  ${inventoryTransactions}
    click  ${1stapprove}
    click  ${autoSelectRack}
#    Run Keyword If    ${randomQuantity}  ==  get element text from value of rack after autorack  Pass Execution    ${randomQuantity}
#    Log    Wrong calculation
    input  //input[@id = "credit__racking__0__0__quantity"]  ${randomQuantity}
    click  ${approveRequest}
    i should see text on page  MRN approved SuccesFully
    sleep  2

#    robot .\Suite\inventory\transactions\tests-autoSelectRack.robot