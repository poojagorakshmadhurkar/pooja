*** Settings ***
Library   Browser
Library   DateTime
Library   String
Library   Collections
*** Variables ***
${SUBCONTRACTING}  //*[text()="Subcontracting"]
${REPAIR_REQUEST}  //a[@id="repair_request"]