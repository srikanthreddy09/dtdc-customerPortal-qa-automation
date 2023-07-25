*** Settings ***
Resource          ../../Config/super.robot

*** Variables ***
${web.spinners.page.loading}    xpath://body[@block-ui='main' and @aria-busy='true']
