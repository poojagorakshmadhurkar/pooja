*** Settings ***
Library  Browser
Library  OperatingSystem
Library  Process
Resource  ../../variables.robot
Resource  ../../keywords.robot
Resource   ../../orders/Salesorder/keywords.robot
Resource   ../../orders/Salesorder/variables.robot
Resource  keyword.robot
Resource  variable.robot
Resource    ../../inventory/transactions/keywords.robot

*** Variables ***
@{itemdata}  ManufappZohotest02  Vendortest03

*** Test Cases ***
Pocreation and verification on zoho
    login devsite
    Open Po Tracker Page
    sleep  2
    click   (//a[normalize-space()='NEW'])[1]
    Select Option From Dropdown By Inputting    //input[@id='purchase_order_vendor']    Vendortest03
    Delivery Date Entry
    Set Ith Item In PO Zoho    0  ${itemdata}[0]   100
    click  ${posubmit}
    ${order_info}    browser.Get Text    xpath=//div[contains(@style, 'text-align: center;')]
    ${start_index}    Evaluate    "${order_info}".find("Order ") + len("Order ")
    ${end_index}    Evaluate    "${order_info}".find(" has been created!")
    ${order_number}    Evaluate    "${order_info}"[${start_index}:${end_index}]
    click  ${createNewOrder}
    click  ${backbutton}
    click   (//a[text()="${order_number}"]/../../../../../../../../../../td[9]//button[@id="enable"])[1]
    I Should See Text On Page    ${order_number} Issued
    search Sonumber in POListpage for validation   ${order_number}
    sleep  1
    # ✅ Check if PO is visible on Zoho using Python script
    ${result} =  Run Process  python  C:\\Users\\user\\PycharmProjects\\automation\\Suite\\IntegrationCases\\Zohointegration\\check_zoho_po.py  ${order_number}  shell=True  stdout=stdout.txt  stderr=stderr.txt
    #Log the output
    ${output} =  Set Variable  ${result.stdout}
    Log  ${output}
    # Also log the contents of stdout.txt to check API response
    ${response} =  Get File  stdout.txt
    Log  ${response}
    # Validate if the PO exists in Zoho
    Should Be Equal As Integers    ${result.rc}    ${0}    "❌ Purchase Order was not found in Zoho!"


























