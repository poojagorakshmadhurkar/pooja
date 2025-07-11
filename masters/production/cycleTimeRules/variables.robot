*** Variables ***
${addNewRule}  //button[text() = "NEW"]
${machineGroup}  //span[text() = "Machine Group"]/../../../div[2]/div
${itemGrouptags}  //span[text() = "Item Group Tag"]/../../../div[2]/div
${process}  //span[text() = "Process"]/../../../div[2]/div/span/input
${Seconds}  //input[@id='rule__seconds']
${Submit}  //button[text() = "Submit"]
${back}  //a[@aria-label = "back-button"]
${filterButton}  (//*[name()='svg'][@id='undefined_Machines_search'])[1]
${machineFilter}  (//input[@type="search"])[2]
${itemFilter}  (//input[@type="search"])[3]
${processFilter}  (//input[@type="search"])[4]
${valueFilter}  (//input[@type="search"])[5]
${dailyTarget}  (//input[@type="search"])[6]
