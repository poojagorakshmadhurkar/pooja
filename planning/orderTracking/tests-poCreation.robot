*** Settings ***
Library  SeleniumLibrary
Resource  ../../keywords.robot
Resource  ./keywords.robot
Resource  ./variables.robot
Library  String
Library  Collections

*** Test Cases ***
Creation of PO
    login
    open order tracker page
    click  ${poTab}
    sleep  1
    click  ${newPO}
    sleep  5
    click  ${customerName}
    sleep  1
    press keys  ${customerName}  Fbt Electronics
    press keys  ${customerName}  ENTER
    ${randomPoNumber}=  generate random string  5-10  [NUMBERS]
    input  ${poNumber}  ${randomPoNumber}
    input  ${poIssueDate}  07092023
    input  ${poExpiryDate}  07102023
    click  ${saveOrderButton}
    i should see text on page  Form Created Successfully

Creation of SO
    click  ${planThisOrder}

    click  ${newSoButton}
    sleep  5
    SO creation  1  Iron Rod  200
    click  //tbody/tr/th/span/a
    click  ${createWo}
    sleep  40
    create WO on specified machine  MWIP-2  Right Now
#    Cross-checking so under the same po  1



