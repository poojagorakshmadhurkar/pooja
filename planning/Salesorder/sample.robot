*** Settings ***
Library           SeleniumLibrary
Library           Collections
Library           String
Resource          ../../keywords.robot
Resource          ./keywords.robot
Resource          ../../inventory/transactions/keywords.robot
Resource          ../../variables.robot
Resource          ./variables.robot
Library    custom_library.py


*** Variables ***
${SO_DETAILS_XPATH}    //tbody/tr//td[1]
${SO_DETAILS_SORT_BUTTON}  (//span[@class='ant-table-column-title']//div)[1]

*** Test Cases ***
Creation of SO
    Set Selenium Speed    0.1
    login

    open order tracker page
    sleep    5
    click    //h5[text()="sales orders"]
       # Click on the sort button for SO Details column
    ${so_details}    Extract SO Details From Page
    wait until element is visible    ${SO_DETAILS_SORT_BUTTON}
    Scroll Element Into View    ${SO_DETAILS_SORT_BUTTON}
    sleep  2
    click element  ${SO_DETAILS_SORT_BUTTON}
    Log Many    ${so_details}
    Verify Sorting Functionality    ${so_details}




*** Keywords ***
Extract SO Details From Page
    ${so_details}    Create List
    ${elements}    Get WebElements    ${SO_DETAILS_XPATH}
    FOR    ${element}    IN    @{elements}
        ${detail_text}    Get Text    ${element}
        Append To List    ${so_details}    ${detail_text}
    END
    [Return]    ${so_details}

Verify Sorting Functionality
    [Arguments]    ${so_details}
    [Documentation]    Verifies if the SO details are sorted correctly.
    Collections.Sort List    ${so_details}
    ${sorted_details}    Convert To List    ${so_details}
    Should Be Equal As Strings    ${so_details}    ${sorted_details}
    Log    So Details column is sorted correctly.