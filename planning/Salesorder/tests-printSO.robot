*** Settings ***
Library  SeleniumLibrary
Library    CustomPythonKeywords.py    WITH NAME    CustomKeywords
Resource  ../../keywords.robot
Resource  ./keywords.robot
Library   OperatingSystem
Library    RPA.PDF
Library  String
Library  Collections
Resource  ../../inventory/transactions/keywords.robot
Resource  ../../variables.robot
Resource  ./variables.robot
Resource  ../../inventory/warehouses/keywords.robot
Library    pdfplumber
Library  BuiltIn
Library  PDF

*** Variables ***

@{customername}  Pooja30
@{itemData1}  FGITEM4  100
${xpath}  //span[contains(@class, 'ant-tree-title')]
${machine}  P2
${shift}  Morning Shift

${order_number}      ${EMPTY}
${expected_text}   FGITEM4
${DOWNLOAD_DIR}    C:/Users/user/Downloads   # Adjust this path based on your system
${file_name}       ${EMPTY}                  # Initialize with empty string
${file_path}       ${EMPTY}





*** Test Cases ***

So print
    Set Selenium Speed    0.1
    login devsite
    select site  testingsiteautomation
    ${order_number}=  Create SO  ${customername}  ${itemData1}
    sleep  1
    click  //a[text()="${order_number}"]/../../../../../../../../span
    Wait Until Page Contains Element  //div[text()="${order_number}"]    timeout=30s
    click  ${printsobutton}

    ${transformed_order}    Transform Order Number    ${order_number}
    Log    Transformed Order Number: ${transformed_order}

    BuiltIn.Set Suite Variable    ${file_name}    ${transformed_order}.pdf

    ${file_path}   Set File Name And Path
    OperatingSystem.File Should Exist    ${file_path}
    ${pdf_content}=    Read PDF    ${file_path}
    Log    ${pdf_content}












*** Keywords ***

Transform Order Number
    [Arguments]    ${order_number}
    [Documentation]    Transform order number by replacing '/' with '_'.
    ${transformed}    Replace String    ${order_number}    /    _
    [Return]    ${transformed}

Set File Name And Path
    [Documentation]    Sets ${file_path} by concatenating ${DOWNLOAD_DIR} and ${file_name}.
    ${file_path}    Set Variable    ${DOWNLOAD_DIR}/${file_name}
    [Return]    ${file_path}

Read PDF
    [Arguments]    ${file_path}
    [Documentation]    Reads the content of a PDF file located at ${file_path} using pdfplumber.
    ${pdf_content}=    Create List
    ${pdf}=    pdfplumber.open    ${file_path}
    FOR    ${page}    IN    @{pdf.pages}
        Append To List    ${pdf_content}    ${page.extract_text()}
    END
    [Return]    ${pdf_content}


