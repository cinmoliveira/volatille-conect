# VolatileConnect

## Descrição
Aplicação desenvolvida em Dart com o framework Flutter como parte da disciplina de Programação para dispositivos móveis.  O aplicativo apresenta relações entre plantas, seus compostos orgânicos voláteis (COVs) e os insetos atraídos, permitindo o cadastro, visualização e gerenciamento dessas informações de forma interativa.

## Funcionalidades
- Autenticação de usuários (login, cadastro e recuperação de senha)
- Navegação entre telas utilizando rotas nomeadas
- Gerenciamento de plantas (cadastro, edição e exclusão)
- Visualização de detalhes das plantas
- Alternância entre lista e grade
- Tela de referências científicas
- Feedback ao usuário com **SnackBar** e **AlertDialog**
- Controle de navegação e logout

## Funcionamento
- Navegação por rotas nomeadas (`Navigator.pushNamed`)
- Gerenciamento de estado com `ChangeNotifier`
- Controllers responsáveis pela lógica de negócio
- Views responsáveis pela interface
- Operações CRUD em memória
- Feedback ao usuário com dialogs e notificações

## Requisitos Atendidos
- Cadastro de usuário com validação
- Login com verificação de credenciais
- Recuperação de senha
- Tela sobre o projeto
- Funcionalidades específicas:
  - Listagem de plantas
  - Cadastro de plantas
  - Edição de plantas
  - Exclusão com confirmação
  - Visualização de detalhes
  - Tela de referências

## Como Executar

```bash
git clone https://github.com/cinmoliveira/volatileconnect.git
cd volatileconnect
flutter pub get
flutter run
```

## Autora
**Cintia Marcelo de Oliveira**

---

# VolatileConnect

## Description
This application was developed using Dart and Flutter as part of a Mobile development course.  
The app presents relationships between plants, their volatile organic compounds (VOCs), and the insects they attract, allowing users to register, visualize, and manage this information interactively.

## Features
- User authentication (login, registration, password recovery)
- Navigation between screens using named routes
- Plant management (create, edit, delete)
- Visualization of plant details
- List and grid display modes
- Scientific references screen
- Feedback using **SnackBar** and **AlertDialog**
- Logout and navigation control

## How it works
- Navigation handled via named routes (`Navigator.pushNamed`)
- State managed with `ChangeNotifier`
- Controllers centralize business logic
- Views handle UI and interaction
- CRUD operations are performed in-memory
- User feedback via dialogs and notifications

## Author
**Cintia Marcelo de Oliveira** 