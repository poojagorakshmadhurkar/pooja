*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Library  String
Library  Collections
Resource  ../../inventory/transactions/keywords.robot
Resource  ../../variables.robot
Resource  ./variables.robot
Library  OperatingSystem
Library  customcsvkeyword.py

*** Variables ***
@{customername}  Test01
@{itemData1}  Fgitem1  100
*** Variables ***
${file_path}  C:\\Users\\user\\PycharmProjects\\automation\\Suite\\planning\\Salesorder\\output.csv
${python_script}  Suite/planning/Salesorder/sampleSocreationexcel.py
${so_number_path}  C:\\Users\\user\\PycharmProjects\\automation\\Suite\\planning\\Salesorder\\so_number.txt






*** Test Cases ***
Creation of SO
    Run Python Script  ${python_script}
    ${so_number}=  Get File  ${so_number_path}
    ${so_number}=  Strip String  ${so_number}
    sleep  3
    Set Selenium Speed    0.1
    login devsite
    select site  testingsiteautomation
    open order tracker page
    sleep  2
    click  ${uploadCSVbuttonSO}
    sleep   3
    click  ${uploadbuttonSO}
    Choose File   //input[@type='file']  ${file_path}
    sleep  5
    Wait Until Element Is Visible  //button[text()="Submit File"]
    Click Button  //button[text()="Submit File"]
    i should see text on page  Upload Successful
    sleep  2
    search Sonumber in SoListpage for validation  ${so_number}
    wait until page contains element  //a[text()="${so_number}"]


