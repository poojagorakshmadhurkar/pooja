*** Settings ***
#Library  SeleniumLibrary
Resource  ../keywords.robot
#Resource  ../orders/Salesorder/variables.robot
Library  String
Library  Collections
#Resource  ../variables.robot
Resource  ../orders/Salesorder/keywords.robot
Resource   ./variables.robot
Resource   ./keyword.robot
Library    Browser


*** Variables ***
@{customername}  Test01
@{itemData1}  Fgitem1  1000   500
@{itemData2}  FGitem3  100
@{itemData3}  FGitem2  100
@{DAYS_GAP}    4





*** Test Cases ***
Dispatch planning
    login devsite
    select site  testingsiteautomation
    ${order_number}=  Create salesorder  ${customername}  ${itemData1}
    #Dispatch validaiton
    click  ${dispatchplanbutton}
    Wait For Elements State    (//span[text()="${order_number}"])[1]  visible   timeout=60s
    Select Option from FrequencyDropdown  Daily
    ${start_date}  ${end_date}=    Delivery Date Entry with 7 days gap
    Log    Dates from ${start_date} to ${end_date} have been processed.
    set ith item in Dispatch only quantity  0  ${itemData1}[0]  ${itemData1}[2]
    # Convert dispatch per day to integer
    Calculate And Verify Dispatch textperdispatch    ${itemData1}[2]   4
    Click  ${dipatchsubmitbutton}
    ${dispatch_number}=    Get Dispatch Number
    click  ${viewschdeuledispatch}
    Log    Customer name: ${customername}
    #search Dipatch based on so number search
    Using search filters of SO  ${order_number}
    sleep  1
    # Count the number of dispatch events for the customer
    ${elements}=  Get Elements      //p[text()="${customername}[0]"]
    ${dispatch_count}=  Get Length  ${elements}
    Log    Number of dispatch events: ${dispatch_count}
    ${DAYS_GAP_SINGLE}=  Get From List  ${DAYS_GAP}  0
    ${DAYS_GAP_INT}=  Convert To Integer  ${DAYS_GAP_SINGLE}
    # Verify the number of dispatch events matches the expected count
#    Should Be Equal  ${dispatch_count}  ${DAYS_GAP_INT}
    #open anyone dispatch drawer
    ${dispatchordernumber}=    Strip String    ${dispatch_number}
    click    //div[@role="button" and @aria-label="Select View"]
    click    //li[@role="button" and contains(text(), "Day")]
    Open Event Daywise Drawer  ${customername}  ${dispatchordernumber}
    #Delete This Shipment validation
    click  ${dispatchdeletebutton}
    click  ${deletethisshipmentbutton}
    click   ${agreebutton}
    I Should See Text On Page        Event deleted
    #again check the Dispatch counts after deleting Dispatch event
    click  ${innerreloadbutton}
    sleep  1
    ${elements1}=  Get Elements      //p[text()="${customername}[0]"]
    ${dispatch_count1}=  Get Length  ${elements1}
    Log    Number of dispatch events: ${dispatch_count1}
    ${DAYS_GAP_SINGLE}=  Get From List  ${DAYS_GAP}  0
    ${DAYS_GAP_INT}=  Convert To Integer  ${DAYS_GAP_SINGLE}
    # Verify the number of dispatch events matches the expected count
    #open salesorder page
    Open Order Tracker Page
    search Sonumber in SoListpage for validation  ${order_number}
    click  (//a[text()="${order_number}"]/../../../../../../../../span)[1]
    sleep  1
#    wait until element is visible    //a[text()="${itemData1}[0]"]/../../../../../../../../../td[5]//div[text()="${itemData1}[2] piece"]
    click  ${dispatchtab}
    #validation of dsipatch events count in salesorder page
    click  ${itemviewbutton}
#    wait until element is visible  //span[text()="${itemData1}[0]"]/../../../../../../../../../td[2][text()="${itemData1}[2] piece"]
    click  (//button[@aria-label='Expand row'])[2]
    # Get all date elements in the table rows
    ${date_elements}=    Get Elements        //td[contains(@class, 'ant-table-cell-fix-left')]//span[contains(@style, 'white-space: nowrap')]/span[not(contains(text(), 'Fgitem1'))]
    ${date_count}=    Get Length    ${date_elements}
    FOR    ${element}    IN    @{date_elements}
    ${date_text}=    Get Text    ${element}
    Log    Date found: ${date_text}
    END
#    Should Be Equal  ${dispatch_count1}  ${date_count}






