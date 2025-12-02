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
${USER_FULLNAME}  Novo Nome
${USER_MAIL}      novo.email@qacoders.com
${ACCESS_PROFILE}    ADMIN
${USER_CPF}       12345678900
${NEW_PASSWORD}   5678@Test
${CONFIRM_PASSWORD}  5678@Test


*** Test Cases ***
Atualizar status do usuário
    Inativar usuario cadastrado por id

Atualizar dados do usuário
    Atualizar dados do usuário cadastrado por id

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
Inativar usuario cadastrado por id
    ${token}    Realizar login com credenciais validas e armazenar token
    ${body}   Create Dictionary    status=false
    PUT On Session    alias=develop    url=/user/status/${USER_ID}?token=${token}    verify=${True}

Atualizar dados do usuário cadastrado por id
    ${token}    Realizar login com credenciais validas e armazenar token
    ${body}    Create Dictionary    
    ...    fullName=${USER_FULLNAME}
    ...    mail=${USER_MAIL}
    ...    accessProfile=${ACCESS_PROFILE}
    ...    cpf=${USER_CPF}
    ...    password=${NEW_PASSWORD}
    ...    confirmPassword=${CONFIRM_PASSWORD}
    ${response}    PUT On Session    alias=develop    url=/user/${USER_ID}?token=${token}    json=${body}    verify=${True}
    Status Should Be    200    ${response}