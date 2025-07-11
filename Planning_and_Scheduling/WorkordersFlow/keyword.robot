*** Settings ***
#Library  SeleniumLibrary
Library  String
Library  Collections
Resource  ../../keywords.robot
Resource  ../../variables.robot
Library  DateTime
#Resource  ../../orders/salesorder/variables.robot
Resource  ../../orders/salesorder/keywords.robot
Resource  variable.robot
Library    BuiltIn
Library    DateTime
Library  OperatingSystem
Library  CSVLibrary  # Make sure to have a CSV handling library installed
Library    Browser

*** Variables ***
${EXCEL_FILE_PATH}  C:/Users/user/Downloads.csv



*** Keywords ***

click on machine button for workorder or downtime creation
   [Arguments]  ${machinename}  ${inputvalue}  ${itemname}  ${rule}
   click   //div[text()="${machinename}"]/../../button[starts-with(@id, 'create_workorder_')]
   input   //input[@id="label"]  ${inputvalue}
   Wait For Elements State        //span[text()="${itemname}"]/../../../../../../../../../../td[1][text()="1,000 piece"]/../td[4]//span[text()="${rule}"]   visible  timeout=60s
   click  ${reviewbutton}

Extract Time From Packaging String
    [Arguments]    ${packaging_string}
    ${split_by_parenthesis} =    Split String    ${packaging_string}    (
    ${time_with_closing_parenthesis} =    Set Variable    ${split_by_parenthesis[1]}
    ${time_string} =    Split String    ${time_with_closing_parenthesis}    )
    RETURN    ${time_string[0]}

Calculate Total Time
    [Arguments]    ${time_string}    ${units}
    # Split time into minutes and seconds
    ${split_time} =    String.Split String    ${time_string}    m
    ${minutes} =       BuiltIn.Convert To Integer    ${split_time[0]}
    ${seconds} =       BuiltIn.Convert To Integer    ${split_time[1].replace('s', '').strip()}
    # Calculate total time per unit
    ${time_per_unit_in_seconds} =    BuiltIn.Set Variable    ${minutes} * 60 + ${seconds}
    # Multiply by number of units
    ${total_time_in_seconds} =    BuiltIn.Set Variable    (${time_per_unit_in_seconds}) * ${units}
    # Convert to hours and minutes
    ${hours} =    BuiltIn.Evaluate    ${total_time_in_seconds} // 3600
    ${remaining_seconds} =    BuiltIn.Evaluate    ${total_time_in_seconds} % 3600
    ${minutes} =    BuiltIn.Evaluate    ${remaining_seconds} // 60
    ${formatted_time} =    Set Variable    ${hours}h ${minutes}m
    Log    Total time: ${formatted_time}
    RETURN    ${formatted_time}

Get All Workorders IDs
    [Documentation]    Fetch all workorder IDs and return the latest one.
    ${elements} =    Get Elements    xpath=//div[@data-task-id]
    # Initialize an empty list to store task IDs
    ${task_ids} =    Create List
    # Loop through each element to extract 'data-task-id' attribute
    FOR    ${element}    IN    @{elements}
        ${task_id} =    Get Attribute    ${element}    data-task-id
        Append To List    ${task_ids}    ${task_id}
    END
    # Check if the list is empty before proceeding
    Run Keyword If    len(${task_ids}) == 0    Log    No work orders found. Workorder might be deleted.
    Run Keyword If    len(${task_ids}) == 0    Return From Keyword
    ${latest_task_id} =    Set Variable    ${task_ids[-1]}
    Log    The latest data-task-id is: ${latest_task_id}
    RETURN    ${latest_task_id}


