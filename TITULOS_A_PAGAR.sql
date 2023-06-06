USE SEU_BANCO

CREATE VIEW [dbo].[TITULOS_A_PAGAR] AS

SELECT DISTINCT 
'SUA_EMPRESA01'							AS 'EMPRESA',
------SUBSTITUA ACIMA A CONSTANTE "SUA_EMPRESAXX" PARA O NOME DA EMPRESA PROPRIETÁRIA DAS TABELAS	
---------------------------------------------------------------
CASE datepart(month,A.E2_VENCREA)
				when '1'	then 'Janeiro'
				when '2'	then 'Fevereiro'
				when '3'	then 'Março'
				when '4'	then 'Abril'
				when '5'	then 'Maio'
				when '6'	then 'Junho'
				when '7'	then 'Julho'
				when '8'	then 'Agosto'
				when '9'	then 'Setembro'
				when '10'	then 'Outubro'
				when '11'	then 'Novembro'
				when '12'	then 'Dezembro'
END										AS 'MES_ANO',
----------------------------------------------------------------
Convert(char(4),Year(A.E2_VENCREA))		AS 'ANO',
(DATEPART(WEEK,A.E2_VENCREA))			AS 'SEMANA',
----------------------------------------------------------------
RTRIM(LTRIM(CONVERT(CHAR(8),A.E2_FORNECE)))+RTRIM(LTRIM(A.E2_LOJA))		AS 'COD_FOR_LOJA',
RTRIM(LTRIM(B.A2_NOME))					AS 'FORNECEDOR',
----------------------------------------------------------------
case when (A.E2_VALOR-A.E2_SALDO) > 0
		then 'LIQU_PARCIAL' 
		else 'ABERTO'
end										AS 'SITUACAO',
----------------------------------------------------------------
CONVERT(DATE,A.E2_EMISSAO)				AS 'EMISSAO',
CONVERT(DATE,A.E2_VENCREA)				AS 'DATA_VENCTO',
A.E2_PREFIXO							AS 'PREFIXO',
----------------------------------------------------------------
CASE	A.E2_TIPO
		WHEN 'DP'	THEN	'DUPLICATA'  
		WHEN 'INS'	THEN	'INSS'
		WHEN 'ISS'	THEN	'ISS'
		WHEN 'NDF'	THEN	'(-)NOTA DEB FORNEC(DEV. CPRA)'
		WHEN 'NF'	THEN	'NOTA FISCAL'
		WHEN 'PA'	THEN	'(-)PAGTO ANTECIPADO'
		WHEN 'PR'	THEN	'PROVISAO'
		WHEN 'RC'	THEN	'(-)RECIBO'
		WHEN 'TX'	THEN	'TAXAS-IMPOSTOS'
		ELSE 'SEM DESCRICAO'
END										AS 'TIPO',
----------------------------------------------------------------
A.E2_NUM								AS 'NUMERO',
----------------------------------------------------------------
case when A.E2_PARCELA = '' 
		then '1' 
		else A.E2_PARCELA 
end										AS 'PARCELA',
----------------------------------------------------------------
CASE	WHEN E2_TIPO IN ('PA','NDF','RC')
		THEN A.E2_SALDO*-1 
		ELSE A.E2_SALDO					
END										AS 'VLR_SALDO'



FROM  

SE2010	A			LEFT JOIN	----CONTAS A PAGAR

SA2010	B	ON		B.A2_FILIAL		= A.E2_FILIAL					AND	----CAD FORNECEDOR
					B.A2_COD		= A.E2_FORNECE					AND
					B.A2_LOJA		= A.E2_LOJA						AND	
					B.D_E_L_E_T_    <> '*'
									
					
					
WHERE	A.D_E_L_E_T_	<> '*'	
AND		A.E2_SALDO		>  0
AND		A.E2_TIPO		NOT IN ('PA') 



