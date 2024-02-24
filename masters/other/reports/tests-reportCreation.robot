*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Resource  ../../keywords.robot



#Varaibles are imported from keyword librabry in masters folder

*** Test Cases ***
creation of report page
    login
    select site  smart_factory
    open reports page
    click  ${addNewReports}
    input  ${reportName}  ${reportsData}[0]
    press keys  ${parameter}  ARROW_DOWN  ENTER  ARROW_DOWN  ENTER  ARROW_DOWN  ENTER  ESC
    click  ${frequency}
    sleep  1
    click  //div[text() = "Shift"]
    sleep  1
    press keys  ${shiftDropdown}  ARROW_DOWN  ENTER  ESC
    press keys  ${startTime}  CTRL+A  BACKSPACE  01:00  ENTER
    press keys  ${endTime}  CTRL+A  BACKSPACE  04:00  ENTER
    press keys  ${scheduledTime}  CTRL+A  BACKSPACE  02:00  ENTER
    input  ${report_email}  ${reportsData}[1]
    click  ${Submit}
    i should see text on page  Report added
    open reports page
    reload page
    sleep  3
    reports should be added  ${reportsData}[0]


reports edition
    edit reports  ${reportsData}[0]

delete reports
    delete reports  ${editReportsData}[0]
