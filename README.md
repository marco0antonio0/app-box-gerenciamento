![img](imageReadme/walpaperLogo.png)
O **Box Gerenciamento** é um aplicativo desenvolvido em Flutter para facilitar o gerenciamento de estoque de produtos. Com funcionalidades intuitivas e uma interface amigável, o aplicativo oferece uma solução completa para o controle de produtos, desde a adição até a alteração e exclusão.

## Informações Gerais

- **Nome do App:** Box Gerenciamento
- **Desenvolvido em:** Flutter
- **Persistência de Dados:** SQLite (Sqflite)

## Permissões Necessárias

Para garantir o pleno funcionamento do aplicativo, são necessárias as seguintes permissões:

- **Câmera:** Para utilização de funcionalidades relacionadas à câmera.
- **Armazenamento:** Para acesso e armazenamento de dados no dispositivo.

## Dependências

O projeto utiliza diversas dependências para aprimorar a experiência do usuário e garantir funcionalidades avançadas. Algumas das principais dependências incluem:

- **auto_size_text:** Usada para garantir a responsividade de elementos de texto.
- **device_preview:** Utilizada para testes unitários manuais e identificação de erros relacionados à estética do UI.
- **sqflite:** Responsável pela persistência de dados no SQLite.
- **url_launcher:** Utilizada para navegação para rotas no navegador.
- **get:** Utilizada para o controle de estado do aplicativo.
- **image_picker:** Implementa a funcionalidade de câmera e gerencia permissões relacionadas.
- **flutter_launcher_icons:** Utilizada para implementar o design de ícones do aplicativo.

## Arquitetura

O aplicativo segue a arquitetura em MVC (Model-View-Controller), proporcionando uma organização clara e eficiente do código.

## Funcionalidades Principais

![img](imageReadme/walpaper2.png)

### Página Home

- Lista de produtos com informações detalhadas (foto, título, descrição, valor, quantidade disponível).
- Navegação para a página do produto ao clicar em um item da lista.
- Adição de novos produtos ao estoque.
- Visualização da quantidade total de produtos em estoque.

### Página Produto

- Detalhes do produto, incluindo nome, descrição, data de alteração, data de criação, quantidade disponível em estoque e valor total.
- Botão para acessar a página de alteração do produto.

### Página de Alteração

- Alteração das informações do produto (exceto data de criação e data de atualização).
- Possibilidade de incrementar e decrementar a quantidade em estoque.
- Exclusão do produto.

### Página de Configuração

- Alteração de dados cadastrais do usuário.
- Exclusão de todos os produtos.
- Visualização de informações sobre o aplicativo.

## Topbar

- Acesso rápido à página inicial.
- Acesso ao menu de configurações.
- Identificação do usuário logado.

## Observações

O aplicativo proporciona uma experiência intuitiva e eficiente para o gerenciamento de estoque de produtos, facilitando o controle e a visualização das informações. Em todas as telas, a topbar oferece acesso rápido, garantindo praticidade ao usuário.

Para mais informações sobre o aplicativo, consulte a página de configuração, onde é possível realizar alterações nos dados cadastrais do usuário, excluir todos os produtos e obter informações detalhadas sobre o aplicativo.

## Components contruido e reutilizaveis em diversas parte do app

Components utilizados e organizados em :

```
projeto/lib/components
```

![img](imageReadme/COMPONENTS.png)

---

**Desenvolvido por [Marco Antonio](https://github.com/marco0antonio0)**
