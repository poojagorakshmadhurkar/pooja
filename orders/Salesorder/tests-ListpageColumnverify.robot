*** Settings ***
Resource  ../../keywords.robot
Resource  ./keywords.robot
Library  String
Library  Collections
Library  Browser

*** Variables ***
@{customername}  Cust-003
@{itemData1}  09170_G  100


*** Test Cases ***
Verify List Page Columns
    login devsite
    select site  testingsiteautomation
    open order tracker page
    Wait For Elements State    //h5[text()="sales orders"]    visible    timeout=120s
    click    //h5[text()="sales orders"]

    ${column_names}=    Get Elements    xpath=(//table[@style='table-layout: fixed;'][1]//tr)[1]
    ${actual_columns}=    Create List

        FOR    ${column}    IN    @{column_names}
        ${column_text}=    Get Text    ${column}
        ${cleaned}=    Clean And Split Column Text    ${column_text}
        FOR    ${item}    IN    @{cleaned}
            Append To List    ${actual_columns}    ${item}
        END
    END


    Log Many    @{actual_columns}
    ${expected_columns}=    Create List    SO Details    Ref #    Customer    SO Start Date    Delivery Date    Created by    Demanded    Production planned    Produced    Dispatch planned    Shipped    SO Price    Actions
    Lists Should Be Equal    ${actual_columns}    ${expected_columns}
    Close Browser




*** Keywords ***
Clean And Split Column Text
    [Arguments]    ${text}
    ${lines}=    Split To Lines    ${text}
    ${result}=    Create List
    FOR    ${line}    IN    @{lines}
        ${line}=    Strip String    ${line}
        ${has_tabs}=    Run Keyword And Return Status    Should Contain    ${line}    \t
        IF    '${line}' != '' and ${has_tabs}
            ${parts}=    Split String    ${line}    \t
            FOR    ${part}    IN    @{parts}
                ${part}=    Strip String    ${part}
                Run Keyword If    '${part}' != ''    Append To List    ${result}    ${part}
            END
        ELSE IF    '${line}' != ''
            Append To List    ${result}    ${line}
        END
    END
    [Return]    ${result}
