*** Settings ***
#Library  SeleniumLibrary
Resource  ../../variables.robot
Resource  ../../masters/production/items/keywords.robot
Resource  ../../masters/production/items/variables.robot
#Resource  ../../variables.robot
Resource  ../../keywords.robot

Library  OperatingSystem
Library  Process
Library  Browser

*** Variables ***





*** Test Cases ***
itemcreation and zoho validation
    login devsite
#    select site  testingsiteautomation
    open item page
    click  ${newIcon}
    ${randomItemCode}=  generate random string  5-8  [LETTERS]
    Fill Text    ${itemCode}  ${randomItemCode}
    ${randomItemName}=  generate random string  5-8  [LETTERS]
    Fill Text    ${itemName}  ${randomItemName}
    select option from dropdown by inputting   //input[@id='item__itemGroup']  Itemgroup1
#    select option from dropdown using span  ${itemgroup}  Compounds
    click  ${Submit}
    i should see text on page  Item added
    click  (//button[@aria-label='back-button'])[2]
    Reload
    item should be added  ${randomItemName}
     # Run the Python script and pass item name as an argument
    # Run Python script to check item existence in Zoho
    ${result} =  Run Process  python  C:\\Users\\user\\PycharmProjects\\automation\\Suite\\IntegrationCases\\Zohointegration\\check_zoho_item.py  ${randomItemName}  shell=True  stdout=stdout.txt  stderr=stderr.txt

    # Log the output
    ${output} =  Set Variable  ${result.stdout}
    Log  ${output}

    # Also log the contents of stdout.txt to check API response
    ${response} =  Get File  stdout.txt
    Log  ${response}

    # Validate if the item exists
    Should Be Equal As Integers    ${result.rc}    ${0}    "❌ Item was not found in Zoho!"




#
#    # item Edit flow in ZOHO
#    click  (//*[name()='svg'][@id='Layer_2'])[9]
#    ${randomitemname1}=  generate random string  5-10  [LETTERS]
#    sleep  1
#    Click Element    ${zohoinputfeild}
#    Press Keys      ${zohoinputfeild}    CTRL+A    BACKSPACE
#    input  ${zohoinputfeild}   ${randomitemname1}
#    Click  ${savebtn}
#    Wait Until Element Is Visible    (//span[text()="${randomitemname1}"])[2]

