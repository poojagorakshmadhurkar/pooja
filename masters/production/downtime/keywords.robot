*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Resource  ../../keywords.robot
Library    Browser

*** Variables ***
@{EditDowntimeData}  Powercut34  Admin  High  Material  Electronic    #Change first name

*** Keywords ***
open downtime page
    click  ${mastersDropdown}
    Reload
    Wait For Elements State     ${mastersDowntime}
    click  ${mastersDowntime}

downtime should be added
    [Arguments]  ${downtimeName}
    click  (//*[name()='svg'][@id='undefined_Label_search'])[2]
    click  //input[@placeholder='Search Label']
    input  //input[@placeholder='Search Label']   ${downtimeName}
    browser.press Keys   //input[@placeholder='Search Label']   Enter
    Wait For Elements State      (//a[text() = "${downtimeName}"])[2]


edit downtime
    [Arguments]  ${oldDowntimeName}
    click  (//a[text() = "${oldDowntimeName}"])[2]
    click  (//button[text() = "Edit"])[2]
    Click    ${downtimeName}
    ${randomnewdowntime}=  generate random string  5-8  [LETTERS]
    input  ${downtimeName}  ${randomnewdowntime}
    #select option from dropdown  ${downtimeTags}  ${newDowntimeTags}
    select option from dropdown using div  ${downtimeDepartment}  ${EditDowntimeData}[1]
    select option from dropdown using div  ${downtimeSeverity}  ${EditDowntimeData}[2]
    select option from dropdown using div  ${downtimeBlame}  ${EditDowntimeData}[3]
    select option from dropdown using div  ${downtimeNature}  ${EditDowntimeData}[4]
    click  ${Submit}
    i should see text on page  Issue edited
    open downtime page
    Reload
    click  ${allIssues}
    downtime should be added  ${randomnewdowntime}
    click  (//a[text()="${randomnewdowntime}"]/../../../../../../../../../../tr)[4]//td[7]
    Click  ${deactivate_button}
    i should see text on page  Issue deactivated successfully


enters downtime tags
    [Arguments]  ${tags}
    click  //button[text() = "Edit"]
    input  (//input[@type="text"])[2]  ${tags}
    click  //span[@class="ant-checkbox"]
    click  //button[text()="Save"]