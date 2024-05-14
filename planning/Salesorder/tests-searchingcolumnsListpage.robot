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
    click  ${Soinputfield}
    press keys  ${Soinputfield}  CTRL+A  BACKSPACE
    input  ${Soinputfield}  ${search_keyword}
    press keys  ${Soinputfield}  ENTER
    Search and Verify in SO Column    ${so_details}    ${search_keyword}






*** Keywords ***

Search and Verify in SO Column
    [Arguments]    ${so_details}    ${keyword}
    ${result}    Run Keyword And Return Status    Should Contain    ${so_details}    ${keyword}
    Run Keyword If    not ${result}
    ...    Fail    No result found for the search keyword '${keyword}'
    ...    ${keyword} is not displayed in the SO column
    ${element_count}    Get Element Count    xpath=//td[contains(text(),'${keyword}')]
    Run Keyword If    ${element_count} == 0
    ...    Fail    No visible result found for the search keyword '${keyword}'
    ...    ${keyword} is not visible in the SO column
    Element Should Be Visible    xpath=//td[contains(text(),'${keyword}')]
    Log    Correct result displayed for the search keyword '${keyword}'