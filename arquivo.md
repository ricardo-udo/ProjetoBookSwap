Prompt para Copilot: Tela Flutter
Contexto:
Estou desenvolvendo um aplicativo em Flutter e preciso criar a interface de uma tela de [NOME DA TELA, ex: Perfil do Usuário / Dashboard Financeiro].

Requisitos de UI:

Layout: Utilize um Scaffold com uma AppBar que contenha o título "[TÍTULO]".

Corpo: Use um SingleChildScrollView com uma Column.

Componentes específicos:

Um CircleAvatar para a foto de perfil no topo.

Três ListTile para opções de configuração (Ícone, Texto e Seta para a direita).

Um ElevatedButton centralizado na parte inferior com o texto "Salvar".

Estilização: Use o Theme.of(context).textTheme para garantir consistência visual e aplique um Padding de 16.0 em toda a tela.

Requisitos Técnicos:

Crie a tela como um StatelessWidget (ou StatefulWidget se houver interação).

Separe os componentes menores em métodos ou widgets privados dentro do mesmo arquivo para manter o código limpo.

Utilize boas práticas de tipagem forte e const onde for possível.

Certifique-se de que o layout seja responsivo usando MediaQuery ou widgets flexíveis.

Saída esperada:
Apenas o código Dart completo para o arquivo [nome_do_arquivo].dart.

Dicas para extrair o melhor do Copilot:
Seja Visual: Se a tela for complexa, descreva de cima para baixo: "Primeiro um Header com gradiente, depois um GridView 2x2, por fim um BottomNavigationBar".

Cite Bibliotecas: Se você usa pacotes específicos (como google_fonts, provider ou flutter_svg), mencione no prompt para que ele já importe e utilize a sintaxe correta.

Refinamento: Após ele gerar o código, você pode selecionar uma parte e pedir: "Adicione um arredondamento de 15px nas bordas deste card" ou "Mude a cor do botão para o padrão Amber do Material Design".