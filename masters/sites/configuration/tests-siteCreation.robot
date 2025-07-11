*** Settings ***
#Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Resource  ../../keywords.robot
Library  String
Library  Collections
Resource  ../../keywords.robot
Library  ../RandomEmailLibrary.py
Library    Browser



*** Variables ***
${EMAIL_LENGTH}    8  # Length of the username part of the email
${EMAIL_DOMAIN}   example.com
#@{SiteData1}  poojafactory_28  Test28_addresss  test28@gmail.com   gstnumber3  #change name only
#@{newSiteData}  poojafactory_29  edited address  Edited29@gmail.com    #change name    onlyr

*** Test Cases ***
site creation
    login devsite
    select site  testingsiteautomation
    open site page
    click  ${newButton}
    ${randomsiteName}=  Generate Random string of name
    Fill Text      ${siteName}  ${randomsiteName}
#    ${randomsiteaddress}=  Generate Random string of name
#    input  ${siteAddress}  ${randomsiteaddress}
    ${random_siteemail}=    Generate Random Email    ${EMAIL_LENGTH}    ${EMAIL_DOMAIN}
    # Example of using the random email in a test case
    Fill Text     ${siteEmail}    ${random_siteemail}
#    select option from dropdown using div  ${siteCountry}  Afghanistan
#    select option from dropdown using div  ${siteState}  Badakhshan
#    select option from dropdown using div  ${siteCity}  Ashkāsham
    Invoice address
    Sleep   1
    Shipment address
    Fill Text      ${Gstnname}  gstnumber
    click  ${woInProTrue}
    click  ${costingTrue}
    click  ${mrnToIssueTrue}
    click  ${bundleTrue}
    click  ${rackFalse}
    click  ${Submit}
    i should see text on page  Site added
    click  ${back}
#    reload page
    site should be added  ${randomsiteName}

    edit sites  ${randomsiteName}

#deleting edited site
#    delete site  ${newSiteData}[0]




