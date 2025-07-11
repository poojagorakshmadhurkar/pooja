*** Settings ***
Library    Browser
Library    OperatingSystem
Library    String
Library    Collections
Library    pdfplumber
Library    Path
Library    Process
Library    RequestsLibrary
Library    AutoItLibrary
Library    C:/Users/user/PycharmProjects/WebAutoamtion/Suite/orders/Salesorder/Custom_Python_Keywords.py


Resource   ../../keywords.robot
Resource   ./keywords.robot

*** Variables ***
${email}               pooja_dev@testing.com
${password}            4652049559
@{customername}        Test01
@{itemData1}           Fgitem1  100
${xpath}               //span[contains(@class, 'ant-tree-title')]
${machine}             P2
${shift}               Morning Shift
${OUTPUT_DIR}          ${EXECDIR}/downloads
${download_dir}        C:/Users/user/Downloads
${file_name}           ${EMPTY}
${file_path}           ${EMPTY}
${urlaws}              https://dev.manuf.app/
${download_path}       downloaded_sales_order.pdf
${python_script}       C:/Users/user/PycharmProjects/WebAutoamtion/Suite/orders/Salesorder/Custom_Python_Keywords.py
${python_executable}   C:/Users/user/PycharmProjects/WebAutoamtion/.venv2/Scripts/python.exe
${PRINT_WINDOW}        Print
${PRINT_BUTTON_IMAGE}  C:/Users/user/PycharmProjects/WebAutoamtion/Suite/orders/Salesorder/images/print_button.png
${PRINT_BUTTON_CTRL}   [CLASS:Intermediate D3D Window; INSTANCE:1]
${expected_text}       Fgitem1
${order_number}        ${EMPTY}








*** Test Cases ***
So print
    Create Directory    ${OUTPUT_DIR}/downloads
    New Browser    chromium    headless=false  channel=chrome
    New Context    acceptDownloads=true
    New Page    ${urlaws}
    Set Viewport Size    1450    750
    Fill Text  //input[@name = "email"]   pooja_dev@testing.com
    Fill Text  //input[@name = "password"]    4652049559
    Click  ${signIn}
    Wait For Elements State  ${signIn}  hidden  timeout=10s
    ${order_number}=    Create SO    ${customername}    ${itemData1}
    Browser.Click    (//a[text()="${order_number}"]/../../../../../../../../span)[1]
    Wait For Elements State    //div[text()="${order_number}"]    visible    timeout=30s
    Browser.Click    (//*[name()='svg'][@id='so_details_menu'])[1]
    Scroll To    //a[@download="${order_number}.pdf"]//div[text()="Print SO"]
    Sleep    3
    ${href}=    Get Property    //a[@download="${order_number}.pdf"]    href
    ${download_info}=    Download    ${href}    saveAs=${OUTPUT_DIR}/downloads/${order_number}.pdf
    File Should Exist    ${download_info.saveAs}
    ${text}=    get_text_from_pdf    ${download_info.saveAs}
    Should Contain    ${text}    ${expected_text}




















