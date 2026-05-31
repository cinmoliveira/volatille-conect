# VolatileConnect

## Descrição
Aplicação desenvolvida em Dart com o framework Flutter como parte da disciplina de Programação para dispositivos móveis.  O aplicativo apresenta relações entre plantas, seus compostos orgânicos voláteis (COVs) e os insetos atraídos, permitindo o cadastro, visualização e gerenciamento dessas informações de forma interativa. O projeto utiliza serviços do Google Firebase para autenticação, armazenamento de dados e hospedagem, além do consumo da API pública Pexels para obtenção dinâmica de imagens das plantas cadastradas.

# Tecnologias Utilizadas

* Flutter SDK
* Dart
* Firebase Authentication
* Firebase Cloud Firestore
* Firebase Hosting
* API REST Pexels
* FutureBuilder
* StreamBuilder
* Async/Await

# Funcionalidades

* Autenticação de usuários (login, cadastro, recuperação de senha e logout)
* Armazenamento de usuários utilizando Firebase Authentication e Cloud Firestore
* Gerenciamento de plantas (cadastro, edição, exclusão e recuperação de dados)
* Pesquisa de plantas por nome comum, nome científico, categoria, compostos e insetos relacionados
* Consumo da API Pexels para obtenção dinâmica de imagens das plantas
* Visualização detalhada das plantas e seus compostos orgânicos voláteis (COVs)
* Exibição de dados em tempo real utilizando StreamBuilder
* Consumo de serviços assíncronos utilizando FutureBuilder, async e await
* Navegação entre telas utilizando rotas nomeadas
* Alternância entre visualização em lista e grade
* Tela de referências científicas
* Feedback ao usuário através de SnackBar e AlertDialog
* Controle de sessão e logout seguro
* Publicação da aplicação utilizando Firebase Hosting
  
## Funcionamento

* Navegação por rotas nomeadas (`Navigator.pushNamed`)
* Gerenciamento de estado com `ChangeNotifier`
* Controllers responsáveis pela lógica de negócio
* Views responsáveis pela interface do usuário
* Integração com Firebase Authentication para cadastro, login, recuperação de senha e logout
* Integração com Firebase Cloud Firestore para armazenamento e recuperação de dados
* Operações CRUD (Create, Read, Update e Delete) nas coleções de usuários e plantas
* Recuperação de dados em tempo real utilizando `StreamBuilder`
* Consumo de API REST pública (Pexels) para obtenção dinâmica de imagens das plantas
* Utilização de `FutureBuilder` para carregamento assíncrono de imagens provenientes da API
* Utilização de `async` e `await` para chamadas assíncronas
* Pesquisa de plantas por nome comum, nome científico, categoria, compostos orgânicos voláteis e insetos relacionados
* Ordenação dos resultados da pesquisa
* Alternância entre visualização em lista e grade
* Visualização detalhada das plantas e seus compostos orgânicos voláteis
* Tela de referências científicas
* Feedback ao usuário através de `SnackBar` e `AlertDialog`
* Controle de sessão e logout seguro
* Publicação da aplicação na Web utilizando Firebase Hosting

## Requisitos Atendidos

* Cadastro de usuário com validação
* Login com verificação de credenciais
* Recuperação de senha
* Armazenamento de usuários utilizando Firebase Authentication
* Armazenamento de informações complementares dos usuários no Firebase Cloud Firestore
* Tela sobre o projeto

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

Application developed in Dart using the Flutter framework as part of the Mobile Application Development course. The application presents relationships between plants, their volatile organic compounds (VOCs), and attracted insects, allowing users to register, view, and manage this information interactively.

The project uses Google Firebase services for authentication, data storage, and hosting, as well as the public Pexels API for dynamically retrieving images of registered plants.

# Technologies Used

* Flutter SDK
* Dart
* Firebase Authentication
* Firebase Cloud Firestore
* Firebase Hosting
* Pexels REST API
* FutureBuilder
* StreamBuilder
* Async/Await

# Features

* User authentication (login, registration, password recovery, and logout)
* User data storage using Firebase Authentication and Cloud Firestore
* Plant management (create, edit, delete, and retrieve data)
* Plant search by common name, scientific name, category, compounds, and related insects
* Pexels API integration for dynamic plant image retrieval
* Detailed visualization of plants and their volatile organic compounds (VOCs)
* Real-time data display using StreamBuilder
* Asynchronous service consumption using FutureBuilder, async, and await
* Navigation between screens using named routes
* Toggle between list and grid views
* Scientific references screen
* User feedback through SnackBar and AlertDialog
* Secure session management and logout
* Application deployment using Firebase Hosting

## Application Architecture

* Navigation using named routes (`Navigator.pushNamed`)
* State management with `ChangeNotifier`
* Controllers responsible for business logic
* Views responsible for the user interface
* Firebase Authentication integration for registration, login, password recovery, and logout
* Firebase Cloud Firestore integration for data storage and retrieval
* CRUD operations (Create, Read, Update, Delete) on users and plants collections
* Real-time data retrieval using `StreamBuilder`
* Public REST API consumption (Pexels) for dynamic plant image retrieval
* Use of `FutureBuilder` for asynchronous image loading
* Use of `async` and `await` for asynchronous requests
* Plant search by common name, scientific name, category, volatile organic compounds, and related insects
* Search result ordering
* Toggle between list and grid layouts
* Detailed visualization of plants and their volatile organic compounds
* Scientific references screen
* User feedback through `SnackBar` and `AlertDialog`
* Secure session control and logout
* Web application publishing using Firebase Hosting

## Requirements Implemented

* User registration with validation
* Login with credential verification
* Password recovery
* User storage using Firebase Authentication
* Storage of additional user information in Firebase Cloud Firestore
* About project screen

### Specific Features

* Real-time plant listing using StreamBuilder
* Plant registration in Firebase Cloud Firestore
* Plant editing
* Plant deletion with confirmation dialog
* Plant details visualization
* Search by common name
* Search by scientific name
* Search by category
* Search by volatile organic compounds
* Search by related insects
* Search result ordering
* Automatic Firestore data retrieval
* Public Pexels REST API consumption
* Dynamic image retrieval based on the plant scientific name
* Asynchronous image rendering using FutureBuilder
* Async and await API calls
* Scientific references screen
* Secure session control and logout
* Application deployment using Firebase Hosting

## How to Run

```bash
git clone https://github.com/cinmoliveira/volatileconnect.git
cd volatileconnect
flutter pub get
flutter run
```

## Author
**Cintia Marcela Oliveira**