---UTILIZE ABAIXO QUANTOS UNIONS FOREM SUAS EMPRESAS/FILIAIS DENTRO DA BASE DO PROTHEUS, REPLICANDO TODA A QUERY E ALTERANDO 
---A REFERÊNCIA DAS TABELAS E O CONTEÚDO DA COLUNA "EMPRESA", CASO NÃO HAJA NECESSIDADE, ELIMINE O RESTANTE DA QUERY A PARTIR DAQUI.
--------------------------------------------------------------------------------	
UNION
--------------------------------------------------------------------------------


SELECT DISTINCT 
'SUA_EMPRESA02'							AS 'EMPRESA',
------SUBSTITUA ACIMA A CONSTANTE "SUA_EMPRESAXX" PARA O NOME DA EMPRESA PROPRIETÁRIA DAS TABELAS	
---------------------------------------------------------------
CASE datepart(month,A.E2_VENCREA)
				when '1'	then 'Janeiro'
				when '2'	then 'Fevereiro'
				when '3'	then 'Março'
				when '4'	then 'Abril'
				when '5'	then 'Maio'
				when '6'	then 'Junho'
				when '7'	then 'Julho'
				when '8'	then 'Agosto'
				when '9'	then 'Setembro'
				when '10'	then 'Outubro'
				when '11'	then 'Novembro'
				when '12'	then 'Dezembro'
END										AS 'MES_ANO',
----------------------------------------------------------------
Convert(char(4),Year(A.E2_VENCREA))		AS 'ANO',
(DATEPART(WEEK,A.E2_VENCREA))			AS 'SEMANA',
----------------------------------------------------------------
RTRIM(LTRIM(CONVERT(CHAR(8),A.E2_FORNECE)))+RTRIM(LTRIM(A.E2_LOJA))		AS 'COD_FOR_LOJA',
RTRIM(LTRIM(B.A2_NOME))					AS 'FORNECEDOR',
----------------------------------------------------------------
case when (A.E2_VALOR-A.E2_SALDO) > 0
		then 'LIQU_PARCIAL' 
		else 'ABERTO'
end										AS 'SITUACAO',
----------------------------------------------------------------
CONVERT(DATE,A.E2_EMISSAO)				AS 'EMISSAO',
CONVERT(DATE,A.E2_VENCREA)				AS 'DATA_VENCTO',
A.E2_PREFIXO							AS 'PREFIXO',
----------------------------------------------------------------
CASE	A.E2_TIPO
		WHEN 'DP'	THEN	'DUPLICATA'  
		WHEN 'INS'	THEN	'INSS'
		WHEN 'ISS'	THEN	'ISS'
		WHEN 'NDF'	THEN	'(-)NOTA DEB FORNEC(DEV. CPRA)'
		WHEN 'NF'	THEN	'NOTA FISCAL'
		WHEN 'PA'	THEN	'(-)PAGTO ANTECIPADO'
		WHEN 'PR'	THEN	'PROVISAO'
		WHEN 'RC'	THEN	'(-)RECIBO'
		WHEN 'TX'	THEN	'TAXAS-IMPOSTOS'
		ELSE 'SEM DESCRICAO'
END										AS 'TIPO',
----------------------------------------------------------------
A.E2_NUM								AS 'NUMERO',
----------------------------------------------------------------
case when A.E2_PARCELA = '' 
		then '1' 
		else A.E2_PARCELA 
end										AS 'PARCELA',
----------------------------------------------------------------
CASE	WHEN E2_TIPO IN ('PA','NDF','RC')
		THEN A.E2_SALDO*-1 
		ELSE A.E2_SALDO					
END										AS 'VLR_SALDO'



FROM  

SE2020	A			LEFT JOIN	----CONTAS A PAGAR

SA2020	B	ON		B.A2_FILIAL		= A.E2_FILIAL					AND	----CAD FORNECEDOR
					B.A2_COD		= A.E2_FORNECE					AND
					B.A2_LOJA		= A.E2_LOJA						AND	
					B.D_E_L_E_T_    <> '*'
									
					
					
WHERE	A.D_E_L_E_T_	<> '*'	
AND		A.E2_SALDO		>  0
AND		A.E2_TIPO		NOT IN ('PA') 