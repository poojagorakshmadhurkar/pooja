*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Library   ../RandomLibrary.py
Library    String
Library  Browser








*** Keywords ***

open shifts page
    click  ${mastersDropdown}
    click  ${mastersShifts}
    sleep  1
    Reload

shifts should be added
    [Arguments]  ${shiftName}
    click  (//*[name()='svg'][@id='undefined_Label_search'])[1]
    Wait For Elements State     //input[@placeholder='Search Label']
    Click    //input[@placeholder='Search Label']
    Fill Text   //input[@placeholder='Search Label']  ${shiftName}
    click  (//*[name()='svg'][@id='undefined_Label_search'])[1]
    Wait For Elements State   //a[text() = "${shiftName}"]  timeout=15s


edit shift
    [Arguments]  ${shiftOldName}  ${shiftNewName}  ${shiftNewStartTime}  ${shiftNewEndTime}  ${shiftNewBreakTime}
    click  //a[text() = "${shiftOldName}"]
    click  ${shiftedit}
    Fill Text    ${shiftName}    ${shiftNewName}
#    Fill Text    ${shiftStartTime}    ${shiftNewStartTime}
#    Fill Text    ${shiftEndTime}    ${shiftNewEndTime}
#    Fill Text    ${shiftBreakTime}    ${shiftNewBreakTime}
#    press keys  ${shiftBreakTime}  RETURN
    click  ${Submit}
    i should see text on page  Shift edited
    open shifts page
    Reload
    shifts should be added  ${shiftNewName}


delete shift
    [Arguments]  ${shiftName}
    Wait For Elements State     //a[text() = "${shiftName}"]/../../../../../../../../../td[5]//button
    click  //a[text() = "${shiftName}"]/../../../../../../../../../td[5]//button
    click  ${deactivate_shift}
    i should see text on page  Shift deactivated successfully


Reactivated Shifts
    [Arguments]  ${shiftName}
    open shifts page
    Reload
    click  (//*[name()='svg'][@class='MuiSvgIcon-root MuiSvgIcon-fontSizeMedium ant-dropdown-trigger css-vubbuv'])[1]
    click  //div[contains(text(),'Deactivated shifts')]
    shifts should be added  ${shiftName}
    click   //a[text()="${shiftName}"]/../../../../../../../../../td[5]//button
    i should see text on page  Shift Reactivated Successfully
    click  ${back}
    Reload
    shifts should be added  ${shiftName}


Generate Random Customer Name
    ${random_string}=  Generate Random String  7  [LOWER]
    ${random_customer_name}=  Capitalize First Letter  ${random_string}
    RETURN  ${random_customer_name}
