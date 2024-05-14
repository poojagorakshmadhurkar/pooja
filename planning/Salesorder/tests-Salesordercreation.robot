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
    open order tracker page
    click  ${newSO}
    wait until page contains element  //span[text()="Add New SO"]  timeout=10s
    select customer  ${customername}[0]
    ${randomrefNumber}=  generate random string  5-10  [NUMBERS]
    input  ${refNumber}  ${randomrefNumber}
    delivery date entry
    ${today1}    Get Current Date  result_format=%d-%m-%Y
    set ith item in so  0  ${itemData1}[0]  ${itemData1}[1]
    click  ${submit}
    sleep  2
    ${order_info}    Get Text    xpath=//div[contains(@style, 'text-align: center;')]
    ${start_index}    Evaluate    "${order_info}".find("Order ") + len("Order ")
    ${end_index}    Evaluate    "${order_info}".find(" has been created!")
    ${order_number}    Evaluate    "${order_info}"[${start_index}:${end_index}]
    click  ${createNewOrder}
    sleep  2
    click  ${backbutton}


    #validation for so creation search
    search Sonumber in SoListpage for validation  ${order_number}
    wait until page contains element  //a[text()="${order_number}"]/../../../../../../../../../td[2][text()="${randomrefNumber}"]/../td[3][text()="${customername}[0]"]  timeout=30s



