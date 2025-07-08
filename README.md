# 🧠 Sentia

Sentia é um aplicativo iOS desenvolvido inteiramente em SwiftUI com Combine, utilizando arquitetura MVVM e sem dependências externas. Seu objetivo é oferecer uma experiência nativa, leve e objetiva de acompanhamento emocional, conectando emoções a mensagens empáticas geradas por IA.

## 📱 Sobre o Projeto

O Sentia permite que o usuário:

- Escolha como está se sentindo a partir de categorias de emoções.
- Visualize uma mensagem de resposta empática gerada com IA (OpenAI).
- Salve essa conversa em um diário local.
- Consulte esse diário com os registros anteriores.

## 🎯 Objetivos Técnicos

O projeto foi desenhado com o propósito de demonstrar:

- ✅ Uso moderno de **SwiftUI** com animações e navegação declarativa.
- ✅ Utilização de **Combine** para comunicação entre ViewModel e View.
- ✅ Arquitetura **MVVM** bem definida.
- ✅ Chamadas de rede com **URLSession** e tratamento de erros.
- ✅ Persistência local com **FileManager**.
- ✅ Testes unitários cobrindo os principais fluxos.
- ✅ Organização por **Feature Modules** (`Features/Conversation`, `Features/Diary`, etc).
- ✅ Separação clara entre camadas: Model, Service, ViewModel, View.

## 🧪 Cobertura de Testes

O projeto inclui testes unitários robustos utilizando o framework `XCTest`.

- ✅ A cobertura atual está em **69%** do bundle `Sentia.app`.
- ✅ **100% de cobertura** nos principais arquivos de lógica de negócio e `ViewModel`s.
- ⚠️ As `Views` em `SwiftUI` **ainda não foram testadas**, por decisão de não incluir bibliotecas externas como `ViewInspector`.

### ✅ O que já testamos
- Fluxos assíncronos com Combine e URLSession.
- Persistência local com FileManager.
- Casos de erro e sucesso nas camadas de serviço.
- Salvamento e remoção de entradas no diário emocional.

### 🔄 O que podemos fazer para aumentar a cobertura:
- ✔️ Testar a camada de `View` usando [`ViewInspector`](https://github.com/nalexn/ViewInspector).
- ✔️ Criar mais testes que verifiquem interações visuais e de navegação.
- ✔️ Simular cenários de falha no carregamento e na persistência.

## 🔐 Segredos e Chaves de API

Para que o projeto funcione corretamente, você **precisa criar o seguinte arquivo**:

### `Secrets/Secret.plist`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
 "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>OPENAI_API_KEY</key>
    <string>sua_chave_aqui</string>
</dict>
</plist>
```

Esta chave é utilizada para realizar chamadas à API da OpenAI, responsável por gerar as respostas empáticas com base nas emoções selecionadas pelo usuário.

## 🧠 Uso de Inteligência Artificial no Desenvolvimento

A IA (ChatGPT) foi utilizada ativamente durante o desenvolvimento do projeto, tanto para acelerar decisões arquiteturais quanto para refatorações e melhorias. Exemplos de prompts usados:

- *"Me ajude a criar um ViewModel com Combine e SwiftUI que trate loading, erro e resposta de uma chamada async com URLSession."*
- *"Como criar uma animação de label com fade-in e fade-out em SwiftUI após salvar um item?"*
- *"Me dê exemplos de testes unitários para ViewModel que chama um serviço assíncrono com Combine."*

## 🗂 Estrutura do Projeto

Organizado em camadas por **feature**:

```
Sentia/
├── App/
├── Features/
│   ├── Conversation/
│   ├── Diary/
│   ├── Home/
│   └── Splash/
├── Root/
├── Shared/
├── Resources/
└── Secrets/
```

## 🛠 Tecnologias e Recursos Utilizados

| Tecnologia | Finalidade |
|------------|------------|
| SwiftUI | Interface declarativa |
| Combine | Binding reativo entre ViewModel e View |
| URLSession | Chamadas HTTP sem dependências externas |
| FileManager | Persistência local sem CoreData |
| XCTest | Testes unitários |
| Swift Package Manager | Gerenciamento nativo de dependências (não utilizado neste projeto por simplicidade) |

## 🚀 Execução

Para rodar o projeto:

1. Clone o repositório
2. Crie o arquivo `Secrets/Secret.plist` com sua chave da OpenAI
3. Compile o projeto com um simulador ou dispositivo real (iOS 17+ recomendado)

## 👨‍💻 Autor

Desenvolvido por **Rafael Rezende Machado** em julho de 2025 como parte de uma entrega técnica para processo seletivo de iOS Specialist.
