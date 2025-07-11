
*** Settings ***

Resource  ../../variables.robot
Resource    ../../masters/planning/vendors/keywords.robot
Resource  ../../keywords.robot
Library  OperatingSystem
Resource    ../../masters/planning/vendors/variables.robot
Resource  keyword.robot
Library  RequestsLibrary
Library  Process  # Added for running Python script
Library  Browser



*** Test Cases ***
vendorCreation
    login devsite
#    select site  testingsiteautomation
    open vendor page
    #wait until page contains  NEW  15
    ${VendorData1}=  Generate Random Customer Name
    sleep  2
    click  ${addNewVendor}
    input  ${vendorName}  ${VendorData1}
#    select option from dropdown by inputting  ${typeOfPartner}  Vendor
    ${randomCustomerEmail}=  generate random string  5-10  [LETTERS]
    input  ${vendorEmail}  ${randomCustomerEmail}
#    select option from dropdown using span  ${customerSM}  Smart Admin
    ${randomCustomerAddress}=  generate random string  5-15  [LETTERS]
    ${randomGSTN}=  generate random string  10-15  [NUMBERS]
    input  ${vendorGSTN}  ${randomGSTN}
    click  ${Submit}
    i should see text on page  Partner added
    click  ${newRequest}
    click    (//button[@aria-label='back-button']//*[name()='svg'])[2]
    Reload
    vendor should be added  ${VendorData1}
    ${result} =  Run Process  python  C:\\Users\\user\\PycharmProjects\\automation\\Suite\\IntegrationCases\\Zohointegration\\Check _Vendor _in_ Zoho _Inventory.py  vendor  ${VendorData1}  shell=True  stdout=stdout.txt  stderr=stderr.txt

    # Log the output
    ${output} =  Set Variable  ${result.stdout}
    Log  ${output}

    # Also log the contents of stdout.txt to check API response
    ${response} =  Get File  stdout.txt
    Log  ${response}

    # Validate if the vendor exists
    Should Be Equal As Integers    ${result.rc}    ${0}    "❌ Vendor was not found in Zoho!"
    browser.Close Browser

##Zoho login and verify Vendor is created
#    Login To Zoho
#    sleep  2
#    click  (//button[normalize-space()='Purchases'])[1]
#    click  (//a[normalize-space()='Vendors'])[1]
#    verify it should be added in Zoho  ${VendorData1}