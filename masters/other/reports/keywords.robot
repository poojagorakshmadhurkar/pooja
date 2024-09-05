*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Library   ../../customkeyword1capitalletter.py
Library  String
Library  Collections
Resource  ../../keywords.robot
Library  ../../RandomEmailLibrary.py


*** Variables ***
${EMAIL_LENGTH}    8  # Length of the username part of the email
${EMAIL_DOMAIN}   example.com

*** Keywords ***
open reports page
    click  ${mastersDropdown}
    sleep  1
    click  ${mastersReports}

reports should be added
    [Arguments]  ${reportName}
    click  ${filterButton}
    press keys  ${reportTitle}  CTRL+A  BACKSPACE
    input  ${reportTitle}  ${reportName}
    sleep  5
    wait until page contains element  //a[text() = "${reportName}"]  timeout=20s

edit reports
    [Arguments]  ${Name}
    click  //a[text() = "${Name}"]
    click  ${edit}
    ${randomnewreportName}=  Generate Random reports Name
    press keys    ${reportName}  CTRL+A  BACKSPACE  ${randomnewreportName}
#    press keys  ${reportName}  CTRL+A  BACKSPACE  ${editReportsData}[0]
    press keys  ${parameter}  BACKSPACE  BACKSPACE  BACKSPACE  ARROW_DOWN  ENTER  ESC
    click  ${frequency}
    click  //div[text() = "Shift"]
    press keys  ${scheduledTime}  CTRL+A  BACKSPACE  04:00  ENTER
#    press keys  ${report_email}  CTRL+A  BACKSPACE  ${editReportsData}[2]
    ${random_reportmail}=    Generate Random Email    ${EMAIL_LENGTH}    ${EMAIL_DOMAIN}
    press keys    ${report_email}  CTRL+A  BACKSPACE  ${random_reportmail}
    click  ${Submit}
    i should see text on page  Report edited
    open reports page
    reload page
    sleep  3
    reports should be added  ${randomnewreportName}
    click  //a[text() = "${randomnewreportName}"]/../../../../../../../../../../td[7]//button[@id="[object Object]__Deactivate"]
    click  ${deactivateReports}
    i should see text on page  Report deactivated successfully


Generate Random reports Name
    ${random_string}=  Generate Random String  7  [LOWER]
    ${random_customer_name}=  Capitalize First Letter  ${random_string}
    [Return]  ${random_customer_name}