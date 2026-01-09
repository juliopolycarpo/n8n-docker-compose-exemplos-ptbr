# 🚀 n8n Docker Compose - Exemplos em Português

<p align="center">
  <img src="https://n8n.io/n8n-logo.png" alt="n8n logo" width="200"/>
</p>

<p align="center">
  <strong>Coleção de exemplos prontos de Docker Compose para instalação do n8n</strong>
</p>

<p align="center">
  <a href="#-sobre-o-projeto">Sobre</a> •
  <a href="#-exemplos-disponíveis">Exemplos</a> •
  <a href="#-como-usar">Como Usar</a> •
  <a href="#-contribuindo">Contribuindo</a>
</p>

---

## 📖 Sobre o Projeto

Este repositório contém **exemplos prontos e documentados** de configurações Docker Compose para instalar o [n8n](https://n8n.io) - uma poderosa ferramenta de automação de workflows.

### Por que usar este repositório?

- ✅ **Configurações prontas para uso** - Apenas clone, configure e execute
- ✅ **Documentação em Português** - Instruções claras e objetivas
- ✅ **Múltiplas opções** - Do básico ao avançado, escolha a que melhor se adapta às suas necessidades
- ✅ **Boas práticas** - Configurações otimizadas e seguras

---

## 📦 Exemplos Disponíveis

| Exemplo | Descrição | Complexidade |
|---------|-----------|--------------|
| [`n8n-sqlite`](./n8n-sqlite/) | Instalação básica com SQLite | ⭐ Iniciante |

> 📝 **Nota:** Mais exemplos serão adicionados em breve! Fique de olho nas atualizações.

---

## 🚀 Como Usar

### Pré-requisitos

- [Docker](https://docs.docker.com/get-docker/) instalado
- [Docker Compose](https://docs.docker.com/compose/install/) instalado

### Passos Básicos

1. **Clone o repositório:**
   ```bash
   git clone https://github.com/seu-usuario/n8n-docker-compose-exemplos-ptbr.git
   cd n8n-docker-compose-exemplos-ptbr
   ```

2. **Escolha um exemplo e entre na pasta:**
   ```bash
   cd n8n-sqlite
   ```

3. **Configure as variáveis de ambiente:**
   ```bash
   cp .env.example .env
   # Edite o arquivo .env com suas configurações
   ```

4. **Inicie o n8n:**
   ```bash
   docker compose up -d
   ```

5. **Acesse o n8n:**
   ```
   http://localhost:5678
   ```

---

## 🛠️ Estrutura do Projeto

```
n8n-docker-compose-exemplos-ptbr/
├── n8n-sqlite/                 # Exemplo básico com SQLite
│   ├── docker-compose.yaml
│   ├── .env.example
│   └── README.md
└── README.md
```

---

## 📚 Documentação Adicional

- [Documentação Oficial do n8n](https://docs.n8n.io/)
- [Fórum da Comunidade n8n](https://community.n8n.io/)
- [GitHub do n8n](https://github.com/n8n-io/n8n)

---

## 🤝 Contribuindo

Contribuições são bem-vindas! Se você tem um exemplo de configuração que gostaria de compartilhar:

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/novo-exemplo`)
3. Commit suas mudanças (`git commit -m 'Adiciona exemplo com XYZ'`)
4. Push para a branch (`git push origin feature/novo-exemplo`)
5. Abra um Pull Request

---

## � Créditos e Agradecimentos

Este projeto é possível graças às seguintes tecnologias e comunidades:

### n8n - Automação de Workflows

<a href="https://n8n.io">
  <img src="https://img.shields.io/badge/n8n-Workflow%20Automation-orange?style=for-the-badge&logo=n8n" alt="n8n"/>
</a>

- **Website:** [n8n.io](https://n8n.io)
- **Repositório:** [github.com/n8n-io/n8n](https://github.com/n8n-io/n8n)
- **Licença:** [Sustainable Use License](https://github.com/n8n-io/n8n/blob/master/LICENSE.md) / [n8n Enterprise License](https://github.com/n8n-io/n8n/blob/master/LICENSE_EE.md)
- **Descrição:** Plataforma de automação de workflows extensível, que permite conectar qualquer serviço a qualquer outro

### Docker

<a href="https://www.docker.com">
  <img src="https://img.shields.io/badge/Docker-Container%20Platform-blue?style=for-the-badge&logo=docker" alt="Docker"/>
</a>

- **Website:** [docker.com](https://www.docker.com)
- **Documentação:** [docs.docker.com](https://docs.docker.com)
- **Licença:** [Apache License 2.0](https://github.com/moby/moby/blob/master/LICENSE)
- **Descrição:** Plataforma para desenvolvimento, envio e execução de aplicações em containers

### Comunidade

- **Comunidade n8n:** [community.n8n.io](https://community.n8n.io) - Fórum oficial para dúvidas e discussões
- **Discord n8n:** Canal da comunidade para suporte em tempo real

> ⚠️ **Nota:** Este repositório contém apenas arquivos de configuração Docker Compose. O software n8n é propriedade da [n8n GmbH](https://n8n.io) e está sujeito aos seus próprios termos de licenciamento.

---

## �📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---
