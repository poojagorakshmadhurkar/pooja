*** Settings ***
#Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Library  String
Library  Collections
#Resource  ../../inventory/transactions/keywords.robot
Resource  ../../variables.robot
Resource  ./variables.robot
Library    Browser


*** Variables ***
@{customername}  Test01
@{itemData1}  Fgitem2  100
@{itemData2}  FGitem3  100




*** Test Cases ***
SO Edition
    login devsite
    select site  testingsiteautomation
    ${order_number}=  Create SO  ${customername}  ${itemData1}
    click  (//a[text()="${order_number}"]/../../../../../../../../span)[1]
    Wait For Elements State      //div[text()="${order_number}"]    visible   timeout=30s
    click  (//*[name()='svg'][@id='so_details_menu'])[1]
    click  ${EditSobutton}
    Wait For Elements State      //span[text()="${order_number}"]    visible   timeout=30s
    click  ${Editbutton}
    Edit ith item in SO  0    ${itemData2}[0]    ${itemData2}[1]
    sleep  1
    click  //button[@id='__submit']
    click  ${Editbackbutton}
    Wait For Elements State      //div[text()="${order_number}"]    visible   timeout=30s
    Wait For Elements State    //a[text()="${itemData2}[0]"]  visible   timeout=30s
