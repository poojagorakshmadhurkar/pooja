*** Settings ***
#Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Library  String
Library  Collections
#Resource  ../../inventory/transactions/keywords.robot
#Resource  ../../variables.robot
Resource  ./variables.robot
Library  OperatingSystem
Library  customcsvkeyword.py
Library    Browser

*** Variables ***
@{customername}  Test01
@{itemData1}  Fgitem1  100

${file_path}  C:\\Users\\user\\PycharmProjects\\WebAutoamtion\\Suite\\orders\\Salesorder\\output.csv
${python_script}  C:\\Users\\user\\PycharmProjects\\WebAutoamtion\\Suite\\orders\\Salesorder\\sampleSocreationexcel.py
${so_number_path}  C:\\Users\\user\\PycharmProjects\\WebAutoamtion\\Suite\\orders\\Salesorder\\so_number.txt






*** Test Cases ***
Creation of SO
    Run Python Script  ${python_script}
    ${so_number}=  Get File  ${so_number_path}
    ${so_number}=  Strip String  ${so_number}
    login devsite
    select site  testingsiteautomation
    open order tracker page
    click  ${uploadCSVbuttonSO}
    click  ${uploadbuttonSO}
    Upload File By Selector       //input[@type='file']  ${file_path}
    Wait For Elements State      //button[text()="Submit File"]  visible  timeout=60s
    Click   //button[text()="Submit File"]
    i should see text on page  Upload Successful
    Reload
    search Sonumber in SoListpage for validation  ${so_number}
    Wait For Elements State      //a[text()="${so_number}"]  visible   timeout=60s


