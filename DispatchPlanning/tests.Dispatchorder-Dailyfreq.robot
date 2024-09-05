*** Settings ***
Library  SeleniumLibrary
Resource  ../keywords.robot
Resource  ../planning/Salesorder/variables.robot
Library  String
Library  Collections
Resource  ../variables.robot
Resource  ../planning/Salesorder/keywords.robot
Resource   ./variables.robot
Resource   ./keyword.robot


*** Variables ***
@{customername}  Test01
@{itemData1}  Fgitem1  1000   500
@{itemData2}  FGitem3  100
@{itemData3}  FGitem2  100
@{DAYS_GAP}    4





*** Test Cases ***
Dispatch planning
    Set Selenium Speed    0.1
    login devsite
    select site  testingsiteautomation
    ${order_number}=  Create salesorder  ${customername}  ${itemData1}
    sleep  1
    #Dispatch validaiton
    click  ${dispatchplanbutton}
    wait until page contains   ${order_number}
    sleep  1
    Select Option from FrequencyDropdown  Daily
    ${start_date}  ${end_date}=    Delivery Date Entry with 7 days gap
    Log    Dates from ${start_date} to ${end_date} have been processed.
    set ith item in Dispatch only quantity  0  ${itemData1}[0]  ${itemData1}[2]
    # Convert dispatch per day to integer
    Calculate And Verify Dispatch textperdispatch    ${itemData1}[2]   4
    sleep  1
    Click  ${dipatchsubmitbutton}
    sleep  1
    ${dispatch_number}=    Get Dispatch Number
    sleep  1
    click  ${viewschdeuledispatch}
    sleep  2
    Log    Customer name: ${customername}
    #Click on drawer
    Using search filters of SO  ${order_number}
    sleep  2
    # Count the number of dispatch events for the customer
    # Get all dispatch elements for the customer
    ${elements}=  Get WebElements  //p[contains(text(),"${customername}[0]")]
    ${dispatch_count}=  Get Length  ${elements}
    Log    Number of dispatch events: ${dispatch_count}
    ${DAYS_GAP_SINGLE}=  Get From List  ${DAYS_GAP}  0
    ${DAYS_GAP_INT}=  Convert To Integer  ${DAYS_GAP_SINGLE}
    # Verify the number of dispatch events matches the expected count
    Should Be Equal  ${dispatch_count}  ${DAYS_GAP_INT}


    Open Order Tracker Page
    search Sonumber in SoListpage for validation  ${order_number}
    click  //a[text()="${order_number}"]/../../../../../../../../span
    sleep  2
    wait until element is visible    //a[text()="${itemData1}[0]"]/../../../../../../../../../td[5]//div[text()="${itemData1}[2] piece"]

