*** Settings ***
Library  SeleniumLibrary  timeout=20
Library    python_utils.py
Library    OperatingSystem
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
# Library     OperatingSystem
# Library     Selenium


*** Test Cases ***
manual csv upload
    Set Selenium Speed    0s
    login
    # select site  Smart Factory
    open item page
    Wait Until Element Is Visible  //button[@id="item__uploadCsvBtn"]  20s
    click  //button[@id = "item__uploadCsvBtn"]
    click  ${selectItemGroup}
    scroll element into view  (//span)[1]
    click  //div[@id = "rc_select_1_list"]/../div[2]/div/div/div/div[1]
    #creating a csv file
    ${csv_content}=    create csv item
    Log To Console    ${csv_content}

     # Save the CSV content to a temporary file for uploading
    ${temp_file}=    Set Variable    ${TEMPDIR}${/}data.csv
    Create File    ${temp_file}    ${csv_content}
    Log    ${temp_file}
    click  (//button[text() = "upload file"])[3]
    input   xyz  ${temp_file}
#    Choose File    ${itemUploadCsv}    ${temp_file}
#    # click  ${itemUploadCsv}
#    sleep  5
    click  //button[text() = "Submit File"]
    Close Browser