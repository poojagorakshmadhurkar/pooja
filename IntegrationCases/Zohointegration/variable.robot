*** Variables ***

${inventorybutton}   (//button[normalize-space()='Inventory'])[1]
${itembutton}  (//a[normalize-space()='Items'])[1]
${zohoinputfeild}  //legend[span[text()="Name"]]/following::input[1]
${savebtn}  (//button[normalize-space()='Save'])[1]
${pobackbtn}  //button[@type='button']//button[@aria-label='back-button']//*[name()='svg']
${NewPo}   (//a[normalize-space()='NEW'])[1]
${posubmit}  //button[@id='__submit']
${inwardbtn}   (//*[name()='svg'][@id='purchase_order_inward'])[1]
