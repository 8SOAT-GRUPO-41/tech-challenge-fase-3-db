# 8SOAT FIAP Tech Challenge | Grupo 41 | Database

## Infraestrutura como Código (IaC)

Este projeto utiliza Terraform para gerenciar a infraestrutura. Os arquivos de configuração do Terraform estão localizados no diretório `infra`. Os principais componentes incluem:

- **VPC e Subnets**: Definidas utilizando fontes de dados para buscar informações de VPC e subnets existentes.
- **Grupos de Segurança**: Gerenciados utilizando um módulo localizado em `infra/modules/aws/security_group`.
- **Instância RDS**: Gerenciada utilizando um módulo localizado em `infra/modules/aws/rds`.

### Arquivos Principais

- `infra/main.tf`: Arquivo principal de configuração do Terraform.
- `infra/variables.tf`: Define as variáveis utilizadas na configuração do Terraform.
- `infra/provider.tf`: Configura o provider do Terraform.
- `infra/outputs.tf`: Define os outputs da configuração do Terraform.

## Migrações com Flyway

O Flyway é utilizado para gerenciar as migrações do banco de dados. Os scripts de migração estão localizados no diretório `migrations`. O script inicial de migração é `V1__init.sql`, que configura o esquema do banco de dados.

### Arquivos Principais

- `migrations/V1__init.sql`: Script inicial de migração para criar o esquema do banco de dados.

## Pipeline de Deploy

O pipeline de deploy é definido utilizando GitHub Actions. O pipeline está configurado em `.github/workflows/deploy-and-migrate.yml`. Ele inclui os seguintes jobs:

- **Terraform**: Este job gerencia as operações do Terraform, incluindo formatação, inicialização, validação, planejamento e aplicação da configuração.
- **DB Migrate**: Este job executa as migrações do Flyway após o passo de aplicação do Terraform.

### Arquivos Principais

- `.github/workflows/deploy-and-migrate.yml`: Arquivo de workflow do GitHub Actions.

### Etapas

1. **Job Terraform**:

   - **Checkout**: Faz o checkout do repositório.
   - **Configurar Terraform**: Configura o CLI do Terraform.
   - **Formatar Terraform**: Verifica o formato dos arquivos Terraform.
   - **Inicializar Terraform**: Inicializa o Terraform.
   - **Validar Terraform**: Valida a configuração do Terraform.
   - **Planejar Terraform**: Cria um plano de execução.
   - **Atualizar Pull Request**: Atualiza o pull request com o plano do Terraform.
   - **Aplicar Terraform**: Aplica a configuração do Terraform se estiver no branch `main`.

2. **Job DB Migrate**:
   - **Checkout do Código**: Faz o checkout do repositório.
   - **Executar Migrações do Flyway**: Executa as migrações utilizando o CLI do Flyway.

## Secrets

Os seguintes segredos são utilizados no workflow do GitHub Actions:

- `TF_API_TOKEN`: Token da API do Terraform Cloud.
- `GITHUB_TOKEN`: Token do GitHub para atualizar pull requests.
- `DB_HOST`: Host do banco de dados.
- `DB_PORT`: Porta do banco de dados.
- `DB_NAME`: Nome do banco de dados.
- `DB_USER`: Usuário do banco de dados.
- `DB_PASSWORD`: Senha do banco de dados.
