*** Settings ***

*** Variables ***
${NEW}    //button[text()='NEW']
${SO_NUMBER}   //*[@id="sales_order_label"]
${ITEM_NAME1}   //*[@id="undefined_label"]
${CREATE_WO}   //button[text()=' Create WO']
#${MACHINE}  (//div[text()='${machine}[0]']/following-sibling::button)[1]
${PLAN ALL}   //button[@fdprocessedid="xqvwsr"]
${REVIEW CHNAGES}   //*[@fdprocessedid="5bp4qa"]
${CREATE}   //button[@fdprocessedid="5bp4qa"]
${WO}    //div[@data-task-id="8905"]
#${CLICK_ITEM}   //a[contains(text(),'${itemData1}[0]')]
${EXPAND_ALL}   //button[@class='ant-switch ant-switch-small']//div[1]
${NEXT_TAB}   http://192.46.212.39/masters/sites/3/skus/128630/edit
${CLICK_MACHINE_SEARCH}   (//*[@id="live_inventory_Machines_search"])
${REWORK_BTN}   (//*[@text="Rework"])[5]    #((//span[contains(text(),"Fgitem1")])[7]/../../../../../../../../..//td[8]/..//td[10]//div[1])[2]
${REWORK_BTN2}   (//*[contains(text(),"Fgitem1")])[7]/../../../../../../../../..//td[contains(text(),"Production")]/..//td[contains(text(),"P2")]/..//td[contains(text(),"Damage")]/../td[6]//div[1]//div[2]//*[@id="rejected__Quantity_0"]
${ENTER_REWORK_INPUTBOX}    (//input[@id='rejected__Quantity_0'])[2]
${REWARK_NOTE_MSG}  //div[text()='Selected items reworked successfully']
${FG}   //div[@id="live_inventory_item__tabs-tab-3"]
${REWORK_ID_IN_OUTWARD}    //div[@class='ant-descriptions-title']//h6[1]
${CANCEL_ICON}   //*[@data-testid="CancelIcon"]
${APPROVE_FOR_DEBIT}    //div[@id='item__tabs-panel-debit']//button//*[name()="svg"][@id="transaction_debit_approve"][1]
${SEARCH_IN_MRN_ISSUE_NOTE}   (//*[@id="transaction_Material Issue Note_search"])[2]
${INPUT_INTO_MRN_ISSUE_NOTE}  //*[@placeholder='Search Material Issue Note']
${SEARCH_IN_MRN_ISSUE_NOTE2}   (//*[@id="transaction_Material Issue Note_search"])[3]
${CLICK_PENDING_TEXT}    //div[@id='item__tabs-panel-debit']//button//*[name()="svg"]/../../../../../td[8]//span[text()='Pending']
${REJECTED_QTY_VALUE}    (//*[@data-row-key="124571"]//td[5])[2]


