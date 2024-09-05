*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Library  String
Library  Collections
Resource  ../../keywords.robot
Library  ../RandomEmailLibrary.py
Library   ../../customkeyword1capitalletter.py



*** Variables ***
${EMAIL_LENGTH}    8  # Length of the username part of the email
${EMAIL_DOMAIN}   example.com

*** Keywords ***


open site page
    click  ${mastersDropdown}
    sleep  1
    click  ${mastersConfiguration}

site should be added
    [Arguments]  ${siteName}
    click  //button[@id='site__filterBtn']
    press keys  //input[@id='name']  CTRL+A  BACKSPACE
    input  //input[@id='name']  ${siteName}
    wait until element is visible  //a[text() = "${siteName}"]  timeout=15s





edit sites
    [Arguments]  ${old_siteName}
    click  //a[text() = "${old_siteName}"]
    click  ${Edit}
    sleep  3
    Execute JavaScript  window.scrollTo(2500,0)
    sleep  3
    ${randomnewsiteName}=  Generate Random string of name
    press keys    ${siteName}  CTRL+A  BACKSPACE  ${randomnewsiteName}
    ${randomsiteaddress}=  Generate Random string of name
    press keys    ${siteAddress}  CTRL+A  BACKSPACE  ${randomsiteaddress}
    ${random_siteemail}=    Generate Random Email    ${EMAIL_LENGTH}    ${EMAIL_DOMAIN}
    # Example of using the random email in a test case
    press keys   ${siteEmail}  CTRL+A  BACKSPACE    ${random_siteemail}
    select option from dropdown using div  ${siteCountry}  Algeria
    select option from dropdown using div  ${siteState}  Adrar
    sleep  1
    select option from dropdown using div  ${siteCity}  Aoulef
    click  ${woInProFalse}
    sleep  2
    click  ${costingFalse}
    sleep  2
    click  ${mrnToIssueFalse}
    sleep  2
    click  ${bundleFalse}
    sleep  2
    click  ${rackTrue}
    sleep  2
    click  ${Submit}
    i should see text on page  Site edited
    open site page
    reload page
    sleep  5
    site should be added  ${randomnewsiteName}
    sleep  5
    wait until page contains element  //a[text() = "${randomnewsiteName}"]
    delete site  ${randomnewsiteName}

delete site
    [Arguments]  ${edited_siteName}
    click  //a[text() = "${edited_siteName}"]/../../../../../../../../../../td[5]/div/button[@id="site__Deactivate"]
    click  ${site_deactivate}
    i should see text on page  Site deactivated successfully

Generate Random string of name
    ${random_string}=  Generate Random String  7  [LOWER]
    ${random_customer_name}=  Capitalize First Letter  ${random_string}
    [Return]  ${random_customer_name}