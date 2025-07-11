*** Variables ***
${dispatchplanbutton}  //div[contains(text(),'Schedule dispatch')]
${dipatchsubmitbutton}  //button[@id="debit__details__submit"]
${START_DATE_FIELD}    (//span[text()="Delivery Date *"]/../../div[2]/div/input)[1]
${viewschdeuledispatch}  (//div[text()="View Schedule dispatch"])
${dispatchorder}  //span[normalize-space()='Dispatch']
${dispatchschedulepage}  //ul[@id="menu-list-grow"]//a[@id="dispatch_scheduling"]
${Editdispatcheventbutton}  //button[@id="edit _dispatch"]
${dipatcheditbutton}  //button[@id="debit__details__edit"]
${dispatchbackbutton}  (//*[name()='svg'][@id='back_btn'])
${dispatchshipmentbutton}  //button[@id='create _shipment']
${dispatchtab}  //div[normalize-space()='Dispatch Planning']/../..
${itemviewbutton}  //button[text()="Item View"]
${dispatchdeletebutton}  //div[contains(text(),'Delete Dispatch')]
${deleteThisshipmentbutton}  //span[normalize-space()='This shipment']
${deleteAllshipmentbutton}   //span[normalize-space()='All shipments']
${agreebutton}  //button[normalize-space()='Agree']
${innerreloadbutton}  (//*[name()='svg'][@class='MuiSvgIcon-root MuiSvgIcon-fontSizeMedium css-vubbuv'])[4]