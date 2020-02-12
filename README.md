# movie_flutter
App feito a partir de uma proposta de desafio, com tema e certas ações necessarias definidas previamente.
Para limpar o banco para futuros testes, mudar o nome do arquivo em : 
na classe de serviço que cria o banco  
static final _databaseName = "movies.db";

Há melhorias e refatoração de código a serem feitas após avaliação.

Este app utiliza de um banco relacional SQLite para guardar os favoritos por nome de usuário, portanto, é permitido múltiplas sessões sem login, e cada usuário(nome) terá seus próprios favoritos
Utiliza também da ali Ombd, e realiza pesquisas por nome de filmes/séries e pelo código os do IMDb.
É possível compartilhar certos dados da pesquisa via Share

Utiliza se gestos:
Tap, doubletap, longpress


