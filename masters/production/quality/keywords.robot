*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Resource  ../../keywords.robot

*** Variables ***
@{EditQualityData}  RM Group  Store  Low

*** Keywords ***
open quality page
    click  ${mastersDropdown}
    click  ${mastersQuality}

enters quality tags
    [Arguments]  ${tags}
    input  ${qualityTags}  ${tags}
#    Wait Until Element Is Visible  ${tags}  20
    press keys  ${qualityTags}  ARROW_DOWN  RETURN
    Press Keys  ${qualityTags}  ESCAPE

quality should be added
    [Arguments]  ${qualityName}
    reload page
    click  //button[@id="quality__company"]
    click  //button[@id='quality__filterBtn']//*[name()='svg']
    sleep  2
    press keys  //input[@id='label']  CTRL+A  BACKSPACE
    sleep  2
    input  //input[@id='label']   ${qualityName}
    wait until page contains element  //a[text() = "${qualityName}"]

quality edit
    [Arguments]  ${oldqualityName}
    click  //a[text() = "${oldqualityName}"]
    click  ${Edit}
    sleep  1
    ${randomqualitydata}=  generate random string  5-8  [LETTERS]
    Press keys  ${qualityName}  CTRL+A  BACKSPACE  ${randomqualitydata}
#    click  //button[@title='Clear']//*[name()='svg']}
#    enters quality tags  ${EditQualityData}[1]
    select option from dropdown using list  ${Department}  ${EditQualityData}[1]
    select option from dropdown using list  ${Severity}  ${EditQualityData}[2]
    click  ${Submit}
    i should see text on page  Issue edited
    open quality page
    reload page
    sleep  3
    click  ${allIssues}
    quality should be added  ${randomqualitydata}
    click  //a[text() = "${randomqualitydata}"]/../../../../../../../../../../td[5]/div/button[@id = "quality__Deactivate"]
    click  ${deactivate_quality}
    i should see text on page  Issue deactivated successfully
