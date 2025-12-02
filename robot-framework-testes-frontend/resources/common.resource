*** Settings ***
Library    SeleniumLibrary
Resource    ../config/dev.robot


*** Keywords ***
Abrir Navegador
    Open Browser    ${BASE_URL_UI}    Chrome
    Maximize Browser Window

Fechar Navegador
    Close Browser