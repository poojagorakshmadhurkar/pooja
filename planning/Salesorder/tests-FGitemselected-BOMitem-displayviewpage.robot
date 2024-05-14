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




*** Test Cases ***
Creation of SO
    Set Selenium Speed    0.1
    login devsite
    select site  testingsiteautomation
    ${order_number}=  Create SO  ${customername}  ${itemData1}
    click  //a[text()="${order_number}"]/../../../../../../../../span
    Wait Until Page Contains Element  //div[text()="${order_number}"]    timeout=30s
    sleep  2
    #expand button
    Click  //span[@aria-label="Expand All"]
    #check itemsBom
    click  //a[text()="${itemData1}[0]"]
    # Get the handles of all open tabs
    ${handles}    Get Window Handles
    # Switch to the new tab
    SeleniumLibrary.Switch Window    ${handles}[1]
    sleep  2
    #expand button
    click  //button[@class='ant-switch ant-switch-small'][@role='switch']
    #Get Item Names
    ${item_elements}=    Get WebElements    xpath://span[contains(@class, 'ant-tree-title')]
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
    sleep  1
    SeleniumLibrary.Switch Window    ${handles}[0]
    Wait Until Page Contains Element  //div[text()="${order_number}"]    timeout=30s
    click  //div[@id="item__tabs-tab-2"]

    wait until page contains  ${item1}
    wait until page contains  ${item2}
    sleep  1




