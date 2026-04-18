# Análise de volume e tempo de atendimento da conta Gov.br
Investigação estatística do volume de solicitações e da distribuição do tempo de atendimento a partir de dados públicos da central Gov.br.

## Resumo
Este projeto realiza uma Análise Exploratória de Dados (EDA) dos atendimentos da conta Gov.br em 2025, com foco na validação de métricas operacionais e entendimento do comportamento do tempo de atendimento.

Principais resultados:
- 99,86% dos atendimentos têm origem em Facematch
- Taxa média de aceitação: 73,88%
- Identificação de cauda longa no tempo de atendimento (outliers relevantes)
- Picos de duração em períodos específicos (março e agosto)

Tecnologias: Python, BigQuery, SQL
Autor: Jorge Gabriel

## Objetivo:
Disponibilizar os dados em cloud para ingestão mensal e investigar os atendimentos de 2025, garantindo qualidade dos dados e consistência estatística dos seguintes indicadores: 

a) volume de solicitações; 

b) tempo de atendimento.

## Habilidades Demonstradas
- Estatística descritiva aplicada a dados reais
- Análise Exploratória de Dados (EDA)
- Validação de métricas para dashboards
- Construção de pipeline de dados (API → BigQuery)
- Otimização de processamento com Parquet
- Simplificação de problemas analíticos
  
## Fonte dos dados:
https://dados.gov.br/dados/conjuntos-dados/atendimentos-realizados-na-central-de-atendimento-da-conta-govbr

## Pipeline:
- Download CSV mensal
- Conversão para Parquet reduzindo tamanho dos dados sem perdas (PyArrow)
- Envio para o BigQuery via Google Cloud API
- Load em tabela particionada por mês
- Consulta e amostragem aleatória (SQL)
- Python (EDA)
  
### Justificativa de escolha do Pipeline
- Reduzir custo de armazenamento e processamento com uso de Parquet
- Utilização de ferramentas gratuitas
- Permitir atualização mensal dos dados
- Facilitar consultas analíticas em BigQuery
- Separar etapa de ingestão da etapa de análise

## Perguntas que orientaram a análise:
### Volume de solicitações
1) Qual é a origem de 80% dos atendimentos?
2) Qual é o turno com maior volume de entrada de solicitações?
3) Em quanto ficou a taxa de aceitação das solicitações durante o ano de 2025?

### Tempo de atendimento
1) Como está a distribuição dos atendimentos em cada faixa de duração?
2) Como está a variação do tempo de atendimento ao longo dos meses?
3) Como está a duração dos atendimentos em cada situação de encerramento?
4) Qual é o turno com maior duração dos atendimentos?
5) Quais são os dias da semana com maior duração mediana de atendimentos?

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

## Processo de Análise
Etapas realizadas na análise:
1. Descrição dos dados e verificação de types;
2. Padronização de nomes das variáveis em camelCase;
3. Verificação de dados nulos;
4. Cálculo de variáveis: duração do atendimento, turnos de atendimento (manhã, tarde e noite), dias da semana;
5. Análise de outliers;
6. Categorizei os atendimentos por quartis de duração para melhor visualização dos dados;
7. Estatísticas descritivas e gráficos para extrair as informações e responder cada pergunta de análise.

## Visualizações da Análise

A análise foi conduzida utilizando gráficos e tabelas de frequências para compreender padrões de distribuição, variabilidade e comportamento temporal dos atendimentos.

### Principais visualizações utilizadas:
- Distribuição do tempo de atendimento
- Volume de solicitações por turno
- Volume de solicitações por categoria
- Variação mensal da duração dos atendimentos
- Comparação de duração por situação de encerramento
- Mediana de duração por dia da semana

Exemplos de análises realizadas incluem identificação de cauda longa na distribuição do tempo de atendimento e detecção de períodos com aumento significativo na duração das solicitações.

As visualizações completas podem ser consultadas no notebook do projeto.

## Principais insights e respostas às perguntas de análise
### Volume de solicitações
- Forte concentração de origem: 99,86% via Facematch - reconhecimento facial para Prova de Vida do INSS, elevar o nível da conta para Prata ou Ouro e Acesso Seguro.
- Maior volume de demanda no período da tarde (41,78%)
- Taxa de aceitação de 73,88%, indicando volume relevante de rejeições

### Tempo de atendimento
- Distribuição com alta variabilidade e cauda longa (outliers relevantes): os valores extremos foram tratados como parte do comportamento, sendo analisados separadamente como atendimentos de alta duração. Utilizei medidas estatísticas como mediana e percentis para melhor representação da distribuição.
- 50% dos atendimentos duram entre ~13 minutos e 63h
- 1% ultrapassa 159h (casos críticos)

### Padrões temporais
- Picos de duração em março e agosto, podendo ser por instabilidade operacional, ou programa de governo que atraiu demanda fora do comum para a plataforma. Entre os dias 9 e 16 de agosto o tempo de duração dos atendimentos subiu drasticamente. O atendimento mais demorado começou em 10/08/2025 e durou 524h.
- Aumento progressivo no último trimestre: é válido analisar em outros projetos se esse aumento está correlacionado a pagamentos de benefícios no final do ano, acesso a informações sobre 13º salário, regularização de pendências de documentos, entre outros serviços que os usuários possam buscar no final do ano.
- Finais de semana apresentam maior duração mediana, com ênfase para os atendimentos iniciados aos Domingos, quando atingem 25h de duração mediana, sugerindo possíveis diferenças de capacidade operacional nesses períodos.
- Atendimentos noturnos são mais longos.

## Conclusão
Este projeto demonstra a construção de um pipeline de dados escalável aliado a uma análise exploratória robusta para validação de métricas operacionais.

A combinação de técnicas simples de estatística com boas práticas de engenharia de dados permitiu extrair insights relevantes em um dataset real e de grande volume.

O projeto reforça a importância da EDA como etapa crítica para:
- Entendimento do comportamento dos dados
- Identificação de padrões e anomalias
- Garantia de consistência antes da construção de dashboards
## Possíveis extensões do projeto:

* Dashboard de monitoramento de atendimentos
* Análise de SLA de atendimento
* Identificação de gargalos operacionais

* Ferramentas sugeridas:
BigQuery e Looker Studio
