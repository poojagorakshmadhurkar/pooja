*** Settings ***
#Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Library  String
Library  Collections
#Resource  ../../inventory/transactions/keywords.robot
Resource  ../../variables.robot
Resource  ./variables.robot
Library  Browser

*** Variables ***
@{customername}  Test01
@{itemData1}  Fgitem1  100




*** Test Cases ***
Creation of SO
#    Set Selenium Speed    0.1
    login devsite
    select site  testingsiteautomation
    open order tracker page
    sleep  1
    click  ${newSO}
    Wait For Elements State      //span[text()="Add New SO"]  visible   timeout=60s
    select customer  ${customername}[0]
    ${randomrefNumber}=  generate random string  5-10  [NUMBERS]
    input  ${refNumber}  ${randomrefNumber}
    ${random_string}  Generate Random String  10-15  [LETTERS]
    input   ${Sodetailsfield}  ${random_string}
    Log  Random Alphabet String: ${random_string}
    delivery date entry
    ${today1}    Get Current Date  result_format=%d-%m-%Y
    Set Ith Item In SO Image Validation   0  ${itemData1}[0]  ${itemData1}[1]
    sleep  1
    click  ${submit}
    ${order_info}    browser.Get Text    xpath=//div[contains(@style, 'text-align: center;')]
    ${start_index}    Evaluate    "${order_info}".find("Order ") + len("Order ")
    ${end_index}    Evaluate    "${order_info}".find(" has been created!")
    ${order_number}    Evaluate    "${order_info}"[${start_index}:${end_index}]
    click  ${createNewOrder}
    click  ${backbutton}
    #validation for so creation search
    search Sonumber in SoListpage for validation  ${order_number}
    click  (//a[text()="${order_number}"]/../../../../../../../../span)[1]
    sleep  1
    Reload
    Wait For Elements State    css=img.ant-image-img    visible   timeout=120s


