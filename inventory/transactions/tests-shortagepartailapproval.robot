*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections
Library    DateTime

*** Variables ***
@{itemData}  RM0003  100

*** Test Cases ***
Making a transaction for an item more than the inventory value and partially approving it
    login
    select site  testing_site_automation
    Search and Check Item Quantity  ${itemData}[0]  ${itemData}[1]  Test_Employee07  Vendor1113
    open warehouse
    ${save}  item current stock  ${itemData}[0]
    open transactions page
    click  ${outwardTab}
    click  ${newOutwardNote}
    select outward to  Customer
    select outward customer to  Cust-003
    sleep  1
    ${today1}=  Get Current Date  result_format=%d-%m-%Y
    sleep  1
    click  ${dateOutward}
    input  ${dateOutward}  ${today1}
    sleep  1
    press keys  ${dateOutward}  ENTER
    sleep  1
    set ith item in outward  0  ${itemData}[0]  ${save+1}
    click  ${submit}
    click  ${newRequest}
    open transactions page
    click  ${outwardTab}
    sleep  2
    outward tr status no method 2  Shortage  1
    sleep  1
    open outward tr note  1
    ${outputValue}  Get Text  //span[text() = "${itemData}[0]"]/../../../../../../../../../../td[1]
    ${outputValue_number}  Evaluate  ''.join(c for c in "${outputValue}" if c.isdigit())
    ${integer_value1}  Convert To Integer  ${outputValue_number}
    Should Be Equal As Integers    ${integer_value1}    ${save+1}
    ${shortageValue}  Get Text  //span[text() = "${itemData}[0]"]/../../../../../../../../../../td[2]/span
    ${shortageValue_number}  Evaluate  ''.join(c for c in "${shortageValue}" if c.isdigit())
    ${integer_value2}  Convert To Integer  ${shortageValue_number}
    Should Be Equal As Integers    ${integer_value2}    1
    click  //button[@class='MuiButtonBase-root MuiIconButton-root MuiIconButton-sizeLarge css-1w8s6so']
    sleep  1
    outward approve number  1
    wait until page contains element  ${approveRequest}  10
    ${requestedValue}  Get Text  //span[text() = "${itemData}[0]"]/../../../../../../../../../../td[1]
    ${requestedValue_number}  Evaluate  ''.join(c for c in "${requestedValue}" if c.isdigit())
    ${integer_value3}  Convert To Integer  ${requestedValue_number}
    Should Be Equal As Integers    ${integer_value3}    ${save+1}
    ${quantityValue}  Get Text  //span[text() = "${itemData}[0]"]/../../../../../../../../../../td[2]
    ${quantityValue_number}  Evaluate  ''.join(c for c in "${quantityValue}" if c.isdigit())
    ${integer_value4}  Convert To Integer  ${quantityValue_number}
    Should Be Equal As Integers    ${integer_value4}    ${save}
    click  ${approveRequest}
    sleep  1
    i should see text on page  MRN approved SuccesFully
    sleep  1
    outward tr status no method 2  Shortage  1
    outward tr status no method 2  Approved  2
    outward approve number  1
    ${requestedValue1}  Get Text  //span[text() = "${itemData}[0]"]/../../../../../../../../../../td[1]
    ${requestedValue_number}  Evaluate  ''.join(c for c in "${requestedValue1}" if c.isdigit())
    ${integer_value3}  Convert To Integer  ${requestedValue_number}
    Should Be Equal As Integers    ${integer_value3}    1
    ${quantityValue2}  Get Text  //span[text() = "${itemData}[0]"]/../../../../../../../../../../td[2]
#    ${quantityValue2_}  Evaluate  ''.join(c for c in "${quantityValue2}" if c.isdigit())
    Should Be Equal As Strings    ${quantityValue2}    -
    sleep  1
    open warehouse
    No live inventory check  ${itemData}[0]


# alternate item needs to be handled is pending
