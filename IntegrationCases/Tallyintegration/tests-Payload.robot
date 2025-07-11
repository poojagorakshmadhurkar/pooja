*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    BuiltIn

*** Variables ***
${URL}    https://pywlyaov20.execute-api.ap-south-1.amazonaws.com/tally_dev

*** Test Cases ***
Check API Response Code

    Create Session    api_session    ${URL}
    ${response}=    GET On Session    api_session    /
    Should Be Equal As Numbers    ${response.status_code}    200
    ${json_response}=    Set Variable    ${response.json()}
    Log    ${json_response}
    Dictionary Should Contain Key    ${json_response}    transactions
    ${transactions}=    Get From Dictionary    ${json_response}    transactions
    ${length}=    Get Length    ${transactions}
    Should Be True    ${length} > 0
    Should Not Be Empty    ${transactions}

