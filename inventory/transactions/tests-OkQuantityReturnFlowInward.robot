*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections

*** Variables ***
@{itemData1}  RM0001  100

*** Test Cases ***
Return Inward return only good quantity allOk non rack case
    login
    select site  testing_automation_site2
    open warehouse
    ${save}  item current stock  ${itemData1}[0]
    open transactions page
    click  ${newInwardNote}
    select item type  Raw Material
    select inspector  Test Customer-01
#    ${randomGrn}=  generate random string  5-10  [NUMBERS]
#    press keys  ${grnNumber}  CTRL+BACKSPACE
#    input  ${grnNumber}  ${randomGrn}
    ${text}    Get Value    ${InwardGRNfield}
    select partner  Vendor1113
    input  ${invoiceNumber}  inv1001
    set ith item in inward  0  ${itemData1}[0]  ${itemData1}[1]
    click  ${inwardSubmit}
    click  ${newRequest}
    open transactions page
    sleep  2
    inward tr status no method 2  IQC Pending  1
    click  //div[@id = "item__tabs-panel-credit"]//tbody/tr[2]/td/div/span/a
    click  ${qualityChecktab}
    sleep  2
    click  ${inwardEdit}
    click  ${allOk}
    wait until element is visible  //span[text() = "No Rejections"]
    i should see text on page  Transaction Edited SuccesFully
    open transactions page
    wait until element is visible  ${newInwardNote}
    sleep  2
    inward tr status no method 2  Pending  1
    inward approve number  1
    i should see text on page  MRN approved SuccesFully
    sleep  2
    inward tr status no method 2  Approved  1
    sleep  3
    open warehouse
    ${save2}  item current stock  ${itemData1}[0]
    ${sum}  Set Variable  ${save} + ${itemData1}[1]
    ${afterCredit}  Evaluate  eval("${sum}")
    Should Be Equal As Integers    ${save2}  ${afterCredit}
    open transactions page
    inward transaction search through GRN  ${text}
    click  //a[text() = "${text}"]/ancestor::tr//button[@aria-label = "Return"]

#    Element Should Be Empty  (//span[text() = "${itemData1}[0]"]/ancestor::tr//input[@type = "text"])[2]
    click  ${buttonSubmit}
    i should see text on page  Return request submitted
    click  ${outwardTab}
    outward tr status no method 2  Pending  1
    open outward tr note  1
    ${ReturnGrn}  return confirmation  ${text}
    click  ${cross}
#    outward transaction search through GRN  ${ReturnGrn}
    sleep  2
    open outward tr note  1
    ${OutQuantity}  Get Text  //span[text() = "${itemData1}[0]"]/ancestor::tr/td[1]
    ${outputValue_number}  Evaluate  ''.join(c for c in "${OutQuantity}" if c.isdigit())
    ${integer_value1}  Convert To Integer  ${outputValue_number}
    Should Be Equal As Integers    ${integer_value1}    ${itemData1}[1]
    ${avaibility}  Get Text  //span[text() = "${itemData1}[0]"]/ancestor::tr/td[2]/span
    Should Be Equal As Strings  ${avaibility}  Available
    click  ${cross}
    outward approve number  1
    i should see text on page  MRN approved SuccesFully
    outward tr status no method 2  Approved  1
    sleep  3
    open warehouse
    ${save3}  item current stock  ${itemData1}[0]
    ${sub2}  Set Variable  ${itemData1}[1] - ${integer_value1}
    ${liveInventoryIncrement}  Evaluate  eval("${sub2}")
    ${finalLiveValue}  Set Variable  ${save} + ${liveInventoryIncrement}
    ${liveInventoryValue}  Evaluate  eval("${finalLiveValue}")
    Should Be Equal As Integers    ${save3}  ${liveInventoryValue}