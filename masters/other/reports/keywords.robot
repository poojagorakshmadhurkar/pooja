*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Library   ../../customkeyword1capitalletter.py
Library  String
Library  Collections
Resource  ../../keywords.robot
Library  ../../RandomEmailLibrary.py
Library  Browser


*** Variables ***
${EMAIL_LENGTH}    8  # Length of the username part of the email
${EMAIL_DOMAIN}   example.com

*** Keywords ***
open reports page
    click  ${mastersDropdown}
    sleep  1
    click  ${mastersReports}
    sleep  1
    click  //a[@id='reports']


reports should be added
    [Arguments]  ${reportName}
    click  ${filterButton}
    click  ${reportTitle}
    Fill Text   ${reportTitle}  ${reportName}
    click  ${reportTitle}
    sleep  2
    Wait For Elements State     //a[text() = "${reportName}"]  timeout=20s

edit reports
    [Arguments]  ${Name}
    click  //a[text() = "${Name}"]
    click  //button[@id='__edit']
    ${randomnewreportName}=  Generate Random reports Name
    clear Text   ${reportName}
    Type Text    ${reportName}  ${randomnewreportName}
    select option from dropdown using div  ${parameter}  DPR
    select option From dropdown using div  ${frequency}  Shift
#
#    press keys  ${scheduledTime}  CTRL+A  BACKSPACE  04:00  ENTER
#    press keys  ${report_email}  CTRL+A  BACKSPACE  ${editReportsData}[2]
    ${random_reportmail}=    Generate Random Email    ${EMAIL_LENGTH}    ${EMAIL_DOMAIN}
    Fill Text    ${report_email}    ${random_reportmail}
    click  ${Submit}
    i should see text on page  Report edited
    open reports page
    Reload
    sleep  3
    reports should be added  ${randomnewreportName}
    click  //a[text() = "${randomnewreportName}"]/../../../../../../../../../td[7]//*[name()='svg'][@class='MuiSvgIcon-root MuiSvgIcon-colorSecondary MuiSvgIcon-fontSizeMedium css-al619y']
    click  ${deactivateReports}
    i should see text on page  Report deactivated successfully


Generate Random reports Name
    ${random_string}=  Generate Random String  7  [LOWER]
    ${random_customer_name}=  Capitalize First Letter  ${random_string}
    RETURN  ${random_customer_name}