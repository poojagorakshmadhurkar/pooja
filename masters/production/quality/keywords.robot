*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Resource  ../../keywords.robot
Library    Browser

*** Variables ***
@{EditQualityData}  RM Group  Store  Low
@{qualityData}  Damage

*** Keywords ***
open quality page
    click  ${mastersDropdown}
    sleep  1
    Wait For Elements State      ${mastersQuality}
    click  ${mastersQuality}
    Reload

enters quality tags
    [Arguments]  ${tags}
    Wait For Elements State    //button[normalize-space()='Edit']    visible    timeout=10s
    Wait For Elements State    //button[normalize-space()='Edit']    enabled    timeout=10s
    Click    //button[normalize-space()='Edit']
    sleep  1
    Wait For Elements State    //button[normalize-space()='Select All']   visible    timeout=10s
    Click   //button[text()='Select All']
    Wait For Elements State    //div[text()=" Selected"]  timeout=10s
    Click  //button[text()="Save"]

quality should be added
    [Arguments]  ${qualityName}
#    click  //button[@id="quality__company"]
    click  (//*[name()='svg'][@id='undefined_Label_search'])[2]
    Click      //input[@placeholder='Search Label']
    input  //input[@placeholder='Search Label']   ${qualityName}
    browser.Press keys    //input[@placeholder='Search Label']    Enter

    Wait For Elements State      (//a[text() = "${qualityName}"])[2]

quality should be added in CTQ
    [Arguments]  ${qualityName}
#    click  //button[@id="quality__company"]
    click  //div[text()="All Critical to Quality "]
    click  (//*[name()='svg'][@id='undefined_Label_search'])[2]
    Click    //input[@placeholder='Search Label']
    Fill Text    //input[@placeholder='Search Label']   ${qualityName}
    browser.Press Keys    //input[@placeholder='Search Label']  Enter
    sleep  1
    Wait For Elements State    (//a[text()="${qualityName}"])[2]

quality edit
    [Arguments]  ${oldqualityName}
    click  (//a[text() = "${oldqualityName}"])[2]
    click  (//button[text() = "Edit"])[2]
    ${randomqualitydata}=  generate random string  5-8  [LETTERS]
    Fill Text    ${qualityName}    ${randomqualitydata}
#    click  //button[@title='Clear']//*[name()='svg']}
#    enters quality tags  ${EditQualityData}[1]
    select option from dropdown using div  ${Department}  ${EditQualityData}[1]
    select option from dropdown using div  ${Severity}  ${EditQualityData}[2]
    click  ${Submit}
    i should see text on page  Issue edited
    open quality page
    Reload
    click  ${allIssues}
    quality should be added  ${randomqualitydata}
    click  (//a[text()="${randomqualitydata}"]/../../../../../../../../../../tr)[4]//td[5]
    click  ${deactivate_quality}
    i should see text on page  Issue deactivated successfully

quality CTQ edit
    [Arguments]  ${oldqualityName}
    click  (//a[text() = "${oldqualityName}"])[2]
    click  (//button[text() = "Edit"])[2]
    ${randomlabeldata}=  generate random string  5-8  [LETTERS]
    Fill Text      ${label}   ${randomlabeldata}
#    click  //button[@title='Clear']//*[name()='svg']}
#    enters quality tags  ${EditQualityData}[1]
    select option from dropdown using span  ${rejectionreasondropdown}  ${qualityData}[0]
    click  ${ctqsubmit}
    i should see text on page  Critical to Quality edited
    open quality page
    Reload
    click  ${criticaltoquality}
    Quality Should Be Added In CTQ  ${randomlabeldata}
    click  (//a[text()="${randomlabeldata}"]/../../../../../../../../../td[5])[2]
#    click  (//*[name()='svg'][@class='MuiSvgIcon-root MuiSvgIcon-colorSecondary MuiSvgIcon-fontSizeMedium css-al619y'])[2]
    click  //button[@id='ctq__deactivate_btn']
    i should see text on page  Critical to Quality deactivated successfully