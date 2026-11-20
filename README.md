# 👻 Phantom Assistant

> Um assistente de IA pessoal que roda na sua máquina: privado, local e feito em Flutter.

O **Phantom** conversa com modelos locais (via [Ollama](https://ollama.com)), guarda o contexto do que você diz e, aos poucos, ganha voz, memória e a capacidade de acionar outras IAs. A ideia é ter um assistente que fica nas sombras e aparece quando você chama.

> ⚠️ **Status:** em desenvolvimento inicial. Muita coisa abaixo ainda está no plano, e o roadmap mostra o que já funciona.

---

## ✨ Ideia do projeto

- **Local primeiro:** os modelos rodam no seu Mac, sem enviar suas conversas para a nuvem.
- **Interface organizada:** chat limpo, histórico e controle do que o modelo mostra (inclusive ligar e desligar o modo de pensar).
- **Memória e contexto:** guarda o que você fala e busca os trechos relevantes quando precisar.
- **Múltiplas IAs:** além dos modelos locais, poderá usar Claude, GPT e outros por API, escolhendo o provedor por tarefa.
- **Voz:** falar com o assistente e ouvir as respostas.

## 🧰 Stack

| Camada | Tecnologia |
| --- | --- |
| App | Flutter (desktop macOS) |
| Modelos locais | Ollama (ex.: Qwen, Llama) |
| Dados locais | SQLite com drift |
| Estado | Riverpod |
| Chaves de API | Keychain do macOS (`flutter_secure_storage`) |
| Nativo (se necessário) | Plugins em Swift |

## 📦 Requisitos

- macOS
- [Flutter](https://docs.flutter.dev/get-started/install) instalado (com suporte a desktop macOS)
- [Ollama](https://ollama.com/download) instalado e rodando
- Pelo menos um modelo baixado. Para começar com pouca memória (8GB de RAM), um modelo pequeno basta, por exemplo:

```bash
ollama pull qwen3.5:4b
```

## 🚀 Como rodar

```bash
# 1. Clone o repositório
git clone https://github.com/SEU-USUARIO/phantom-assistant.git
cd phantom-assistant

# 2. Instale as dependências
flutter pub get

# 3. Gere o código (drift, Riverpod etc.)
dart run build_runner build --delete-conflicting-outputs

# 4. Rode no macOS
flutter run -d macos
```

> 💡 Se o app não conseguir falar com o Ollama, confira se o arquivo de entitlements do macOS (`macos/Runner/DebugProfile.entitlements` e `Release.entitlements`) tem a permissão `com.apple.security.network.client` ativada.

## 🏗️ Arquitetura

Organização por funcionalidade, com camadas leves (UI → ViewModel → Repository → Service):

```
lib/
  core/            # utilitários, erros, constantes, tema
  features/
    chat/          # ui, view_model, data
    memory/        # notas, embeddings, busca
    settings/      # modelo, chaves, modo de pensar
    voice/         # entrada e saída de voz
  providers/       # AiProvider e implementações (ollama, anthropic, openai)
  router/          # roteador de tarefas entre provedores
```

Princípios principais:

- **`AiProvider` único:** cada IA (local ou online) implementa a mesma interface e devolve um stream de eventos (`Thinking`, `Content`, `Done`, `Error`), então trocar de modelo não muda a interface.
- **Capacidades por provedor:** a interface mostra ou esconde controles (como o modo de pensar) conforme o que o modelo suporta.
- **Dados só pelo Repository:** a camada de apresentação nunca fala direto com o banco ou com a rede.
- **Serviços nativos atrás de interfaces:** microfone, atalhos e Keychain ficam abstraídos, para trocar por plugins em Swift quando for preciso.

## 🗺️ Roadmap

O projeto evolui em versões, com nome de evolução do Pokémon:

- [ ] **v0.1 · Gastly:** chat com o Ollama, streaming, botão de modo de pensar, histórico salvo
- [ ] **v0.2 · Haunter:** memória e contexto (embeddings e busca), entrada e saída de voz
- [ ] **v0.3 · Gengar:** roteador e agentes, integração com Claude e GPT por API

## 🔒 Privacidade

- Conversas, memória e gravações ficam **só na sua máquina**.
- Esses dados **não são versionados** (veja o `.gitignore`).
- Chaves de API ficam no Keychain do macOS, nunca no código ou no repositório.

## 🤝 Contribuindo

É um projeto pessoal, mas sugestões e issues são bem-vindas. Se for abrir um pull request, mantenha o estilo do código e rode `flutter analyze` e `flutter test` antes.

## ⚖️ Aviso

Projeto de fã e sem fins lucrativos, **sem afiliação com a Nintendo, The Pokémon Company ou Game Freak**. Pokémon e Gengar são marcas de seus respectivos donos.

## 📄 Licença

Distribuído sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

---

Feito com 💜 por [Rocket Systems](https://rocketsystems.com.br).
