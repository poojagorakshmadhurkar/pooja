*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Library  String
Library  Collections
#Resource  ../../inventory/transactions/keywords.robot
#Resource  ../../variables.robot
Resource  ./variables.robot


*** Variables ***
${SO_Details_Xpath}    //tbody/tr//td[1]




*** Test Cases ***
creation of so
    Set Selenium Speed    0.1
    login devsite
    select site  testingsiteautomation
    open order tracker page
    sleep    5
    click    //h5[text()="sales orders"]
    ${so_details}    Extract SO ListPage ColumnDetails  ${SO_Details_Xpath}

    ${random_index}    Evaluate    random.randint(0, len($so_details)-1)
    ${search_keyword}    Set Variable    ${so_details}[${random_index}]
    Wait Until Element Is Clickable  ${SOdetailsFilter}  timeout=30s
    click element  ${SOdetailsFilter}
    sleep  2
    Click Element    ${Soinputfield}
    Press Keys   ${Soinputfield}    CTRL+A    BACKSPACE
    Input Text   ${Soinputfield}    ${search_keyword}  ENTER
    Sleep   1s
#    Press Keys   ${Soinputfield}    ENTER

    Search and Verify in SO Column    ${so_details}    ${search_keyword}







*** Keywords ***
Search and Verify in SO Column
    [Arguments]    ${so_details}    ${search_keyword}

    # Split the search_keyword string by lines and get the first line
    ${so_number}=    Set Variable    ${search_keyword.splitlines()[0]}

    # Log only the SO number
    Log    Searching for SO: ${so_number}

    Log    SO Details: ${so_details}
    Sleep    2s
    wait until element is visible    //a[text()="${so_number}"]

    # Log success



