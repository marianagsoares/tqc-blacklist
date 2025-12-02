*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Library    RequestsLibrary


*** Variables ***
${BASE_URL}    https://api-blacklist.qacoders.dev.br/api
${EMAIL}    sysadmin@qacoders.com
${PASSWORD}    1234@Test
${USER_ID}    68e01e7601b4c8756f5b92f6

*** Test Cases ***
Deletar usuário
    Deletar usuário cadastrado por id

*** Keywords ***
Criar Sessao
    ${headers}=    Create Dictionary   accept=application/json    Content-Type=application/json
    Create Session   alias=develop   url=${BASE_URL}    headers=${headers}

Realizar login com credenciais validas e armazenar token
    ${body}=    Create Dictionary    mail=${EMAIL}    password=${PASSWORD}
    Criar Sessao
    ${bodyResponse}    POST On Session    alias=develop    url=/login    json=${body}    verify=${True}
    Log     ${bodyResponse.json()}
    Log    ${bodyResponse.json()['token']}
    Status Should Be    200    ${bodyResponse}
    RETURN    ${bodyResponse.json()['token']}
Deletar usuário cadastrado por id
    ${token}    Realizar login com credenciais validas e armazenar token
    DELETE On Session    alias=develop    url=/user/${USER_ID}?token=${token}    verify=${True}