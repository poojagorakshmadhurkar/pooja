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
${my_text}    Sales Orders
@{customername1}    Test01
@{itemData11}    Fgitem1  100  50

*** Test Cases ***
#TC_01_VERIFY_DISALLOW_PRODUCTION_ACCESS_ENABLED
#    Owner Login   Nitesh    ${PRODUCTION ACCESS TAB}
#    set selenium speed    0.05s
#    click   ${DPR_+_BTN}
#    click   ${CLICK_DPR_CHECKBOX}
#    sleep   0.5s
#    click   ${CLICK_DISALLOW_PRODUCTION_CHECKBOX}
#    click   ${CLICK_SUBMIT}
#    sleep   0.05s
#    close Browser
#    TC_02Employee Access    ${PRODUCTION}
#    set selenium speed    0.07s
##   View access check
#    wait until element is visible   ${Production_Reports}   30s
#    click   ${Production_Reports}
#    sleep   0.05s
#    reload page
#    wait until element is visible   ${PRODUCTION_2}   30s
#    close Browser
#TC_02_VERIFY_DISALLOW_PRODUCTION_ACCESS_DISABLED
#    Owner Login   Nitesh    ${PRODUCTION ACCESS TAB}
#    set selenium speed    0.05s
#    click   ${DPR_+_BTN}
#    click   ${CLICK_DPR_CHECKBOX}
#    sleep   0.5s
#    click   ${CLICK_DISALLOW_PRODUCTION_CHECKBOX}
#    click   ${CLICK_SUBMIT}
#    sleep   0.05s
#    close Browser
#    TC_02Employee Access    ${PRODUCTION}
#    set selenium speed    0.07s
##   View access check
#    wait until element is visible   ${Production_Reports}   30s
#    click   ${Production_Reports}
#    sleep   0.5s
#    reload page
#    element should not be visible   ${PRODUCTION_2}   30s
#    sleep   0.05s
#    close Browser
TC_03_VERIFY_DISALLOW_REJECTION_ACCESS_ENABLED
    Owner Login   Nitesh    ${PRODUCTION ACCESS TAB}
    set selenium speed    0.05s
    click   ${DPR_+_BTN}
    click   ${CLICK_DPR_CHECKBOX}
    sleep   0.5s
    click   ${CLICK_DISALLOW_REJECTION_CHECKBOX}
    click   ${CLICK_SUBMIT}
    sleep   0.05s
    close Browser
    TC_02Employee Access    ${PRODUCTION}
    set selenium speed    0.07s
#   View access check
    wait until element is visible   ${Production_Reports}   30s
    click   ${Production_Reports}
    sleep   0.05s
    reload page
    wait until element is visible   ${REJECTED_QUALITY_2}   30s
    close Browser
#TC_04_VERIFY_DISALLOW_REJECTION_ACCESS_DISABLED
#    Owner Login   Nitesh    ${PRODUCTION ACCESS TAB}
#    set selenium speed    0.05s
#    click   ${DPR_+_BTN}
#    click   ${CLICK_DPR_CHECKBOX}
#    sleep   0.5s
#    click   ${CLICK_DISALLOW_REJECTION_CHECKBOX}
#    click   ${CLICK_SUBMIT}
#    sleep   0.05s
#    close Browser
#    TC_02Employee Access    ${PRODUCTION}
#    set selenium speed    0.07s
##   View access check
#    wait until element is visible   ${Production_Reports}   30s
#    click   ${Production_Reports}
#    sleep   0.5s
#    reload page
#    element should not be visible   ${REJECTED_QUALITY_2}   30s
#    sleep   0.05s
#    close Browser
#TC_05_VERIFY_DISALLOW_REJECTION_ACCESS_ENABLED
#    Owner Login   Nitesh    ${PRODUCTION ACCESS TAB}
#    set selenium speed    0.05s
#    click   ${DPR_+_BTN}
#    click   ${CLICK_DPR_CHECKBOX}
#    sleep   0.5s
#    click   ${CLICK_DISALLOW_REJECTION_CHECKBOX}
#    click   ${CLICK_SUBMIT}
#    sleep   0.05s
#    close Browser
#    TC_02Employee Access    ${PRODUCTION}
#    set selenium speed    0.07s
##   View access check
#    wait until element is visible   ${Production_Reports}   30s
#    click   ${Production_Reports}
#    sleep   0.05s
#    reload page
#    wait until element is visible   ${REJECTED_QUALITY_2}   30s
#    close Browser
#TC_06_VERIFY_DISALLOW_REJECTION_ACCESS_DISABLED
#    Owner Login   Nitesh    ${PRODUCTION ACCESS TAB}
#    set selenium speed    0.05s
#    click   ${DPR_+_BTN}
#    click   ${CLICK_DPR_CHECKBOX}
#    sleep   0.5s
#    click   ${CLICK_DISALLOW_REJECTION_CHECKBOX}
#    click   ${CLICK_SUBMIT}
#    sleep   0.05s
#    close Browser
#    TC_02Employee Access    ${PRODUCTION}
#    set selenium speed    0.07s
##   View access check
#    wait until element is visible   ${Production_Reports}   30s
#    click   ${Production_Reports}
#    sleep   0.5s
#    reload page
#    element should not be visible   ${REJECTED_QUALITY_2}   30s
#    sleep   0.05s
#    close Browser