Get All rules data
    [Arguments]    ${itemData1}   ${ROW_SELECTOR}
    # Click the item
    Click    (//a[text()="${itemData1}[0]"])[1]
    sleep  1
    # Get the handles of all open tabs
    ${handles}=    Get Page Ids
    # Switch to the new tab
    Switch Page            ${handles}[0]
    Sleep    2
    # Get rules in the item
    Click    ${rulesbutton}
    ${elements}=    Get Elements        ${ROW_SELECTOR}//th | ${ROW_SELECTOR}//td
    ${cell_values}=    Create List
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Text    ${element}
        Log    Element text: ${text}
        Append To List    ${cell_values}    ${text}
    END
    ${first_value}=    Set Variable    ${cell_values[0]}
    ${second_value}=   Set Variable    ${cell_values[1]}
    ${third_value}=    Set Variable    ${cell_values[2]}
    ${fourth_value}=   Set Variable    PACKAGING (${cell_values[3]})
    ${cell_values}=    Create List    ${fourth_value}
    ${fourth_value}=    Set Variable    ${cell_values[0]}
    ${time_string}=    Extract Time From Packaging String    ${fourth_value}
    Log    All cell values: ${cell_values}
    Switch Page           ${handles}[1]
    Sleep    2
    RETURN    ${time_string}    ${third_value}   ${fourth_value}


Get Texts
    [Arguments]   ${xpath}
    ${elements}=    Get Elements        ${xpath}
    ${texts}=    Create List
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Text    ${element}
        Append To List    ${texts}    ${text}
    END
    RETURN  ${texts}


Get Files In Directory
    [Arguments]  ${directory}
    ${files}=  List Files In Directory  ${directory}
    RETURN  ${files}

Find New File
    [Arguments]    ${files_before}    ${files_after}
    ${new_files} =    Evaluate    list(set(${files_after}) - set(${files_before}))
    RETURN    ${new_files}


Workorder buttons
    [Arguments]  ${i}  ${workordernumber}
    click  (//div[text()="${work_order_number}"]/../../../../../../div//button)[${i}]//*[name()='svg'][@class='MuiSvgIcon-root MuiSvgIcon-fontSizeMedium css-vubbuv']

set ith item in productionForm only Quantity
    [Arguments]  ${i}  ${recievedName}  ${recievedQuantity}
    Wait For Elements State        //span[text()="${recievedName}"]  visible  timeout=60s
#    press keys    //input[@id="production_qty_${i}"]  CTRL+A  BACKSPACE  ${recievedQuantity}
    Fill Text     //input[@id="production_qty_${i}"]     ${recievedQuantity}

Planning and scheduling

    click  //button[@type='button' and contains(@class, 'MuiButton-root')]//span[text()='Planning & Scheduling']

#    click  //ul[@id="menu-list-grow"]//a[@id="scheduling"]
#    I Should See Text On Page        Scheduling
    click  //ul[@id="menu-list-grow"]//a[@id='machine_scheduling']
    sleep  1
    Reload
    sleep  1






Compare Work Orders
    [Arguments]    ${work_orders_from_table}    ${work_orders_from_csv}
    Log    Work Orders from Table: ${work_orders_from_table}
    Log    Work Orders from CSV: ${work_orders_from_csv}
    Lists Should Be Equal    ${work_orders_from_table}    ${work_orders_from_csv}

Get Work Orders From Elements
    [Arguments]    ${work_order_elements}
    ${work_order_ids}=    BuiltIn.Create List
    FOR    ${element}    IN    @{work_order_elements}
        ${text}=    ${element}.text
        Append To List    ${work_order_ids}    ${text}
    END
    RETURN    ${work_order_ids}


Workorder creation
    [Arguments]    ${itemData1}  ${customername}   ${machine}
    ${order_number}=  Create SO  ${customername}  ${itemData1}
    click  (//a[text()="${order_number}"]/../../../../../../../../span)[1]
    Wait For Elements State      //div[text()="${order_number}"]    visible   timeout=30s
    #getting rules in the item
    ${time_string}  ${processname}  ${Rulestime}=  Get All rules data  ${itemData1}  //tbody[@class="MuiTableBody-root css-1xnox0e"]
    click  //button[normalize-space()='Create']
    click  ${createworkorderbutton}
    sleep  1
    ${all_windows}=    Get Page Ids
    Log    ${all_windows}
    Switch Page            ${all_windows[0]}
    Log    Switched to window: ${all_windows[0]}
    Wait For Elements State      //div[text()="${machine}[0]"]   visible  timeout=60s
    click on machine button for workorder or downtime creation  ${machine}[0]  ${itemData1}[2]  ${itemData1}[0]  ${Rulestime}
    #calculation of RUles TImining in hours
    ${total_time} =    Calculate Total Time    ${time_string}    ${itemData1}[2]
    Log    Total time for 100 units: ${total_time}
    click  ${createworkorder}
    I Should See Text On Page        Work Order Created Successfully
    #get all Workorders ID
    ${newly_workorder_id}=    Get All Workorders IDs
    click  //div[@data-task-id="${newly_workorder_id}"]
    ${work_order_number} =    Get Text    id=woText
    Wait For Elements State        //div[text()="${customername}[0]"]/../../..//a[text()="${order_number}"]   visible  timeout=60s
    Wait For Elements State     (//div[text()="${machine}[0]"])[2]/../../../../div[2]//div[text()="${total_time}"]    visible  timeout=60s
#    Wait For Elements State     //span[text()="${itemData1}[0]"]/../../../../../../../../../td[2][text()="${processname}"]   visible  timeout=60s
    #In salesorder validaion of workorder
    Switch Page            ${all_windows[2]}
    #salesorder workordercarview validation
    click  //div[@id="item__tabs-tab-5"]
#    Wait For Elements State    //span[text()="${itemData1}[0]"]/../../../../../../../../../td[2][text()="${processname}"]/../td[5][text()="${itemData1}[2]"]    visible  timeout=60s
    Wait For Elements State    //div[text()="${total_time}"]/../../../../..//div[text()="${machine}[0]"]/../..//div[text()="${work_order_number}"]    visible  timeout=60s
    #validation in table view
    click  ${tableviewbutton}
#    Wait For Elements State     //div[text()="${work_order_number}"]/../../td[4][text()="${machine}[0]"]/../td[5]//span[text()="${itemData1}[0]"]/../../../../../../../../../td[6][text()="${processname}"]   visible  timeout=60s


open machine page
    click  ${mastersDropdown}
    click  ${mastersMachines}
    Reload

Get Machine Labels
    ${elements}=    Get Elements        xpath=//tbody[@class='ant-table-tbody']//tr[contains(@class, 'ant-table-row')]//a
    ${labels}=    Create List
    FOR    ${element}    IN    @{elements}
        ${label}=    Get Text    ${element}
        Append To List    ${labels}    ${label}
    END
    RETURN    ${labels}


Click All Expand Buttons As They Appear
    WHILE    ${True}
        ${buttons}=    Get Elements        ${machineexpanbutton}
        ${button_count}=    Get Length    ${buttons}

        Run Keyword If    ${button_count} == 0    Exit For Loop

        FOR    ${button}    IN    @{buttons}
            ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${button}
            Run Keyword If    ${is_visible}    Click    ${button}
            Sleep    0.5    # Small delay to allow any new buttons to load
        END
    END

    


