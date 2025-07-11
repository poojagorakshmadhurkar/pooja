*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Resource  ../../keywords.robot
Library    ../customkeywordplanning.py
Library  Browser

*** Variables ***
${file_path}    C:/Users/user/Downloads/generated_file.csv


*** Test Cases ***
customer creation
    [Tags]  creation

    login devsite
#    select site  testingsiteautomation
    open customer page
    click  ${csvuploadbutton}
    ${result}=    Generate Random CSV    C:/path/to/your/file.csv  # Capture the dictionary result
    ${file_path}=    Get From Dictionary    ${result}    file_path  # Extract file path
    ${name}=    Get From Dictionary    ${result}    name  # Extract name
    Log    File path: ${file_path}  # Log the file path
    Log    Name from CSV: ${name}  # Log the name from the CSV
    click  ${uploadcsvbuttonsecond}
    Upload File By Selector    //input[@type='file']    ${file_path}
    click  ${submitcsvbutton}
    i should see text on page  Upload Successful
    Reload
    customer should be added  ${name}



