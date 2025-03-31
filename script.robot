*** Settings ***
Resource  import.robot

*** Test Cases ***

Check Search Result On e-Bay Website
    Open Browser	http://ebay.com    Chrome
    Maximize Browser Window
    Wait Until Element Is Visible    ${search_textbox}   30s
    ${text}    Set Variable    Tesla
    Input Text    ${search_textbox}    ${text}
    Click Button    ${search_button}
    Select Checkbox    ${model_year}
    ${result_text}    Get Text   ${result_text}
    Should Be Equal    ${result_text}    ${text}
    ${count_text}    Get Text    ${result_count}
    Should Not Be Equal    ${count_text}    0