*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Library    RequestsLibrary
Library    FakerLibrary    locale=pt_BR
Resource    ../resources/generate_random_data.resource
Resource    ../config/dev.robot


*** Keywords ***
Criar Sessao
    ${headers}=    Create Dictionary   accept=application/json    Content-Type=application/json
    Create Session   alias=develop   url=${BASE_URL}    headers=${headers}

Realizar login
    ${body}=    Create Dictionary    mail=${USER_EMAIL}    password=${USER_PASSWORD}
    Criar Sessao
    ${bodyResponse}    POST On Session    alias=develop    url=/login    json=${body}    verify=${True}
    Log     ${bodyResponse.json()}
    Log    ${bodyResponse.json()['token']}
    Status Should Be    200    ${bodyResponse}
    RETURN    ${bodyResponse.json()['token']}

Gerar Usuario
    
    ${FIRST_NAME}    Gerar primeiro nome nao composto
    ${LAST_NAME}    Gerar ultimo nome nao composto
    ${RANDOM_PASSWORD}    Gerar Senha Aleatoria
    ${RANDOM_CPF}    Gerar CPF Unico

    Set Test Variable    ${FULLNAME}        ${FIRST_NAME} ${LAST_NAME}
    Set Test Variable    ${EMAIL}     ${FIRST_NAME.lower()}@qacoders.com
    Set Test Variable    ${PASSWORD}    ${RANDOM_PASSWORD}
    Set Test Variable    ${USER_CPF}    ${RANDOM_CPF}
    Set Test Variable    ${ACCESS_PROFILE}    ADMIN
    
Cadastrar novo usuario
    Gerar Usuario
    ${TOKEN}    Realizar login

    ${body}    Create Dictionary
    ...    fullName=${FULLNAME} 
    ...    mail=${EMAIL}
    ...    accessProfile=${ACCESS_PROFILE}
    ...    cpf=${USER_CPF}
    ...    password=${PASSWORD}
    ...    confirmPassword=${PASSWORD}
 
    ${response}    POST On Session    alias=develop    url=/user?token=${TOKEN}    json=${body}    verify=${True}
    Status Should Be    201    ${response}
    Log     ${response.json()}
    Set Suite Variable    ${USER_ID}    ${response.json()['user']['_id']}   


Listar todos os usuários cadastrados
    ${TOKEN}    Realizar login
    GET On Session    alias=develop    url=/user?token=${TOKEN}     verify=${True}


Listar usuario cadastrado por id
    ${TOKEN}    Realizar login

    ${response}    GET On Session    alias=develop    url=/user/${USER_ID}?token=${TOKEN}    verify=${True}
    Log     ${response.json()}
    Status Should Be    200    ${response}

Atualizar dados do usuário cadastrado por id
    ${TOKEN}    Realizar login
    Gerar Usuario
    ${body}    Create Dictionary
    ${body}    Create Dictionary
    ...    fullName=${FULLNAME} 
    ...    mail=${EMAIL}
    ...    accessProfile=${ACCESS_PROFILE}
    ...    cpf=${USER_CPF}
    ...    password=${PASSWORD}
    ...    confirmPassword=${PASSWORD}
    ${response}    PUT On Session    alias=develop    url=/user/${USER_ID}?token=${TOKEN}    json=${body}    verify=${True}
    Status Should Be    200    ${response}

Deletar usuário cadastrado por id
    ${TOKEN}    Realizar login
    DELETE On Session    alias=develop    url=/user/${USER_ID}?token=${token}    verify=${True}

Cadastrar usuario com confirmacao de senha diferente
    Gerar Usuario
    ${TOKEN}    Realizar login

    ${body}    Create Dictionary
    ...    fullName=${FULLNAME} 
    ...    mail=${EMAIL}
    ...    accessProfile=${ACCESS_PROFILE}
    ...    cpf=${USER_CPF}
    ...    password=${PASSWORD}
    ...    confirmPassword=${PASSWORD}123
 
    ${response}    POST On Session    alias=develop    url=/user?token=${TOKEN}    json=${body}    expected_status=400    verify=${True}
    Status Should Be    400    ${response}
    Log     ${response.json()}
    Should Be Equal As Strings    ${response.json()['error'][0]}    As senhas não conferem.
