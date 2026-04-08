Análise de Atendimentos da Conta Gov.br

* Objetivo:
Investigar os atendimentos de 2025, garantindo qualidade dos dados e consistência estatística dos seguintes indicadores: 
a) volume de solicitações; 
b) tempo de atendimento.

* Fonte dos dados:
https://dados.gov.br/dados/conjuntos-dados/atendimentos-realizados-na-central-de-atendimento-da-conta-govbr

* Perguntas que orientaram a análise:

Volume de solicitações
1) Qual é a origem de 80% dos atendimentos?
2) Qual é o turno com maior volume de entrada de solicitações?
3) Quais categorias geraram maior volume de solicitações?
4) Quais grupos receberam maior volume de solicitações no ano?
5) Em quanto ficou a taxa de aceitação das solicitações durante o ano de 2025?

Tempo de atendimento
1) Como está a distribuição dos atendimentos em cada faixa de duração?
2) Como está a variação do tempo de atendimento ao longo dos meses?
3) Como está a duração dos atendimentos em cada situação de encerramento?
4) Qual é o turno com maior duração dos atendimentos?
5) Quais são os dias da semana com maior duração mediana de atendimentos?

* Arquitetura de Dados
Pipeline utilizado no projeto:
Dados.gov.br
     ↓
Download CSV mensal
     ↓
Conversão para Parquet
     ↓
Google BigQuery
     ↓
Tabela particionada por mês
     ↓
Amostragem aleatória (SQL)
     ↓
Python (EDA)

* Volume de Dados
Dataset original:
19,67 milhões de registros
* Amostra representativa:
5.000 registros aleatórios por mês
período: 2025

Motivação:
reduzir custo computacional
acelerar análise exploratória
manter representatividade estatística

* Stack Utilizada
Python
Pandas
NumPy
Matplotlib
Seaborn
Google BigQuery
Jupyter Notebook

* Processo de Análise
Etapas realizadas na análise:

1️⃣ Inspeção inicial
estrutura dos dados
tipos de variáveis
estatísticas descritivas

2️⃣ Padronização de colunas
Renomeação para camelCase para manter consistência no projeto.

3️⃣ Tratamento de valores nulos
Foi identificado valor nulo na coluna:
categoriaSolucao
Após investigação foi verificado que o registro tinha origem Chat Online.
Correção aplicada:
categoriaSolucao = "Chat Online > (N1)"

4️⃣ Validação temporal
Foram identificados registros com inconsistência:

encerramento <= atendimentoinicio

Esse tipo de validação é importante para evitar métricas de tempo negativas ou inválidas.

📊 Métricas Criadas
Tempo de atendimento
tempoAtendimento = encerramento - atendimentoinicio

Essa métrica permite calcular:

tempo médio de atendimento
distribuição de tempos
identificação de outliers
📈 Principais Análises

Durante a EDA foram analisados:

Volume de solicitações
por canal de origem
por categoria
por período
Tempo de atendimento
média
mediana
distribuição
presença de outliers
🔎 Objetivo da EDA

Garantir que os dados utilizados para análise:

✔ possuem consistência temporal
✔ possuem categorias válidas
✔ possuem valores completos
✔ permitem geração de métricas confiáveis

🚀 Próximos Passos

Possíveis extensões do projeto:

Dashboard de monitoramento de atendimentos
Análise de SLA de atendimento
Identificação de gargalos operacionais
Análise de volume por canal de atendimento

Ferramenta sugerida:

Looker Studio
👤 Autor

Projeto desenvolvido como parte de portfólio de Análise de Dados.

Foco em:

Data Quality
Análise Exploratória
Preparação de dados para dashboards
