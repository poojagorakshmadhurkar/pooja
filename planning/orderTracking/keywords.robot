*** Settings ***
Library  SeleniumLibrary
Resource  ../../../keywords.robot
Resource  ../../../variables.robot
Resource  ./variables.robot
Library  String
Library  Collections

*** Keywords ***
open order tracker page
    click  ${planningDropdown}
    sleep  2
    click  ${planningOrderTracking}
    sleep  2

SO creation
    [Arguments]  ${k}  ${itemName}  ${itemQuantity}
    input  ${soStartDate}  04092023
    input  ${soDeliveryDate}  06092023
    input  (//input[@placeholder = "Select Item..."])[${k}]  ${itemName}
    press keys  (//input[@placeholder = "Select Item..."])[${k}]  ENTER
    input  (//input[@placeholder = "Quantity"])[${k}]  ${itemQuantity}
    click  ${saveOrderButton}
    i should see text on page  Form Created Successfully
    [return]  ${itemName}

Cross-checking so under the same po
    [Arguments]  ${i}
    click  //tbody/tr[${i}]/th/span/a

create WO on specified machine
    [Arguments]  ${machineName}  ${scheduleType}
    click  (//div[text() = "${machineName}"]/..)/button[1]
    select option from dropdown  //span[text() = "Schedule"]/../../div[2]  //span[text() = "${scheduleType}"]/../..
    ${randomWoValue}=  generate random string  1  [NUMBERS]
    input  ${woQuantity}  ${randomWoValue}
    click  ${previewWo}

    click  ${Create}
    click  ${mrnRequest}