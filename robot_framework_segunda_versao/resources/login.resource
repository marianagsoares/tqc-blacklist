*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Library    RequestsLibrary
Resource    ../config/dev.robot


*** Keywords ***
Criar Sessao
    ${headers}=    Create Dictionary   accept=application/json    Content-Type=application/json
    Create Session   alias=develop   url=${BASE_URL}    headers=${headers}

Realizar login
    ${body}=    Create Dictionary    mail=${USER_EMAIL}   password=${USER_PASSWORD}

    Criar Sessao

    ${bodyResponse}    POST On Session    alias=${SESSION_ALIAS}     url=/login    json=${body}    verify=${True}

    Log     ${bodyResponse.json()}
    Log    ${bodyResponse.json()['token']}
    Status Should Be    200    ${bodyResponse}

    RETURN    ${bodyResponse.json()['token']}

Realizar login
    ${body}=    Create Dictionary    mail=${USER_EMAIL}   password=${USER_PASSWORD}

    Criar Sessao

    ${bodyResponse}    POST On Session    alias=${SESSION_ALIAS}     url=/login    json=${body}    verify=${True}

    Log     ${bodyResponse.json()}
    Log    ${bodyResponse.json()['token']}
    Status Should Be    200    ${bodyResponse}

    RETURN    ${bodyResponse.json()['token']}