*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String
Library    FakerLibrary    locale=pt_BR


*** Keywords ***
Gerar Cliente
    [Documentation]    Gera dados de cliente aleatórios através da API 4devs
    
    # Criar sessão com a API 4devs
    ${headers}=    Create Dictionary    Content-Type=application/x-www-form-urlencoded
    Create Session    alias=4devs    url=https://www.4devs.com.br    headers=${headers}    verify=${True}
    
    # Dados para enviar como form data
    ${form_data}=    Create Dictionary
    ...    acao=gerar_pessoa
    ...    sexo=I
    ...    pontuacao=N
    ...    idade=18
    ...    cep_estado=PE
    ...    txt_qtde=1
    ...    cep_cidade=5406
    
    # Fazer requisição POST
    ${response}=    POST On Session    alias=4devs    url=/ferramentas_online.php    data=${form_data}    expected_status=200
    
    # Extrair dados da resposta
    ${pessoa}=    Set Variable    ${response.json()[0]}
    
    # Tratar RG (máximo 7 dígitos)
    ${rg_completo}=    Set Variable    ${pessoa['rg']}
    ${rg_tratado}=    Get Substring    ${rg_completo}    0    7

    # Tratar data de nascimento (remover /)
    ${data_nascimento}=    Set Variable    ${pessoa['data_nasc']}
    ${data_tratada}=    Remove String    ${data_nascimento}    /
    
    # Criar dicionário com os dados do cliente
    ${cliente_dados}=    Create Dictionary
    ...    nome=${pessoa['nome']}
    ...    dataNascimento=${data_tratada}
    ...    email=${pessoa['email']}
    ...    celular=${pessoa['celular']}
    ...    cargo=QA
    ...    rg=${rg_tratado}
    ...    cpf=${pessoa['cpf']}
    ...    cep=${pessoa['cep']}
    ...    pais=Brasil
    ...    cidade=${pessoa['cidade']}
    ...    estado=${pessoa['estado']}
    ...    bairro=${pessoa['bairro']}
    ...    endereco=${pessoa['endereco']}
    ...    numero=${pessoa['numero']}
    ...    complemento=Apartamento 01
        
    RETURN    ${cliente_dados}


Gerar Empresa
    [Documentation]    Gera dados de empresa aleatórios através da API 4devs

    # Criar dicionário com os dados da empresa
    ${empresa_dados}=    Create Dictionary
    ...    razao_social=Rita e Lucas Alimentos ME
    ...    nome_fantasia=Rita e Lucas Alimentos ME
    ...    email=faleconosco@ritaelucasalimentosme.com.br
    ...    cnpj=34575708000192
    ...    telefone=1137497251
    ...    nome_responsavel=joana
    ...    descricao=servicos de tecnologia
    ...    cep=06814275
    ...    pais=Brasil
    ...    estado=SP
    ...    bairro=Jardim Jurema
    ...    rua=Rua Augusto de Almeida Batista
    ...    numero_imovel=177
    ...    complemento=complemento empresa
    ...    cidade=Sao Paulo


    RETURN    ${empresa_dados}

Gerar Departamento Da Lista
    ${departamentos}=    Create List    Financeiro    RH    TI    Vendas    Marketing    Operações
    ${dept}=    FakerLibrary.Random Element    ${departamentos}
    Log    ${dept}
    RETURN    ${dept}

Gerar Nome Centro de Custo
    ${word1}=    FakerLibrary.Word
    ${word2}=    FakerLibrary.Word
    ${costCenterName}=    Catenate    ${word1}    ${word2}
    RETURN    ${costCenterName}