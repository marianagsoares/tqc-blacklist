*** Settings ***
Library    SeleniumLibrary
Resource    ../config/dev.robot
Resource    login.resource
Resource    generate_random_data.resource


*** Keywords ***
Acessar Pagina Empresas
    Click Element    id:Cadastros

    Wait Until Element Is Visible    id:Empresas    timeout=10s
    Click Element    id:Empresas

    Wait Until Location Is    ${BASE_URL_UI}/company    timeout=10s
    Location Should Be    ${BASE_URL_UI}/company

    Wait Until Element Is Visible    xpath://h1[text()='Empresas']    timeout=10s
    Element Text Should Be    xpath://h1[text()='Empresas']    Empresas

Cadastrar Nova Empresa  
    Wait Until Element Is Visible    xpath://button[text()='Nova Empresa']    timeout=10s
    Click Button    xpath://button[text()='Nova Empresa']

    Wait Until Element Is Visible    xpath://h5[text()='Novo Cadastro']    timeout=10s
    Element Should Be Visible    xpath://h5[text()='Novo Cadastro']

    Preencher Formulario Empresa
    
    Wait Until Element Is Visible    xpath://button[text()='Salvar']    timeout=10s
    Click Button    xpath://button[text()='Salvar']

    Sleep    10s


Preencher Formulario Empresa
    ${dados_empresa}=    Gerar Empresa
    
    Preencher Razao Social   ${dados_empresa['razao_social']}
    Preencher Nome Fantasia   ${dados_empresa['nome_fantasia']}
    Preencher Email da Empresa    ${dados_empresa['email']}
    Preencher CNPJ   ${dados_empresa['cnpj']}
    Preencher Telefone   ${dados_empresa['telefone']}
    Preencher Nome do Responsavel    ${dados_empresa['nome_responsavel']}
    Preencher Descricao do Servico    ${dados_empresa['descricao']}
    Preencher CEP    ${dados_empresa['cep']}
    Preencher Pais    ${dados_empresa['pais']}
    Preencher Cidade    ${dados_empresa['cidade']}
    Preencher Estado   ${dados_empresa['estado']}
    Preencher Bairro    ${dados_empresa['bairro']}
    Preencher Rua    ${dados_empresa['rua']}
    Preencher Numero do imovel    ${dados_empresa['numero_imovel']}
    Preencher Complemento    ${dados_empresa['complemento']}

Preencher Razao Social
    [Arguments]    ${companyName}
    Wait Until Element Is Visible    id:companyName    timeout=10s
    Input Text    id:companyName    ${companyName}

Preencher Nome Fantasia
    [Arguments]    ${fantasyName}
    Wait Until Element Is Visible    id:fantasyName    timeout=10s
    Input Text    id:fantasyName    ${fantasyName}

Preencher Email da Empresa
    [Arguments]    ${companyMail}
    Wait Until Element Is Visible    id:companyMail    timeout=10s
    Input Text    id:companyMail    ${companyMail}

Preencher CNPJ
    [Arguments]    ${matriz}
    Wait Until Element Is Visible    id:matriz    timeout=10s
    Input Text    id:matriz    ${matriz}

Preencher Telefone
    [Arguments]    ${telephone}
    Wait Until Element Is Visible    id:telephone    timeout=10s
    Input Text    id:telephone    ${telephone}

Preencher Nome do Responsavel
    [Arguments]    ${fullName}
    Wait Until Element Is Visible    id:fullName    timeout=10s
    Input Text    id:fullName    ${fullName}

Preencher Descricao do Servico
    [Arguments]    ${serviceDescription}
    Wait Until Element Is Visible    id:serviceDescription    timeout=10s
    Input Text    id:serviceDescription    ${serviceDescription}

Preencher CEP
    [Arguments]    ${zipCode}
    Wait Until Element Is Visible    id:zipCode    timeout=10s
    Input Text    id:zipCode    ${zipCode}

Preencher Pais
    [Arguments]    ${country}
    Wait Until Element Is Visible    id:country    timeout=10s
    Input Text    id:country    ${country}

Preencher Cidade
    [Arguments]    ${city}
    Wait Until Element Is Visible    id:city    timeout=10s
    Input Text    id:city    ${city}

Preencher Estado
    [Arguments]    ${state}
    Wait Until Element Is Visible    id:state    timeout=10s
    Input Text    id:state    ${state}

Preencher Bairro
    [Arguments]    ${district}
    Wait Until Element Is Visible    id:district    timeout=10s
    Input Text    id:district    ${district}

Preencher Rua
    [Arguments]    ${street}
    Wait Until Element Is Visible    id:street    timeout=10s
    Input Text    id:street    ${street}

Preencher Numero do Imovel
    [Arguments]    ${number}
    Wait Until Element Is Visible    id:number    timeout=10s
    Input Text    id:number    ${number}

Preencher Complemento
    [Arguments]    ${complement}
    Wait Until Element Is Visible    id:complement    timeout=10s
    Input Text    id:complement    ${complement}
