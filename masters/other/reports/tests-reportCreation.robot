*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Library  ../../RandomEmailLibrary.py
Library   ../../customkeyword1capitalletter.py


*** Variables ***
${EMAIL_LENGTH}    8  # Length of the username part of the email
${EMAIL_DOMAIN}   example.com
#Varaibles are imported from keyword librabry in masters folder

*** Test Cases ***
creation of report page
    Set Selenium Speed    0.1
    login
    select site  smart_factory
    open reports page
    click  ${addNewReports}
    ${name}=  Generate Random reports Name
    input  ${reportName}  ${name}
    press keys  ${parameter}  ARROW_DOWN  ENTER  ARROW_DOWN  ENTER  ARROW_DOWN  ENTER  ESC
    click  ${frequency}
    sleep  1
    click  //div[text() = "Shift"]
    sleep  1
    press keys  ${shiftDropdown}  ARROW_DOWN  ENTER  ESC
    press keys  ${startTime}  CTRL+A  BACKSPACE  01:00  ENTER
    press keys  ${endTime}  CTRL+A  BACKSPACE  04:00  ENTER
    press keys  ${scheduledTime}  CTRL+A  BACKSPACE  02:00  ENTER
    ${random_reportemail}=    Generate Random Email    ${EMAIL_LENGTH}    ${EMAIL_DOMAIN}
    Input Text    ${report_email}    ${random_reportemail}
    click  ${Submit}
    i should see text on page  Report added
    open reports page
    reload page
    sleep  3
    reports should be added  ${name}
    edit reports  ${name}

