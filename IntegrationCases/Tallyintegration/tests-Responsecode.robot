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
     # Use Set Variable to store the JSON response
    ${json_response}=    Set Variable    ${response.json()}

    Log    ${json_response}  # Log to see the full response and check structure

    # Correct FOR loop syntax
     FOR    ${transaction}    IN    @{json_response['transactions']}
        ${inventory_details}=    Get From Dictionary    ${transaction}    InventoryDetails
        Should Not Be Empty    ${inventory_details}
    END