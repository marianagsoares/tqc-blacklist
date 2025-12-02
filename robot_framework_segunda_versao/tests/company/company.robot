*** Settings ***
Documentation     Keywords utilizadas na rota /company
Resource    ../../resources/company.resource

*** Test Cases ***
Cadastrar empresa
    Cadastrar nova empresa

#Listar empresa
     #Listar usuario cadastrado por id

#Listar empresas
    #Listar todas as empresas cadastradas

#Atualizar status da empresa
    #Inativar empresa cadastrada por id

Atualizar dados da empresa
    Atualizar dados da empresa cadastrado por id

Deletar empresa
    Deletar empresa cadastrada por id

Cadastrar empresa com CNPJ inválido
    Cadastrar empresa com CNPJ invalido