*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Library   ../RandomLibrary.py
Library    String







*** Keywords ***

open shifts page
    click  ${mastersDropdown}
    click  ${mastersShifts}

shifts should be added
    [Arguments]  ${shiftName}
    click  //button[@id="shifts__filterBtn"]
    wait until page contains element  //input[@id='label']  timeout=10s
    press keys  //input[@id='label']  CTRL+A  BACKSPACE
    sleep  3
    input  //input[@id='label']  ${shiftName}
    wait until element is visible  //a[text() = "${shiftName}"]  timeout=15s


edit shift
    [Arguments]  ${shiftOldName}  ${shiftNewName}  ${shiftNewStartTime}  ${shiftNewEndTime}  ${shiftNewBreakTime}
    click  //a[text() = "${shiftOldName}"]
    sleep  1
    click  ${edit}
    Press keys  ${shiftName}  CTRL+A  BACKSPACE  ${shiftNewName}
    press keys  ${shiftStartTime}  CTRL+A  BACKSPACE  ${shiftNewStartTime}
    press keys  ${shiftEndTime}  CTRL+A  BACKSPACE  ${shiftNewEndTime}
    press keys  ${shiftBreakTime}  CTRL+A  BACKSPACE   ${shiftNewBreakTime}
    sleep  1
    press keys  ${shiftBreakTime}  RETURN
    click  ${Submit}
    sleep  2
    i should see text on page  Shift edited
    sleep  2
    open shifts page
    reload page
    sleep  2
    shifts should be added  ${shiftNewName}


delete shift
    [Arguments]  ${shiftName}
    scroll element into view  //a[text() = "${shiftName}"]/../../../../../../../../../../td[4]/div/button[@id = "shifts__Deactivate"]
    click  //a[text() = "${shiftName}"]/../../../../../../../../../../td[4]/div/button[@id = "shifts__Deactivate"]
    sleep  2
    click  ${deactivate_shift}
    i should see text on page  Shift deactivated successfully


Reactivated Shifts
    [Arguments]  ${shiftName}
    open shifts page
    reload page
    sleep  3
    click  (//*[name()='svg'][@class='MuiSvgIcon-root MuiSvgIcon-fontSizeMedium ant-dropdown-trigger css-vubbuv'])[1]
    click  //div[contains(text(),'Deactivated shifts')]
    shifts should be added  ${shiftName}
    sleep  3
    click  //a[text()="${shiftName}"]/../../../../../../../../../../td[4]//button[@id="shifts__Reactivate"]
    i should see text on page  Shift Reactivated Successfully
    click  ${back}
    reload page
    sleep  2
    click  //button[@id="shifts__filterBtn"]
    sleep  2
    shifts should be added  ${shiftName}


Generate Random Customer Name
    ${random_string}=  Generate Random String  7  [LOWER]
    ${random_customer_name}=  Capitalize First Letter  ${random_string}
    [Return]  ${random_customer_name}
