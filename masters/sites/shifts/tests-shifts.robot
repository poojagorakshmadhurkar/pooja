*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Resource  ../../keywords.robot
Library   ../RandomLibrary.py
Library    String

*** Variables ***
@{shiftData}    #change data here
@{editShiftData}   05:00  07:00  15



*** Test Cases ***
shift creation
    Set Selenium Speed    0.1
    login
    select site  smart_factory
    open shifts page
    click  ${New}
    sleep  3
#    ${randomShiftName}=  generate random string  5-8  [LETTERS]
#    input  ${shiftName}  ${randomShiftName}
    ${shiftData}=    Generate Random Customer Name
    input  ${shiftName}  ${shiftData}
    press keys  ${shiftStartTime}  CTRL+A  DELETE  11:00
    #input  ${shiftStartTime}  0800a
    press keys  ${shiftEndTime}  CTRL+A  DELETE  23:00
    press keys  ${shiftEndTime}  ENTER
    #input  ${shiftEndTime}  0800p
    press keys  ${shiftBreakTime}  CTRL+A  30  RETURN
    click  ${Submit}
    i should see text on page  Shift added
    click  ${back}
    reload page
    sleep  3
    shifts should be added  ${shiftData}
    ${editshiftDataname}=  Generate Random Customer Name
    edit shift  ${shiftData}  ${editShiftDataname}  ${editShiftData}[0]  ${editShiftData}[1]  ${editShiftData}[2]
    delete shift  ${editShiftDataname}
    Reactivated Shifts   ${editShiftDataname}





