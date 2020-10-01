# movie_flutter
App feito a partir de uma proposta de desafio, com tema e certas ações necessarias definidas previamente.
Para limpar o banco para futuros testes, mudar o nome do arquivo em : 
na classe de serviço que cria o banco  
static final _databaseName = "movies.db";

Há melhorias e refatoração de código a serem feitas após avaliação.

Este app utiliza de um banco relacional SQLite para guardar os favoritos por nome de usuário, portanto, é permitido múltiplas sessões sem login, e cada usuário(nome) terá seus próprios favoritos
Utiliza também da ali Ombd, e realiza pesquisas por nome de filmes/séries e pelo código os do IMDb.
É possível compartilhar certos dados da pesquisa via Share

Utiliza-se gestos para melhor experiencia:
Tap: pesquisas e seleções,
DoubleTap: favoritar,
Longpress: compartilhar nome do filme selecionado,
Swipe/Slide: remover filme favoritado

Para conhecer a aplicação, assista a [demonstração](https://github.com/mportog/movie_flutter/blob/master/demo.mp4?raw=true)

![](https://github.com/mportog/movie_flutter/blob/master/screenshots/user.png)
![](https://github.com/mportog/movie_flutter/blob/master/screenshots/added.png)
![](https://github.com/mportog/movie_flutter/blob/master/screenshots/series.png)
![](https://github.com/mportog/movie_flutter/blob/master/screenshots/favs.png)
![](https://github.com/mportog/movie_flutter/blob/master/screenshots/delete.png)
![](https://github.com/mportog/movie_flutter/blob/master/screenshots/removed.png)
![](https://github.com/mportog/movie_flutter/blob/master/screenshots/details.png)
![](https://github.com/mportog/movie_flutter/blob/master/screenshots/details1.png)
![](https://github.com/mportog/movie_flutter/blob/master/screenshots/share_imdb.png)
