*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Library  String
Library  Collections
Resource  ../../keywords.robot
Library  ../RandomEmailLibrary.py
Library   ../../customkeyword1capitalletter.py
Library    Browser



*** Variables ***
${EMAIL_LENGTH}    8  # Length of the username part of the email
${EMAIL_DOMAIN}   example.com

*** Keywords ***


open site page
    click  ${mastersDropdown}
    sleep  1
    click  ${mastersConfiguration}
    sleep  1

site should be added
    [Arguments]  ${siteName}
    click  (//*[name()='svg'][@id='undefined_Name_search'])[1]
    Click      //input[@placeholder='Search Name']
    Fill Text      //input[@placeholder='Search Name']  ${siteName}
    click  (//*[name()='svg'][@id='undefined_Name_search'])[1]
    Wait For Elements State    //a[text() = "${siteName}"]  timeout=15s





edit sites
    [Arguments]  ${old_siteName}
    click  //a[text() = "${old_siteName}"]
    Reload
    click  ${siteEdit}
#    Evaluate JavaScript    window.scrollTo(2500, 0)
    ${randomnewsiteName}=  Generate Random string of name
    Clear Text     ${siteName}
    Type Text    ${siteName}   ${randomnewsiteName}
#    Invoice address
#    Shipment Address
    ${randomsiteaddress}=  Generate Random string of name
    ${random_siteemail}=    Generate Random Email    ${EMAIL_LENGTH}    ${EMAIL_DOMAIN}
    # Example of using the random email in a test case
    Clear Text    ${siteEmail}
    Type Text     ${siteEmail}   ${random_siteemail}
    click  ${woInProFalse}
    click  ${costingFalse}
    click  ${mrnToIssueFalse}
    click  ${bundleFalse}
    click  ${rackTrue}
    click  ${Submit}
    i should see text on page  Site edited
    open site page
    click  //h5[text()="sites"]
    site should be added  ${randomnewsiteName}
    Wait For Elements State      //a[text() = "${randomnewsiteName}"]
    delete site  ${randomnewsiteName}

delete site
    [Arguments]  ${edited_siteName}
    click  //a[text() = "${edited_siteName}"]/../../../../../../../../../td[6]//button
    click  ${site_deactivate}
    i should see text on page  Site deactivated successfully

Generate Random string of name
    ${random_string}=  Generate Random String  7  [LOWER]
    ${random_customer_name}=  Capitalize First Letter  ${random_string}
    RETURN  ${random_customer_name}

Invoice address
    click  (//span[contains(text(),'+ Add New')])[1]
    ${randomaddres}=  Generate Random string of name
    Clear Text    //input[@id='partner__address']
    Fill Text     //input[@id='partner__address']   ${randomaddres}
    click  //span[normalize-space()='Save Address']
    Wait For Elements State    xpath=//div[contains(text(),'Address added successfully')]    visible



Shipment address
    Wait For Elements State    //span[text()="Shipping Address"]/..//button
    click  //span[text()="Shipping Address"]/..//button
    ${randomaddres}=  Generate Random string of name
    Clear Text    //input[@id='partner__location']
    Fill Text     //input[@id='partner__location']   ${randomaddres}
    click  //span[normalize-space()='Save Address']
    Wait For Elements State    xpath=//div[contains(text(),'Address added successfully')]    visible


















