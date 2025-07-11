*** Settings ***
#Library  SeleniumLibrary
Resource  ../../variables.robot
Resource  ../../keywords.robot
Library  OperatingSystem
Library  Process
Resource   ../../orders/Salesorder/keywords.robot
Resource   ../../orders/Salesorder/variables.robot

Resource  keyword.robot
Resource  ../../inventory/transactions/keywords.robot
Library  Browser
Resource  variable.robot
Resource    ../../inventory/transactions/keywords.robot






*** Variables ***
@{itemdata}  ManufappZohotest02  Vendortest03




*** Test Cases ***

Pocreation and verification on zoho
    login devsite
#    select site  testingsiteautomation
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
    search Sonumber in POListpage for validation   ${order_number}
    click   (//a[text()="${order_number}"]/../../../../../../../../../../td[9]//button[@id="enable"])[1]
    I Should See Text On Page    ${order_number} Issued
    click  ${inwardbtn}
    click  (//input[contains(@type,'checkbox')])[2]
    click  //button[@id='po_inward_autofill']
    click   //div[contains(text(),'Submit')]
    I Should See Text On Page      Inward note created Successfully
#    ${order_number}=    Create_PO   ${ItemData}   ${vendor}
#    click   (//*[@id="purchase_order_approve"])[1]

    # ✅ Fetch the PO Integration ID (Assuming it is in order_number)
    ${po_integration_id} =  Set Variable  ${order_number}  # Update this if needed

    # ✅ Check if Purchase Receipt is visible on Zoho using Python script
    ${result} =  Run Process  python  C:\\Users\\user\\PycharmProjects\\WebAutoamtion\\Suite\\IntegrationCases\\Zohointegration\\purchasereceives.py  ${po_integration_id}  shell=True  stdout=stdout.txt  stderr=stderr.txt

    # Log the output
    ${output} =  Set Variable  ${result.stdout}
    Log  ${output}

    # Also log the contents of stdout.txt to check API response
    ${response} =  Get File  stdout.txt
    Log  ${response}

    # Validate if the Purchase Receipt exists in Zoho
    Should Be Equal As Integers    ${result.rc}    ${0}    "❌ Purchase Receipt was not found in Zoho!"