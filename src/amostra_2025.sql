-- BigQuery

WITH base AS (
  SELECT *,
  FORMAT_DATE("%Y-%m", datainicio) AS mes
  FROM `govbr-atendimentos.bronze_dataset.bronze_tabela` 
  WHERE datainicio BETWEEN DATETIME("2024-12-31") AND DATETIME("2026-01-01")
),

amostra AS (
  SELECT *
  FROM (
    SELECT *,
    ROW_NUMBER() OVER(PARTITION BY mes ORDER BY RAND()) AS row_numb
    FROM base
  )
  WHERE row_numb <= 5000
)

SELECT *
FROM amostra