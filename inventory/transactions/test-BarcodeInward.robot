*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections

*** Variables ***
@{itemData1}  RMItem-7  44
@{itemData2}  RMItem-6  20
@{itemData3}  RMItem-5  22

*** Test Cases ***
inward request
    login
    open trasactions page
    click  ${newInwardNote}
    select item type  Raw Material
    inward data entry
    click  ${submit}
    click  ${newRequest}
    click  ${inventoryDropdown}
    click  ${inventoryTransactions}
#    reload page
#    sleep  5
    #wait until page contains  ${newInwardNote}
    click  ${1stapprove}
    sleep  2
    click  ${Barcodebutton}
    wait until page contains element   //b[normalize-space()='${ItemData3}[0]']  timeout=15s
    wait until page contains element   //b[normalize-space()='${ItemData3}[0]']  timeout=15s
    wait until page contains element   //b[normalize-space()='${ItemData1}[0]']  timeout=15s
    ${screenshot_path}    Set Variable    C:\Users\user\PycharmProjects\automation\barcodescreenshot\screenshot.png
    Capture Page Screenshot  ${screenshot_path}

