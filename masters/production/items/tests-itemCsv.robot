*** Settings ***
Library  SeleniumLibrary  timeout=20
Library    python_utils.py
Library    OperatingSystem
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot



*** Test Cases ***
manual csv upload
    Set Selenium Speed    0s
    login
    # select site  Smart Factory
    open item page
    click  ${submitButtonIdCsv}
    click  ${itemGroupDropdownCsv}
    click  //li[text() = "Compounds"]
    #creating a csv file
    ${csv_content}=    create csv item
    Log To Console    ${csv_content}

    # Save the CSV content to a temporary file for uploading
    # ${temp_file}=    Set Variable    ${TEMPDIR}${/}data.csv
    # Create File    ${temp_file}    ${csv_content}

    ${temp_file}=    Set Variable    ${TEMPDIR}${/}data.csv
    Run    echo "${csv_content}" > ${temp_file}

    Log To Console     ${temp_file}
    # Choose File    id=item_upload_csv__upload_file_btn    file_path=file:///Users/dixitdhiman/Downloads/convertcsv.csv
    # Choose File    locator=${itemUploadCsv}    file_path=file:///Users/dixitdhiman/Downloads/convertcsv.csv
    Choose File    ${itemUploadCsv}    ${temp_file}
    # click  ${itemUploadCsv}
    sleep  5
    Close Browser