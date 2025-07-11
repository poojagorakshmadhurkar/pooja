*** Settings ***
#Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Library  String
Library  Collections
#Resource  ../../inventory/transactions/keywords.robot
Resource  ../../variables.robot
Resource  ./variables.robot
Resource  ../Salesorder/variables.robot
Resource    ../Salesorder/keywords.robot

Library  Browser

*** Variables ***
@{customername}  Test01
@{itemData1}     FGitem4   1000



*** Test Cases ***

MRP
    login devsite
#   select site  testingsiteautomation
    ${order_number}=  Create SO  ${customername}  ${itemData1}
    click  (//a[text()="${order_number}"]/../../../../../../../../span)[1]
    Wait For Elements State      //div[text()="${order_number}"]    visible   timeout=30s
    #expand button
     Click    //span[@aria-label="Expand All"]
    Click    (//a[text()="${itemData1}[0]"])[1]
    sleep  1
    ${pages}=    Get Page Ids
    Switch Page    ${pages}[0]
    #expand button
    click  //button[@class='ant-switch ant-switch-small'][@role='switch']
    #Get Item Names
    ${item_elements}=    Get Elements        css=span.ant-tree-title
    ${items}=            Create List
     FOR    ${element}    IN    @{item_elements}
    ${text}=    Get Text    ${element}
    ${lines}=    Split String    ${text}    \n
    ${desired_text}=    Set Variable    ${lines}[0]
    Append To List    ${items}    ${desired_text}
    END
    ${item1}=    Get From List    ${items}    0
    ${item2}=    Get From List    ${items}    1
#    ${item3}=    Get From List    ${items}    2
#    ${item4}=    Get From List    ${items}    3
    Switch Page       ${pages}[1]
    Wait For Elements State      //div[text()="${order_number}"]    visible  timeout=30s
    hover   //button[normalize-space()='Create']
#    Wait For Elements State      //a[text()="${item1}"]    visible  timeout=30s
#    Wait For Elements State     //a[text()="${item2}"]    visible  timeout=30s
    sleep  1
    #get ohnad stock of rawmaterial and Fg item
    open warehouse
    ${Rmitem1}   item onhand stock    ${item2}
#    ${Rmitem2}   item onhand stock    ${item2}
#    ${Rmitem3}   item onhand stock    ${item4}
    ${A}   item current stock for Fg  ${itemData1}[0]
    sleep  1
    #mrp flow
    open order tracker page for MRP
    click  ${fetchSo}
    Checkbox selection based on salesorder number   ${order_number}
    click  ${nextbuttonmrp}
    #validation for onhandstock of RM and Fg
    Wait For Elements State    //a[text()="${itemData1}[0]"]   visible    timeout=60s
    Wait For Elements State    (//td[text()="${A} piece"])[1]    visible  timeout=60s
    click  ${nxtbtnfg}
    click  (//button[@role='switch'])[1]
    click  ${nxtbtnfg}
#    Wait For Elements State    //a[text()="${item2}"]/../../../../../../../../../../../td[text()="${Rmitem1} piece"]   visible  timeout=60s
#    Wait For Elements State    //a[text()="${item3}"]/../../../../../../../../../../../td[text()="${Rmitem2} jar"]   visible  timeout=60s
#    Wait For Elements State    //a[text()="${item4}"]/../../../../../../../../../../../td[text()="${Rmitem3} g"]    visible  timeout=60s
    #create Po request
    click   ${createpurchaseorderbtn}
    sleep  1
    Set ith item in mrp   ${item2}    100
#    Set ith item in mrp   ${item3}    100
#    Set ith item in mrp   ${item4}    100
    click  //input[@aria-label='Select all']
    Select Option From Dropdown By Inputting    ${vendorselection}    Steven Campbell
    click  ${continuebtn}
    sleep   1
    Date Entry of mrp