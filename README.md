# Ambiente
O sistema foi desenvolvido em Delphi versão Tokyo utilizando os componentes nativos da IDE.
Para alguns computadores, será necessário ter as dlls libeay32.dll e ssleay32.dl na pasta do executável, pois sem elas pode ocorrer falhas de comunicação http.

# Aplicação
![GerenciadorDownloads](https://user-images.githubusercontent.com/65925299/167486998-86af00f8-8be8-4403-b0c5-b84f0543cf6b.PNG)

O Objetivo desta aplicação é baixar um arquivo via HTTP informando um link/url e gravar os dados referente ao download em uma tabela do banco de dados SQLite.

# Conceitos utilizados
Orientação a objetos

SOLID

Clean Code

Boas práticas de tratamento de exceção

Processamento multithread

Download via HTTP request 

Os dados dos downloads serão armazenados em um banco SQLite com a seguinte estrutura:

![image](https://user-images.githubusercontent.com/65925299/167486067-ceb84095-81df-4ed2-af05-da3332fe8eba.png)


# User Stories
DADO que acesso o sistema
E informo o link para download,
QUANDO clico no botão “Iniciar Download”,
ENTÃO o sistema inicia o download
E consigo visualizar seu progresso até sua finalização.

DADO que acesso o sistema
E possuo um download em andamento,
QUANDO clico no botão “Exibir mensagem”,
ENTÃO o sistema exibe uma mensagem com a % atual de download.

DADO que acesso o sistema
E possuo um download em andamento,
QUANDO clico no botão “Parar download”,
ENTÃO o sistema interrompe o download do arquivo.

DADO que acesso o sistema
E possuo um download em andamento,
QUANDO clico para fechar o sistema,
ENTÃO o sistema exibe a mensagem “Existe um download em andamento, deseja interrompe-lo? [Sim, Não]”.

DADO que acesso o sistema
QUANDO clico no botão“Exibir histórico de downloads”,
ENTÃO o sistema abre uma nova tela
E exibe o histórico de downloads realizados, com suas URL’s e suas respectivas datas de inícioe fim.
