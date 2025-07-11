*** Settings ***
#Library  SeleniumLibrary
Library  String
Library  Collections
Resource  ../../keywords.robot
#Resource  ../variables.robot
Library  DateTime
#Resource  ../orders/salesorder/variables.robot
#Resource  ../orders/salesorder/keywords.robot
Resource  keyword.robot
Resource  variable.robot
Library    BuiltIn
Library  CSVLibrary
Library    custom_keyword.py
Library    Browser





*** Variables ***

${DATE_FORMAT}    %dth %b %y
${TABLE_XPATH}    //table[@style="min-width: 100%; table-layout: fixed;"]
${DOWNLOAD_DIR}    C:/Users/user/Downloads
@{customername}  Test01
@{itemData1}  FG-item2  1000  50
#${xpath}  //span[contains(@class, 'ant-tree-title')]
@{machine}    Parent machine1
${shift}  Morning Shift


#Keep these thing in keep there shoould be workorder then only load chart will get download

*** Variables ***
${ORDINAL_SCRIPT}=    lambda d: f"{d}{'th' if 11<=d%100<=13 else {1:'st',2:'nd',3:'rd'}.get(d%10, 'th')}"



*** Test Cases ***

Load chart download
    [Tags]    setup_workorder
    Create Directory    ${OUTPUT_DIR}/downloads
    New Browser    chromium    headless=false  channel=chrome
    New Context    acceptDownloads=true
    New Page    ${urlaws}
    Set Viewport Size    1450    750
    Fill Text  //input[@name = "email"]   pooja_dev@testing.com
    Fill Text  //input[@name = "password"]    4652049559
    Click  ${signIn}
    Wait For Elements State  ${signIn}  hidden  timeout=10s
    select site  testingautomationsite2
    Workorder creation   ${itemData1}  ${customername}  ${machine}
    sleep  2
    Planning and scheduling
    sleep  1
    ${day_str}=    Get Current Date    result_format=%d
    ${day}=        Evaluate    str(int("${day_str}"))

    ${today}=      Evaluate    f"{${day}}{'th' if 11<=${day}%100<=13 else {1:'st',2:'nd',3:'rd'}.get(${day}%10, 'th')}"
    Log            ${today}

    ${xpath}=      Set Variable    //div[contains(text(), '${today}')]
    Click          ${xpath}
    click  ${loadchart}
    ${work_order_elements}=    Get Elements        ${TABLE_XPATH}//td[@class="ant-table-cell ant-table-cell-fix-left"]
    # Step 3: Extract text from each work order cell
    ${work_orders}=    Create List
    FOR    ${element}    IN    @{work_order_elements}
        ${text}=    Get Text    ${element}
        Append To List    ${work_orders}    ${text}
    END
    # Step 4: Log the extracted work orders
    Log    Extracted Work Orders: ${work_orders}
    #click on download button workorder
    Scroll To Element         ${wokorderloaddownloadbutton}
    ${promise}=    Promise To Wait For Download
    Click    ${wokorderloaddownloadbutton}
    sleep  2
