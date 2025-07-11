*** Settings ***
#Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Library  String
Library  Collections
Library    Browser
#Resource  ../../inventory/transactions/keywords.robot
#Resource  ../../variables.robot
#Resource  ./variables.robot

*** Variables ***
@{customername}  Test01
@{itemData1}  Fgitem1  100




*** Test Cases ***
Creation of SO
    login devsite
    select site  testingsiteautomation
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
    ${item3}=    Get From List    ${items}    2

     Switch Page       ${pages}[1]
    Wait For Elements State      //div[text()="${order_number}"]    visible  timeout=30s
    click  //div[@id="item__tabs-tab-2"]

    Wait For Elements State      //a[text()="${item1}"]    visible  timeout=30s
    Wait For Elements State     //a[text()="${item2}"]    visible  timeout=30s




