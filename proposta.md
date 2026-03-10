Proposta de Projeto - App de Compartilhamento de Livros (Book Swap)

Nome do Aplicativo:

BookSwap

Problema que resolve:

Muitas pessoas têm livros que já leram e não sabem o que fazer com eles. Ao mesmo tempo, outras pessoas podem estar à procura de livros específicos, mas não têm acesso a novos títulos devido ao custo ou à falta de opções. O BookSwap visa resolver esse problema facilitando o compartilhamento ou troca de livros entre usuários, criando uma rede de trocas de maneira prática, segura e acessível.

Público-alvo:

Leitores: Pessoas que gostam de ler e estão sempre em busca de novas histórias, mas não têm recursos para comprar livros novos com frequência.

Estudantes: Que têm uma grande quantidade de livros de texto, acadêmicos e didáticos que podem ser trocados com outros colegas.

Pessoas interessadas em sustentabilidade: Aqueles que desejam promover práticas de reutilização e reduzir o desperdício através da troca de livros usados.

Funcionalidades principais:

Cadastro de Usuário: Os usuários poderão criar uma conta no aplicativo utilizando e-mail e senha, ou login social.

Cadastro de Livros: Usuários poderão adicionar livros ao seu catálogo, com informações como título, autor, categoria e condição (novo, usado, etc.).

Busca e Filtros de Livros: Será possível buscar por livros disponíveis para troca, com filtros por categoria, autor ou título.

Listagem de Livros: Visualização dos livros cadastrados em formato de lista ou grade, com detalhes e fotos.

Sistema de Trocas: Usuários poderão indicar livros que gostariam de trocar e enviar propostas de troca para outros usuários.

Mensagens/Chat: Sistema de mensagens para comunicação entre os usuários, facilitando a negociação de trocas.

Avaliações e Feedback: Usuários poderão avaliar livros e trocar feedback sobre a experiência de troca.

Notificações: Notificações de novas trocas possíveis, mensagens e confirmações de troca.

Recursos técnicos que serão utilizados:

Flutter: Framework principal para desenvolvimento do aplicativo, utilizando a linguagem Dart.

Firebase Authentication: Para gerenciamento de login de usuários (e-mail, senha e login social).

Firebase Firestore: Banco de dados em tempo real para armazenar dados de usuários, livros, trocas e mensagens.

Firebase Cloud Messaging: Para enviar notificações push sobre novas trocas ou mensagens.

Camera (opcional): Para permitir que os usuários adicionem fotos dos livros que estão oferecendo para troca.

Geolocalização (opcional): Para sugerir trocas de livros com usuários próximos, facilitando a entrega dos livros.

Considerações Técnicas e Desafios:

Gerenciamento de estado: O gerenciamento eficiente do estado da aplicação, principalmente para dados em tempo real (livros, trocas, mensagens), será um desafio importante.

Integração com Firebase: A implementação do Firebase Firestore e Firebase Authentication exigirá um bom entendimento da plataforma e das ferramentas de integração com Flutter.

Segurança e privacidade dos dados: Será necessário implementar boas práticas para garantir a segurança dos dados dos usuários, como a autenticação segura e a validação de dados.
