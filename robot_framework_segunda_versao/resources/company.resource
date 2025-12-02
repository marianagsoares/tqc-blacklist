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

Gerar Empresa
    ${corporateName}=        Gerar nome da empresa
    ${registerCompany}=      Gera cnpj da empresa
    ${mail}=                 Set Variable   ${corporateName.lower()}@qacoders.com
    ${firstName}=            Gerar primeiro nome nao composto
    ${lastName}=             Gerar ultimo nome nao composto
    ${responsibleContact}=    Set Variable    ${firstName} ${lastName}
    ${telephone}=            Generate Random String    11    [NUMBERS]
    ${serviceDescription}=   Sentence    6
    ${zipCode}=              Gerar cep sem caracteres especiais
    ${city}=                 City
    ${state}=                Gerar sigla do estado
    ${district}=             Street Name
    ${street}=               Gerar logradouro sem caracteres especiais
    ${number}=               Building Number
    ${complement}=           Generate Random String    5    [LETTERS]
    #${country}=              Gerar pais Sem Acentos

    Set Suite Variable       ${COMPANY_NAME}          ${corporateName}
    Set Suite Variable       ${REGISTER_COMPANY}      ${registerCompany}
    Set Suite Variable       ${MAIL}                  ${mail}
    Set Suite Variable       ${MATRIZ}                teste
    Set Suite Variable       ${RESPONSIBLE_CONTACT}   ${responsibleContact}
    Set Suite Variable       ${TELEPHONE}             ${telephone}
    Set Suite Variable       ${SERVICE_DESCRIPTION}   ${serviceDescription}
    Set Suite Variable       ${ZIPCODE}               ${zipCode}
    Set Suite Variable       ${CITY}                  ${city}
    Set Suite Variable       ${STATE}                 ${state}
    Set Suite Variable       ${DISTRICT}              ${district}
    Set Suite Variable       ${STREET}                ${street}
    Set Suite Variable       ${NUMBER}                ${number}
    Set Suite Variable       ${COMPLEMENT}            ${complement}
    Set Suite Variable       ${COUNTRY}               Brasil
    
Cadastrar nova empresa
    Gerar Empresa
    ${TOKEN}    Realizar login

    ${body}=    Create Dictionary
    ...    corporateName=${COMPANY_NAME}
    ...    registerCompany=${REGISTER_COMPANY}
    ...    mail=${MAIL}
    ...    matriz=${MATRIZ}
    ...    responsibleContact=${RESPONSIBLE_CONTACT}
    ...    telephone=${TELEPHONE}
    ...    serviceDescription=${SERVICE_DESCRIPTION}
    ...    address=${EMPTY}
    
    ${address_dict}=    Create Dictionary
    ...    zipCode=${ZIPCODE}
    ...    city=${CITY}
    ...    state=${STATE}
    ...    district=${DISTRICT}
    ...    street=${STREET}
    ...    number=${NUMBER}
    ...    complement=${COMPLEMENT}
    ...    country=${COUNTRY}
    
    ${final_ddress_list}=    Create List    ${address_dict}
    Set To Dictionary    ${body}    address=${final_ddress_list}
    
    ${response}    POST On Session    alias=develop    url=/company?token=${TOKEN}    json=${body}    verify=${True}
    Status Should Be    201    ${response}
    Log     ${response.json()}
    Set Suite Variable    ${COMPANY_ID}    ${response.json()['newCompany']['_id']}

Atualizar dados da empresa cadastrado por id
    Gerar Empresa
    ${TOKEN}    Realizar login
        ${body}=    Create Dictionary
    ...    corporateName=${COMPANY_NAME}
    ...    registerCompany=${REGISTER_COMPANY}
    ...    mail=${MAIL}
    ...    matriz=${MATRIZ}
    ...    responsibleContact=${RESPONSIBLE_CONTACT}
    ...    telephone=${TELEPHONE}
    ...    serviceDescription=${SERVICE_DESCRIPTION}
    ...    address=${EMPTY}
    
    ${address_dict}=    Create Dictionary
    ...    zipCode=${ZIPCODE}
    ...    city=${CITY}
    ...    state=${STATE}
    ...    district=${DISTRICT}
    ...    street=${STREET}
    ...    number=${NUMBER}
    ...    complement=${COMPLEMENT}
    ...    country=${COUNTRY}
    
    ${final_ddress_list}=    Create List    ${address_dict}
    Set To Dictionary    ${body}    address=${final_ddress_list}
    
    ${response}    PUT On Session    alias=develop    url=/company/${COMPANY_ID}?token=${TOKEN}    json=${body}    verify=${True}
    Status Should Be    200    ${response}
    ${resp_json}=    Set Variable    ${response.json()}
    Log     ${response.json()}

Deletar empresa cadastrada por id
    ${TOKEN}    Realizar login
    DELETE On Session    alias=develop    url=/company/${COMPANY_ID}?token=${token}    verify=${True}
    
Cadastrar empresa com CNPJ invalido
    Gerar Empresa
    ${TOKEN}    Realizar login

    ${body}=    Create Dictionary
    ...    corporateName=${COMPANY_NAME}
    ...    registerCompany=${REGISTER_COMPANY}abc
    ...    mail=${MAIL}
    ...    matriz=${MATRIZ}
    ...    responsibleContact=${RESPONSIBLE_CONTACT}
    ...    telephone=${TELEPHONE}
    ...    serviceDescription=${SERVICE_DESCRIPTION}
    ...    address=${EMPTY}
    
    ${address_dict}=    Create Dictionary
    ...    zipCode=${ZIPCODE}
    ...    city=${CITY}
    ...    state=${STATE}
    ...    district=${DISTRICT}
    ...    street=${STREET}
    ...    number=${NUMBER}
    ...    complement=${COMPLEMENT}
    ...    country=${COUNTRY}
    
    ${final_ddress_list}=    Create List    ${address_dict}
    Set To Dictionary    ${body}    address=${final_ddress_list}
    
    ${response}    POST On Session    alias=develop    url=/company?token=${TOKEN}    json=${body}    expected_status=400    verify=${True}
    Status Should Be    400    ${response}
    Log     ${response.json()}
    Should Be Equal As Strings    ${response.json()['error'][0]}    O campo 'CNPJ' da empresa deve conter 14 caracteres numéricos.