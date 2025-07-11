*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Resource  ../../keywords.robot
Library   ../RandomLibrary.py
Library    String
Library  Browser

*** Variables ***
@{shiftData}    #change data here
@{editShiftData}   05:00  07:00  15



*** Test Cases ***
shift creation
    login devsite
    select site  testingsiteautomation
    open shifts page
    click  ${New}
#    ${randomShiftName}=  generate random string  5-8  [LETTERS]
#    input  ${shiftName}  ${randomShiftName}
    ${shiftData}=    Generate Random Customer Name
    Fill Text    ${shiftName}  ${shiftData}
    browser.Press Keys   ${shiftName}    Tab
#    browser.Press Keys   ${shiftStartTime}    1 1 : 0 0    Tab    ${shiftEndTime}    2 3 : 0 0    Enter
#
#    Fill Text      ${shiftStartTime}    11:00
#    #input  ${shiftStartTime}  0800a
#    Fill Text    ${shiftEndTime}    23:00
#    Click      ${shiftEndTime}
#    #input  ${shiftEndTime}  0800p
#    press keys  ${shiftBreakTime}  CTRL+A  30  RETURN
    click  ${Submit}
    i should see text on page  Shift added
    click  ${back}
    Reload
    shifts should be added  ${shiftData}
    ${editshiftDataname}=  Generate Random Customer Name
    edit shift  ${shiftData}  ${editShiftDataname}  ${editShiftData}[0]  ${editShiftData}[1]  ${editShiftData}[2]
    delete shift  ${editShiftDataname}
#    Reactivated Shifts   ${editShiftDataname}





