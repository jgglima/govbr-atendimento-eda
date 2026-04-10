# Análise de Atendimentos da Conta Gov.br

## Objetivo:
Disponibilizar os dados em cloud para ingestão mensal e investigar os atendimentos de 2025, garantindo qualidade dos dados e consistência estatística dos seguintes indicadores: 
a) volume de solicitações; 
b) tempo de atendimento.

## Fonte dos dados:
https://dados.gov.br/dados/conjuntos-dados/atendimentos-realizados-na-central-de-atendimento-da-conta-govbr

## Perguntas que orientaram a análise:
### Volume de solicitações
1) Qual é a origem de 80% dos atendimentos?
2) Qual é o turno com maior volume de entrada de solicitações?
3) Quais categorias geraram maior volume de solicitações?
4) Quais grupos receberam maior volume de solicitações no ano?
5) Em quanto ficou a taxa de aceitação das solicitações durante o ano de 2025?

#### Conclusões
* 99,86% das solicitações têm origem em Facematch. Esta é a origem de acesso por reconhecimento facial e serve para Prova de Vida do INSS, elevar o nível da conta para Prata ou Ouro e Acesso Seguro. Por ser o meio principal de acesso, essa distribuição é esperada.
* 41,78% das solicitações são abertas no turno da tarde.
* A categoria com maior densidade foi "Triagem Login Únixo "Central de Serviços - Login Único > Triagem Login Único" e "Triagem Login Único", com 66,41% e 33,27%, respectivamente, somando 99,68% das solicitações do ano. Essas categorias representam o mesmo tipo de atendimento. Durante o ano houve mudança de nomenclatura.
* O grupo com maior densidade de demanda foi Login Único – 1º e 2° Nível, correspondendo a 99,75% das solicitações do ano
* A taxa de aceitação de solicitações teve média de 73,88% em 2025. Considerando o volume da base, temos uma taxa alta
de rejeições e atendimentos encerrados sem aceitação.

### Tempo de atendimento
1) Como está a distribuição dos atendimentos em cada faixa de duração?
2) Como está a variação do tempo de atendimento ao longo dos meses?
3) Como está a duração dos atendimentos em cada situação de encerramento?
4) Qual é o turno com maior duração dos atendimentos?
5) Quais são os dias da semana com maior duração mediana de atendimentos?

#### Conclusões
* A grande maioria dos atendimentos está distribuida na faixa de duração de 0 a 10h.
* A duração dos atendimentos tem alta variabilidade, com cauda longa à direita. Como não obtive acesso ao grau de complexidade dos atendimentos ou registros de erros na plataforma, optei por não remover outliers. 
Os valores extremos foram tratados como parte do comportamento do processo, sendo analisados separadamente como atendimentos de alta duração. Utilizei medidas estatísticas como mediana e percentis para melhor representação da distribuição.
* Os meses de agosto e do último trimestre apresentaram aumento significativo na mediana de duração dos atendimentos e na quantidade de outliers.
* 50% dos atendimentos são > 0 dias 00:13:10 <= 2 days 15:56:45. 1% dos atendimentos duraram mais 6 dias 15:32:07.

## Pipeline:
- Download CSV mensal
- Conversão para Parquet com Python
- Envio para o BigQuery via Google Cloud API
- Full Load em tabela particionada por mês
- Amostragem aleatória (SQL)
- Python (EDA)

## Amostragem
- Volume de Dados
- Dataset original: 19,67 milhões de registros
- Amostra representativa: 5.000 registros aleatórios por mês
- Motivação:
Reduzir custo computacional e acelerar análise exploratória, mantendo representatividade estatística

## Stack Utilizada
### Python (VS Code) / Jupyter Notebook
- Pandas, NumPy, Matplotlib, Seaborn, PyArrow
### Google Cloud
- Google BigQuery, Google Cloud API 

 Processo de Análise
Etapas realizadas na análise:
1. Descrição dos dados e verificação de types
2. Padronização de nomes das variáveis em camelCase
3. Verificação de dados nulos
4. Cálculo de variáveis: duração do atendimento, turnos de atendimento (manhã, tarde e noite), dias da semana.
5. Análise de outliers
6. Categorizei os atendimentos por quartis de duração para melhor visualização dos dados.
- Rápido: até o quartil 0.25
- Padrão: entre os quartis 0.25 e 0.75 
- Longo: entre os quartis 0.75 e o limite superior de outliers, definido por q3 + 1.5 * iqr (zona de tolerância)
- Crítico: Acima da zona de tolerância
7. Estatísticas descritivas e gráficos para extrair as informações que respondem cada pergunta de análise

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
