*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot

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
    wait until page contains element  //a[text() = "${reportName}"]  timeout=10s

edit reports
    [Arguments]  ${Name}
    click  //a[text() = "${Name}"]
    click  ${edit}
    press keys  ${reportName}  CTRL+A  BACKSPACE  ${editReportsData}[0]
    press keys  ${parameter}  BACKSPACE  BACKSPACE  BACKSPACE  ARROW_DOWN  ENTER  ESC
    click  ${frequency}
    click  //div[text() = "${editReportsData}[1]"]
    press keys  ${scheduledTime}  CTRL+A  BACKSPACE  04:00  ENTER
    press keys  ${report_email}  CTRL+A  BACKSPACE  ${editReportsData}[2]
    click  ${Submit}
    i should see text on page  Report edited
    open reports page
    reload page
    sleep  3
    reports should be added  ${editReportsData}[0]

delete reports
    [Arguments]  ${editedReportName}
    click  //a[text() = "${editedReportName}"]/../../../../../../../../../../td[6]/div/button[2]
    click  ${deactivateReports}
    i should see text on page  Report deactivated successfully


