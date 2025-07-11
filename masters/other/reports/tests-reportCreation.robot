*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Library  ../../RandomEmailLibrary.py
Library   ../../customkeyword1capitalletter.py
Library  Browser


*** Variables ***
${EMAIL_LENGTH}    8  # Length of the username part of the email
${EMAIL_DOMAIN}   example.com
#Varaibles are imported from keyword librabry in masters folder

*** Test Cases ***
creation of report page
    login devsite
#    select site  testingsiteautomation
    open reports page
    click  ${addNewReports}
    Wait For Elements State    //span[text()="Add New Report"]
    ${name}=  Generate Random reports Name
    Fill Text   ${reportName}  ${name}
    Click  //input[@id="report__Periodic" and @type="radio"]
    select option from dropdown using div  ${parameter}  DPR
    select option From dropdown using div  ${frequency}  Shift
    click  (//span[normalize-space()='Frequency'])[1]
    select option From dropdown using div   ${shiftDropdown}  Morning Shift
#    select option from dropdown by inputting  ${startTime}    09:00
#    select option From dropdown using div  ${endTime}   04:00
#    select option From dropdown using div  ${scheduledTime}    02:00
    ${random_reportemail}=    Generate Random Email    ${EMAIL_LENGTH}    ${EMAIL_DOMAIN}
    Fill Text     ${report_email}    ${random_reportemail}
    click  ${Submit}
    i should see text on page  Report added
    open reports page
    Reload
    reports should be added  ${name}
    edit reports  ${name}

