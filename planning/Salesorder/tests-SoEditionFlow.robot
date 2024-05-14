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
@{itemData2}  FGitem2  100




*** Test Cases ***
SO Edition
    Set Selenium Speed    0.1
    login devsite
    select site  testingsiteautomation
    ${order_number}=  Create SO  ${customername}  ${itemData1}
    click  //a[text()="${order_number}"]/../../../../../../../../span
    Wait Until Page Contains Element  //div[text()="${order_number}"]    timeout=30s
    sleep  2
    click  ${EditSobutton}
    Wait Until Page Contains Element  //div[text()="${order_number}"]    timeout=30s
    click  ${Editbutton}
    click  ${AddnewRow}
    set ith item in so  1  ${itemData2}[0]  ${itemData2}[1]
    click  ${submit}
    click  ${Editbackbutton}
    Wait Until Page Contains Element  //div[text()="${order_number}"]    timeout=30s
    Wait Until Page Contains Element    //a[text()="${itemData2}[0]"]  timeout=30s
