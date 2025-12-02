*** Settings ***
Documentation     Keywords utilizadas na rota /user
Resource    ../../resources/user.resource

*** Test Cases ***
Cadastrar usuario
    Cadastrar novo usuario

Listar usuário
     Listar usuario cadastrado por id

Listar usuários
    Listar todos os usuários cadastrados

#Atualizar status do usuário
#    Inativar usuario cadastrado por id

Atualizar dados do usuário
    Atualizar dados do usuário cadastrado por id

Deletar usuário
    Deletar usuário cadastrado por id

Cadastrar usuário com senha de confirmação diferente
    Cadastrar usuario com confirmacao de senha diferente