*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot

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
    [Arguments]  ${old_siteName}  ${new_site_name}  ${new_site_address}  ${new_site_email}
    click  //a[text() = "${old_siteName}"]
    click  ${Edit}
    sleep  3
    Execute JavaScript  window.scrollTo(2500,0)
    sleep  3
    press keys  ${siteName}  CTRL+A  BACKSPACE  ${new_site_name}
    press keys  ${siteAddress}  CTRL+A  BACKSPACE  ${new_site_address}
    press keys  ${siteEmail}  CTRL+A  BACKSPACE  ${new_site_email}
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
    site should be added  ${new_site_name}
    sleep  5
    wait until page contains element  //a[text() = "${new_site_name}"]

delete site
    [Arguments]  ${edited_siteName}
    click  //a[text() = "${edited_siteName}"]/../../../../../../../../../../td[5]/div/button[@id="site__Deactivate"]
    click  ${site_deactivate}
    i should see text on page  Site deactivated successfully