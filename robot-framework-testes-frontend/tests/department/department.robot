*** Settings ***
Resource    ../../resources/login.resource
Resource    ../../resources/common.resource
Resource    ../../resources//department.resource

Suite Setup       Abrir Navegador
Suite Teardown    Fechar Navegador

*** Test Cases ***
Cenario 01: Cadastrar departamento
    Realizar Login
    Verificar Redirecionamento Para Home
    Verificar Elemento Cadastros Visivel
    Acessar Pagina Departamentos
    Cadastrar novo departamento