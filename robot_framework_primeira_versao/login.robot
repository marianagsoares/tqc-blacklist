*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Library    RequestsLibrary


*** Variables ***
${BASE_URL}    https://api-blacklist.qacoders.dev.br/api
${EMAIL}    sysadmin@qacoders.com
${PASSWORD}    1234@Test


*** Test Cases ***
Validar Login
    Realizar Login Com Credenciais Válidas


*** Keywords ***
Criar Sessao
    ${headers}=    Create Dictionary   accept=application/json    Content-Type=application/json
    Create Session   alias=develop   url=${BASE_URL}    headers=${headers}

Realizar Login Com Credenciais Válidas
    ${body}=    Create Dictionary    mail=${EMAIL}    password=${PASSWORD}
    Criar Sessao
    ${bodyResponse}    POST On Session    alias=develop    url=/login    json=${body}    verify=${True}
    Log     ${bodyResponse.json()}
    Log    ${bodyResponse.json()['token']}
    Status Should Be    200    ${bodyResponse}