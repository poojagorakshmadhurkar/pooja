*** Settings ***
Library   Browser
Library   DateTime
Library   String
Library   Collections
Resource  ../orders/PurchaseOrder/keyword.robot
Resource  ../orders/PurchaseOrder/variable.robot
Resource  ../Access_Control/Variable.robot
Resource  Keyword.robot
Resource  Variable.robot
*** Variables ***
@{DT_Reason}   No-Plan  Power Cut  NO-PLAN
@{Machine}   MFG-1   Work_Order_Machine
*** Test Cases ***
Delete Downtime
    # Log in and navigate to Scheduling
    Login To ManufApp Site
    Click    ${PLANNING_&_SCHEDULING}
    Click    ${Scheduling_1}
    Click    ${Manuf_Logo}
    Sleep    1s
    # Set date filter to Yesterday
    Click    //*[@placeholder="Start date"]
    Click    //*[text()="Yesterday"]
    # Refresh data and wait for stability
    Click    //*[@data-testid="RefreshIcon"]
    Sleep    1s
    # Get all downtime elements
    Wait For Response
    Sleep    5s
    ${DT_List}=    Get Elements   //*[@class="sg-task-content svelte-13pjhle"]
    ${count}=    Get Length    ${DT_List}
    Should Be True    ${count} > 0    No downtimes found for yesterday
    Wait For Response   timeout=30s
    # Process downtimes
    FOR    ${DT}    IN    @{DT_List}
        Sleep    1s
        ${downtime_id}=    Get Attribute    ${DT}    attribute=class
        Log To Console    Processing downtime ID: ${downtime_id}
        # Open downtime context menu
        Click    ${DT}
        Wait For Elements State    ${Delete_DTM}    visible    timeout=10s
        # Delete downtime
        Click    ${Delete_DTM}
        # Confirm deletion
        Wait For Elements State    ${Delete_DT_Msg}    visible    timeout=10s
        ${Text_A}=    Get Text    ${Delete_DT_Msg}
        Log To Console    ✅ ${Text_A}
        Log To Console    ✅ Downtime ${downtime_id} Deleted Successfully
        # Refresh after deletion
        Click    //*[@data-testid="RefreshIcon"]
        Wait For Load State    timeout=5s
    END
    Close Browser

