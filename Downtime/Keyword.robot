*** Settings ***
Library   Browser
Library   DateTime
Library   String
Library   Collections
Resource   ../orders/PurchaseOrder/keyword.robot
Resource   ../orders/PurchaseOrder/variable.robot

*** Keywords ***
Open Browser In Headless Mode
    [Documentation]    Opens the browser in headless mode
    New Browser    chromium    headless=false  channel=chrome
    New Page   ${DEVURL}
    Set Viewport Size    1410    720
    Fill Text  ${email}  admin@smart.com    #pooja_dev@testing.com  nitish@sandbox.com
    Fill Text  ${password}  271828  #4652049559   8824427172   #Manufapp2023
    Click  ${signIn}
    Wait For Elements State  ${signIn}  hidden  timeout=10s  # Ensure login is successful

Select time
    [Arguments]    ${inputtime}
    ${time}=    Get Elements    class="ant-picker-time-panel-column"
    FOR    ${a1}    IN    @{time}
        IF    ${inputtime} == ${a1}
            Click    ${inputtime}
        ELSE
            CONTINUE
        END
        Log    ${a1}

    END
Create Downtime
    [Arguments]    ${machine_id}
    # Your downtime creation logic
    input    id=machine_id_field    ${machine_id}
    Fill Text    id=start_time_field    12:36:00
    Fill Text    id=end_time_field      18:00:00
    Click         id=create_downtime_button
    Wait For Response    timeout=5s

Click Latest Downtime Div
    [Arguments]    ${machine_id}
    # Get all divs with downtime attribute
    ${divs}=    Get Elements    //div[@downtime]

    # Variables to track latest downtime
    ${latest_div}=    Set Variable    ${None}
    ${latest_time}=    Set Variable    1970-01-01 00:00:00  # Initialize with old date

    # Loop through divs to find the latest downtime
    FOR    ${div}    IN    @{divs}
        ${downtime_value}=    Get Attribute    ${div}    downtime
        ${split_values}=    Split String    ${downtime_value}    _
        ${found_machine_id}=    Set Variable    ${split_values[0]}
        ${start_time}=    Set Variable    ${split_values[1]}

        # Check if machine ID matches
        Run Keyword If    '${found_machine_id}' == '${machine_id}'
        ...    Run Keywords
        ...    Compare And Update Latest    ${div}    ${start_time}    ${latest_time}
        ...    AND    Set Variable    ${latest_div}    ${div}
        ...    AND    Set Variable    ${latest_time}    ${start_time}
    END

    # Fail if no matching downtime found
    Run Keyword If    '${latest_div}' == '${None}'    Fail    No downtime found for machine ID ${machine_id}

    # Click the latest downtime div
    Click    ${latest_div}

Compare And Update Latest
    [Arguments]    ${div}    ${start_time}    ${current_latest_time}
    # Convert times to comparable format
    ${start_time_dt}=    Convert Date    ${start_time}    result_format=datetime
    ${current_latest_dt}=    Convert Date    ${current_latest_time}    result_format=datetime
    # Update if start_time is later
    Run Keyword If    ${start_time_dt} > ${current_latest_dt}
    ...    Set Test Variable    \${latest_div}    ${div}
    ...    AND    Set Test Variable    \${latest_time}  ${start_time}

#Create Sales_Order
#    [Arguments]
