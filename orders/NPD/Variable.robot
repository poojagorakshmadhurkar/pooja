*** Settings ***
Library  Browser
Library  String
Library  Collections

*** Variables ***
${inquiry}  //a[@id="enquiry"]
${NEW}  //*[text()="NEW"]
${Add Formulation Item}   //*[text()="Add Formulation Item"]
${Add Item}   //*[@id="template__add_sku"]
${Item Details + button}    (//*[@data-testid="AddOutlinedIcon"])[1]
${F_item_submit}    //*[@id="__submit"]
${Brows File}    //input[@type='file']