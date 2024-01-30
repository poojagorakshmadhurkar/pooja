*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot



*** Variables ***
@{SiteData1}  poojafactory_28  Test28_addresss  test28@gmail.com   gstnumber3  #change name only
@{newSiteData}  poojafactory_29  edited address  Edited29@gmail.com    #change name    onlyr

*** Test Cases ***
site creation
    login
    select site  smart_factory
    open site page
    click  ${newButton}
    input  ${siteName}  ${SiteData1}[0]
    input  ${siteAddress}  ${SiteData1}[1]
    input  ${siteEmail}  ${SiteData1}[2]
    select option from dropdown using span  ${siteCountry}  Albania
    select option from dropdown using span  ${siteState}  Berat District
    select option from dropdown using span  ${siteCity}  Banaj

    input  ${Gstnname}  ${SiteData1}[3]
    sleep  2
    click  ${woInProTrue}
    sleep  2
    click  ${costingTrue}
    sleep  2
    click  ${mrnToIssueTrue}
    sleep  2
    click  ${bundleTrue}
    sleep  2
    click  ${rackFalse}
    sleep  2
    click  ${Submit}
    sleep  2
    i should see text on page  Site added
    click  ${back}
    reload page
    sleep  3
    site should be added  ${SiteData1}[0]


editing site configuration
    edit sites  ${SiteData1}[0]  ${newSiteData}[0]  ${newSiteData}[1]  ${newSiteData}[2]

deleting edited site
    delete site  ${newSiteData}[0]




