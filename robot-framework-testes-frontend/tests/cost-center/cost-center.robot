* Settings *
Resource    ../../resources/login.resource
Resource    ../../resources/common.resource
Resource    ../../resources/cost-center.resource

Suite Setup       Abrir Navegador
Suite Teardown    Fechar Navegador

* Test Cases *
Cenario 01: Editar Centro de Custo
    Realizar Login
    Verificar Redirecionamento Para Home
    Verificar Elemento Cadastros Visivel
    Acessar Pagina Centro de Custo
    Editar Primeiro Centro de Custo