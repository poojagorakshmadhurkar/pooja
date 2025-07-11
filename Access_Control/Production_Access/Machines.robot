*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    DateTime
Resource   ../../././Access_Control/Keyword.robot
Resource   ../../././orders/PurchaseOrder/keyword.robot
Resource   ../../././orders/PurchaseOrder/variable.robot
Resource   ../.././inventory/Rework_Reuse_Scrap/Keyword1.robot
Resource   ../.././inventory/Rework_Reuse_Scrap/Variable1.robot

*** Variables ***

*** Test Cases ***
#TC_01_VERIFY_MACHINE_ACCESS_ENABLED
#    Owner Login   Nitesh    ${PRODUCTION ACCESS TAB}
#    set selenium speed    0.05s
#    click   ${MACHINE_+_BTN}
#    click   ${SELECT_MF5_MACHINE_CHECKBOX}
#    click   ${SELECT_WIP_SECTION_MACHINE_CHECKBOX}
#    click   ${SELECT_FG_SECTION_MACHINE_CHECKBOX}
#    sleep   0.5s
#    click   ${CLICK_SUBMIT}
#    sleep   0.05s
#    close Browser
#    TC_02Employee Access    ${MASTERS1}
#    set selenium speed    0.07s
##   View access check
#    wait until element is visible   ${MASTERS1}   30s
#    mouse over  ${MASTERS1}
#    click   ${MACHINES}
##    click   ${Production_Reports}
#    sleep   0.05s
#    reload page
#    wait until element is visible   ${MF-5_WIP_&_FG_SECTION_MACHINE_ACCESS_CHECK"}   30s
#    close Browser
#TC_02_VERIFY_MACHINE_ACCESS_DISABLED
#    Owner Login   Nitesh    ${PRODUCTION ACCESS TAB}
#    set selenium speed    0.05s
#    click   ${MACHINE_+_BTN}
#    click   ${SELECT_MF5_MACHINE_CHECKBOX}
#    click   ${SELECT_WIP_SECTION_MACHINE_CHECKBOX}
#    click   ${SELECT_FG_SECTION_MACHINE_CHECKBOX}
#    sleep   0.5s
#    click   ${CLICK_SUBMIT}
#    sleep   0.05s
#    close Browser
#    TC_02Employee Access    ${MASTERS1}
#    set selenium speed    0.07s
##   View access check
#    wait until element is visible   ${MASTERS1}   30s
#    mouse over  ${MASTERS1}
#    click   ${MACHINES}
##    click   ${Production_Reports}
#    sleep   0.05s
#    reload page
#    Safe Element Should Not Be Visible   ${MF-5_WIP_&_FG_SECTION_MACHINE_ACCESS_CHECK"}   30s
#    close Browser
TC_03_VERIFY_MACHINE_ACCESS_HIERARCHY
    Owner Login   Nitesh    ${PRODUCTION ACCESS TAB}
    set selenium speed    0.05s
    click   ${MACHINE_+_BTN}
    click   ${FG_SECTION_MACHINE_+_BTN2}
#    Scroll Element Into View    ${MFG-3_SECTION_MACHINE_+_BTN}
    click   ${MFG-3_SECTION_MACHINE_+_BTN}
    click   ${CNC_3_SECTION_MACHINE_+_BTN}
    click   ${SELECT_CNC_3_CHILD_MACHINE_CHECKBOX}
    sleep   0.5s
    click   //*[@id="__submit"]     #${CLICK_SUBMIT}
    sleep   1s
    ${n}=   get text    //*[text()="Employee edited"]
    log    ${n}
    sleep   0.5s
    click    ${PRODUCTION ACCESS TAB}
    sleep    1s
    close Browser
    TC_02Employee Access    ${MASTERS1}
    set selenium speed    0.5s
#   View access check
    wait until element is visible   ${MASTERS1}   30s
    mouse over  ${MASTERS1}
    sleep   0.5s
    click   ${MACHINES}
    sleep   0.5s
    reload page
    wait until element is visible   ${FG_SECTION_MACHINE_ACCESS_CHECK"}   30s
    close Browser