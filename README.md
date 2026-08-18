BookSwap

Sobre o sistema

O BookSwap é um aplicativo desenvolvido em Flutter para facilitar a
troca de livros entre usuários. O sistema permite cadastrar livros para
troca, consultar livros disponíveis, pesquisar por título/autor/gênero,
visualizar detalhes, editar ou remover livros próprios e iniciar uma
proposta de troca pelo chat.

Tecnologias utilizadas

Flutter --- framework da aplicação.

Dart --- linguagem de programação.

Flutter Material --- componentes e interface.

Provider --- gerenciamento de estado com ChangeNotifier,
Consumer e context.watch/read.

GoRouter --- navegação entre telas e passagem de objetos com
extra.

Repository Pattern --- separação entre regras da aplicação e
acesso aos dados.

Form / TextFormField / Validator --- validação dos formulários
de cadastro e autenticação.

Funcionalidades

Usuários

Cadastro de usuário.

Validação de nome, e-mail, senha e confirmação de senha.

Login.

Acesso ao perfil.

Livros

Cadastro de livro.

Validação dos campos obrigatórios.

Lista de livros disponíveis.

Pesquisa por título, autor e gênero.

Filtro por gênero em evolução.

Visualização de detalhes.

Identificação do proprietário.

Edição de livros publicados pelo usuário.

Exclusão com confirmação.

Feedback com SnackBar.

Trocas e chat

Botão Propor troca.

Abertura do chat com o livro selecionado.

Visualização dos detalhes do livro.

Arquitetura

O projeto organiza o código por funcionalidades e separa apresentação,
estado, modelos e acesso aos dados.

book_swap/
├── android/
├── ios/
├── linux/
├── web/
├── windows/
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   ├── services/
│   │   ├── theme/
│   │   └── utils/
│   │
│   ├── data/
│   │   └── repositories/
│   │       ├── auth_repository.dart
│   │       ├── books_repository.dart
│   │       └── user_repository.dart
│   │
│   ├── features/
│   │   ├── auth/
│   │   │   ├── data/
│   │   │   └── presentation/
│   │   ├── books/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   └── models/
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       └── widgets/
│   │   ├── chat/
│   │   └── profile/
│   │
│   ├── providers/
│   │   ├── auth_provider.dart
│   │   ├── book_provider.dart
│   │   └── chat_provider.dart
│   │
│   └── main.dart
│
├── pubspec.yaml
└── README.md

Principais arquivos

lib/providers/book_provider.dart

Controla o estado dos livros. As principais operações são:

loadBooks()
addBook(Book book)
deleteBook(String id)
updateBook(Book book)
setSearch(String value)

A propriedade filteredBooks fornece a lista filtrada para a pesquisa.

lib/data/repositories/books_repository.dart

Centraliza o acesso aos dados dos livros. O Provider utiliza o
repositório para consultar, inserir, atualizar e excluir registros.

lib/features/books/data/models/book.dart

Define o modelo Book, representando os dados de um livro, como título,
autor, gênero, ano, sinopse, proprietário e status.

lib/features/books/presentation/pages/tela_cadastro_livro.dart

Tela responsável pelo cadastro de livros. Os dados preenchidos são
transformados em um objeto Book e enviados para o BookProvider.

lib/features/books/presentation/pages/tela_livros_disponiveis.dart

Exibe a lista de livros e utiliza Consumer<BookProvider> para reagir
às alterações do estado.

lib/features/books/presentation/widgets/livro_card.dart

Widget reutilizável responsável pela apresentação de cada livro e pelas
ações de propor troca, ver detalhes, editar e excluir.

lib/main.dart

Ponto de entrada da aplicação e local de configuração inicial, incluindo
os Providers e a navegação.

Fluxo de cadastro de livro

TelaCadastroLivro
      ↓
criação do objeto Book
      ↓
BookProvider.addBook()
      ↓
BooksRepository.insertBook()
      ↓
BookProvider.loadBooks()
      ↓
TelaLivrosDisponiveis

Fluxo da pesquisa

Usuário digita
      ↓
setSearch()
      ↓
BookProvider atualiza o estado
      ↓
filteredBooks
      ↓
Consumer<BookProvider>
      ↓
LivroCard

A pesquisa compara o texto informado com campos como título, autor e
gênero.

Fluxo de edição

LivroCard
   ↓
onEdit
   ↓
GoRouter
   ↓
/editar-livro + extra: Book
   ↓
BookProvider.updateBook()
   ↓
BooksRepository.updateBook()
   ↓
loadBooks()

Fluxo de exclusão

LivroCard
   ↓
onDelete
   ↓
AlertDialog
   ↓
confirmação
   ↓
BookProvider.deleteBook()
   ↓
BooksRepository.deleteBook()
   ↓
loadBooks()
   ↓
SnackBar

Como executar

Pré-requisitos

Flutter SDK.

Dart SDK, incluído no Flutter.

VS Code ou Android Studio.

Emulador, dispositivo físico ou navegador.

Verifique o ambiente:

flutter doctor

Instalar dependências

Na pasta do projeto:

cd book_swap
flutter pub get

Executar

flutter run

Para executar no Chrome:

flutter run -d chrome

Analisar o projeto

flutter analyze

Testes, quando configurados:

flutter test

Organização das responsabilidades

Telas: interface, entrada de dados e navegação.

Providers: estado da aplicação e chamadas das operações da
funcionalidade.

Repositories: acesso e manipulação dos dados.

Models: representação dos dados do sistema.

Widgets: componentes reutilizáveis da interface.

Essa separação reduz o acoplamento e facilita manutenção e evolução do
aplicativo.

Funcionalidades implementadas

Funcionalidade                  Status

Cadastro de usuário             Implementado
Validação de formulários        Implementado
Login                           Implementado
Cadastro de livros              Implementado
Lista de livros                 Implementado
Pesquisa de livros              Implementado
Detalhes do livro               Implementado
Edição de livros                Implementado
Exclusão de livros              Implementado
Identificação do proprietário   Implementado
Proposta de troca               Implementado
Chat                            Implementado
Provider                        Implementado
GoRouter                        Implementado
Repository                      Implementado

Próximas melhorias

Autenticação e persistência completas de usuários.

Upload real das imagens dos livros.

Filtros avançados.

Sistema de notificações.

Histórico e confirmação de trocas.

Backend/API para sincronização entre dispositivos.

Testes unitários e de integração.

Tratamento mais completo de erros.

Projeto acadêmico

Projeto BookSwap desenvolvido para a disciplina de Sistemas
Móveis.

Tecnologia principal: Flutter / Dart
