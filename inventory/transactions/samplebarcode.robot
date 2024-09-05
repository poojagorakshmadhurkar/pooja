*** Settings ***
Library  SeleniumLibrary
Resource  Suite/keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Resource  ../../keywords.robot
Resource  Suite/masters/production/items/keywords.robot
Resource  Suite/masters/production/items/variables.robot
Library  test_read_barcode.py
Library  Process
Library  OperatingSystem
Library  BuiltIn
Library  Dialogs
Library  RegexLibrary






*** Variables ***
${BARCODE}   FGitem100
${BARCODE_SVG}  (//*[name()='svg'][@id='frXGH'])[1]
${SCREENSHOT_DIR}   C:/Users/user/PycharmProjects/automation/Suite/inventory/transactions/Barcodescreenshot
${TIMESTAMP}        ${None}  # Placeholder for timestamp
${PYTHON_SCRIPT}    C:\\Users\\user\\PycharmProjects\\automation\\Suite\\inventory\\transactions\\test_read_barcode.py
${FILENAME}         C:\\Users\\user\\PycharmProjects\\automation\\Suite\\inventory\\transactions\\Barcodescreenshot\\FGitem100_2024-07-30_17-08-45.png
${filestout}  C:\\Users\\user\\PycharmProjects\\automation\\stdout.txt
@{itemData1}  50



*** Test Cases ***
open item page
    #itemcreation
    Set Selenium Speed    0.1
    login devsite
    select site  testingsiteautomation
    open item page
    click  ${newIcon}
    sleep  2
    ${randomItemCode}=  generate random string  5-8  [LETTERS]
    input  ${itemCode}  ${randomItemCode}
    ${randomItemName}=  generate random string  5-8  [LETTERS]
    input  ${itemName}  ${randomItemName}
    sleep  1
    select option from dropdown using span  ${itemgroup}  AI_AI_A
    sleep  1
#    select option from dropdown using span  ${itemgroup}  Compounds
    click  ${Submit}
    i should see text on page  Item added
    click  ${backButton}
    reload page
    sleep  2
    item should be added  ${randomItemName}
    sleep  3
    edit item inventory   ${randomItemCode}
    click  ${barcodebutton}
    sleep  1
    #changing screen size
    Set Window Size    1920    1080
    Set Test Variable    ${BARCODE_SVG}    (//*[name()='svg'][@id='${randomItemCode}'])[1]
    Wait Until Element Is Visible    ${BARCODE_SVG}    timeout=10s
    # Scroll the element into view using JavaScript
    Execute JavaScript    document.evaluate("${BARCODE_SVG}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView();
    # Take a screenshot and store in file
    ${TIMESTAMP}    Get Time    %Y-%m-%d_%H-%M-%S
    ${FILENAME}     Set Variable    ${SCREENSHOT_DIR}/${BARCODE}_${TIMESTAMP.replace(':', '-')}.png
    Capture Page Screenshot    ${FILENAME}
    Log    Screenshot saved at ${FILENAME}
    # Run the Python script with the screenshot path as an argument read data from Bracode through ocr
    ${result}       Run Process    python    ${PYTHON_SCRIPT}    ${FILENAME}    shell=True    stdout=stdout.txt    stderr=stderr.txt
    ${output}       Get File    ${filestout}  encoding=latin-1
    ${error}        Get File    stderr.txt
    Log    ${output}
    Log    ${error}
    #Extract OCR Results and Store in Variables
    ${file_contents}=    Get File    ${filestout}  encoding=latin-1
    Log    ${file_contents}
    # Split the contents by newlines
    @{lines}=    Split String    ${file_contents}    \n
    ${lines_str}=    Catenate    SEPARATOR=\n    @{lines}
    Log    ${lines_str}
    # Extract the lines that contain the OCR results
    ${ocr_result_1}=    Set Variable    ${lines[3]}
    ${ocr_result_2}=    Set Variable    ${lines[4]}
    Log    ${ocr_result_1}
    Log    ${ocr_result_2}
    #outward request
    sleep  2
    open trasactions page
    click  ${outwardTab}
    click  ${newOutwardNote}
    select outward to  Customer
    select outward customer to  Testcsvcustomer
    date entry
    set ith item in outward  0  ${ocr_result_1}  ${itemData1}[0]
    sleep  1
    wait until page contains  ${ocr_result_1}

