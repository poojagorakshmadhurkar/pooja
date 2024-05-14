*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Resource  ../../keywords.robot

#*** Variables ***
#@{shiftData}  shift32  #change data here
#@{editShiftData}  edited_shift33  05:00  07:00  15
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
    input  ${shiftName}  ${shiftData}[0]
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
    shifts should be added  ${shiftData}[0]
#    sleep  2
#    ${Save_RandomValue}=  Get text  //a[text() = "${randomShiftName}"]

shift edition
#    ${Save_RandomValue}=  Get text  //a[text() = "${randomShiftName}"]
#       change 1st name as above,2nd name put new name
    edit shift  ${shiftData}[0]  ${editShiftData}[0]  ${editShiftData}[1]  ${editShiftData}[2]  ${editShiftData}[3]


delete shift
    delete shift  ${editShiftData}[0]


Reactivated Shifts
    Reactivated Shifts   ${editShiftData}[0]





