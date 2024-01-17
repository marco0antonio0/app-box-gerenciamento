![img](/imageReadme/walpaperLogo2.png)

# App Box-Gerenciamento

Este é um aplicativo de gerenciamento de estoque desenvolvido em Flutter, seguindo o padrão arquitetural MVC (Model-View-Controller). Abaixo estão detalhes sobre a estrutura de pastas do projeto:

## Estrutura de Pastas

### `lib/pages/`

![img](/imageReadme/walpaper2.png)
Contém classes `StatefulWidget` que declaram e organizam os componentes construídos. Essa pasta é responsável por armazenar as páginas do aplicativo. Cada página representa uma parte funcional ou uma visualização específica do aplicativo.

### `lib/components/`

![img](/imageReadme/COMPONENTS.png)

A pasta `components` abriga classes `StatefulWidget` e `StatelessWidget`, além de funções para construir widgets personalizáveis e reutilizáveis. Esses componentes podem receber parâmetros personalizados para se adaptarem a diferentes contextos e funcionalidades.

### `lib/animations/`

A pasta `animations` contém funções que descrevem métodos de navegação de tela. Essas funções são projetadas para serem reutilizáveis e acionadas em diferentes partes do aplicativo. Elas ajudam na transição suave entre telas.

### `lib/model/`

#### `EstoqueDatabase.dart`

Contém a classe `EstoqueDatabase`, que é um singleton. Essa classe é responsável por estabelecer conexão ou criar o banco de dados. Além disso, fornece funções CRUD (Create, Read, Update, Delete) para serem reutilizadas em diferentes partes do aplicativo.

#### `Demais`

Esta pasta abriga funções responsáveis pela gestão do estado de variáveis. Essas funções ajudam a manter um estado consistente e reativo no aplicativo, seguindo o padrão MVC.

### `images/`

É o diretório onde estão armazenadas as imagens utilizadas no aplicativo. Elas podem ser referenciadas e utilizadas nos diferentes componentes e páginas.

## Padrão de Desenvolvimento - MVC (Model-View-Controller)

O aplicativo Box-Gerenciamento adota a arquitetura MVC para garantir uma separação clara entre a lógica de negócios, a apresentação e o controle do aplicativo:

Este README fornece uma visão geral da estrutura e do padrão de desenvolvimento adotado no aplicativo Box-Gerenciamento. Consulte o código-fonte para obter detalhes específicos sobre as implementações em cada diretório e classe.

---

**Desenvolvido por [Marco Antonio](https://github.com/marco0antonio0)**
