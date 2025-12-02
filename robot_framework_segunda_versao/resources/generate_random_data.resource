*** Settings ***
Documentation    Keywords para geração de dados de teste
Library          DateTime
Library          String
Library          FakerLibrary    locale=pt_BR

*** Keywords ***
Gerar CPF Unico
    [Documentation]    Gera um CPF único usando timestamp
    ${timestamp}=    Get Current Date    result_format=%H%M%S%f
    ${cpf}=    Evaluate    '${timestamp}'[:11].zfill(11)
    RETURN    ${cpf}

Gerar Senha Aleatoria
    [Documentation]    Gera uma senha aleatória válida
    ${randomString}=    Generate Random String    3    [NUMBERS]
    ${senha}=    Set Variable    Test@${randomString}
    RETURN    ${senha}

#EMPRESA E USUARIO
Gerar primeiro nome nao composto
    [Documentation]    Gera primeiro nome nao composto
    ${nome_completo}=    First Name 
    ${nome_simples}=     Split String    ${nome_completo}    ${SPACE}
    ${primeiro_nome}=    Set Variable    ${nome_simples[0]}
    RETURN   ${primeiro_nome}


Gerar ultimo nome nao composto
    [Documentation]    Gera ultimo nome nao composto
    ${nome_completo}=    Last Name 
    ${nome_simples}=     Split String    ${nome_completo}    ${SPACE}
    ${ultimo_nome}=    Set Variable    ${nome_simples[0]}
    ${ultimo_nome_upper}=    Set Variable    ${ultimo_nome[0].upper()}${ultimo_nome[1:]}
    RETURN   ${ultimo_nome_upper}


#EMPRESA    
Gerar nome da empresa
    [Documentation]    Gera o nome de uma empresa 
    ${s_COMPANY_NAME}=   Random Element    elements=('BlueWavex','NextSpherex','QuantumTechx','Innovarex','AlphaSolutionsx','SmartEdgex','GlobalLinkx','VisionaryLabsx','DataCorex','SkylineTechx','FutureWavex','CloudNetx','EcoTechx','BrightPathx','StrongBridgex','UltraCorex','NovaSolutionsx','SkyLineSystemsx','MaxInnovationsx','GreenEdgex','OmniTechx','FastTrackx','PrimeSolutionsx','HyperLinkx','CoreVisionx','SafeSolutionsx','FusionEdgex','TrustSolutionsx','AgroTechx','UrbanEdgex','SmartPathx','InfoCorex','QuickSolutionsx','ProTechx','NextErax','GlobalVisionx','TechInnovatorsx','DataWorksx','BrightEdgex','EliteTechx','ModernSystemsx','SolidSolutionsx','InfinityTechx','AeroVisionx','PowerEdgex','VisionCorex','ConnectSolutions')

    RETURN    ${s_COMPANY_NAME}
    
Gera cnpj da empresa
    [Documentation]    Gera um cnpj valido
    ${randomString}=    Generate Random String    14    [NUMBERS]
    ${matriz}=    Set Variable    ${randomString}
    RETURN    ${matriz}


Gerar sigla do estado
    [Documentation]    Gera a sigla de um estado brasileiro
    ${s_COMPANY_NAME}=   Random Element    elements=('AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO')
    RETURN    ${s_COMPANY_NAME}

Gerar pais Sem Acentos
    [Documentation]    Gera o nome de um país usando FakerLibrary sem acentos
    ${country}=    Country
    ${country_clean}=    Evaluate    __import__('unicodedata').normalize('NFKD', '${country}').encode('ASCII','ignore').decode('ASCII')
    RETURN    ${country_clean}

Gerar telefone sem caracteres especiais
    [Documentation]    Gera um telefone sem caracteres especiais
    ${telephone}=    Phone Number
    ${telephone_clean}=    Evaluate    ''.join(c for c in '${telephone}' if c.isdigit())
    RETURN    ${telephone_clean}

Gerar logradouro sem caracteres especiais
    [Documentation]    Gera um logradouro sem caracteres especiais
    ${street}=    Street Address
    ${street_clean}=    Evaluate    ''.join(c for c in '${street}' if c.isalnum() or c==' ')
    RETURN    ${street_clean}

Gerar cep sem caracteres especiais
    [Documentation]    Gera um cep sem caracteres especiais
    ${zipCode}=    Postcode
    ${zipCode_clean}=    Evaluate    ''.join(c for c in '${zipCode}' if c.isdigit())
    RETURN    ${zipCode_clean}