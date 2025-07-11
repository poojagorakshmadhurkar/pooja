*** Variables ***
${addNewMachine}  (//button[normalize-space()='NEW'])[1]
${machineName}  //input[@id = "machine__label"]
${Submit}  //button[text() = "Submit"]
${parent}   //input[@id = "machine__parent"]
${inputScrapData}  //input[@id = "machine__log_scrap"]/..
${inputEnergyData}  //input[@id = "machine__log_kwh"]/..
${woInProductionFalseCheck}  //input[@id = "site__wo_false_checkbox"]/..
${newParent}  //span[text() = "New Parent"]/../../div[2]/div/span/input
${reParentButton}  //button[@id = "machines__re_parent_submit_btn"]
${Edit}  //button[normalize-space()='Edit']
${deactivate_machine}  //button[text() = "Deactivate"]
${itemGtags}  //span[text() = "Item Group Tags"]/../../../div[2]/div/div
${addmachinebutton}  //button[normalize-space()='+ Add Another Machine']
${Addchildbutton}  //button[normalize-space()='+ Add Child']
${nextmachinebtn}  //button[normalize-space()='Next']
${machinesubmitbtn}  button[type='submit']
${machinebackbtn}  (//*[name()='svg'][@id='back_btn'])[1]