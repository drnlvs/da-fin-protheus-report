USE SEU_BANCO

CREATE VIEW [dbo].[TITULOS_A_RECEBER] AS

SELECT DISTINCT 
'SUA_EMPRESA01'							AS 'EMPRESA',
------SUBSTITUA ACIMA A CONSTANTE "SUA_EMPRESAXX" PARA O NOME DA EMPRESA PROPRIETÁRIA DAS TABELAS
----------------------------------------------------------------
CASE datepart(month,A.E1_VENCREA)
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
Convert(char(4),Year(A.E1_VENCREA))		AS 'ANO',
(DATEPART(WEEK,A.E1_VENCREA))			AS 'SEMANA',
----------------------------------------------------------------	
A.E1_CLIENTE+A.E1_LOJA					AS 'COD_CLI_LOJA',
B.A1_NOME								AS 'CLIENTE',
----------------------------------------------------------------
case when (A.E1_VALOR-A.E1_SALDO) > 0
		then 'LIQU_PARCIAL' 
		else 'ABERTO'
end										AS 'SITUACAO',
----------------------------------------------------------------
CASE A.E1_SITUACA 
				when '0'	then 'CARTEIRA'
				when '1'	then 'COBR_SIMPLES'
				when '2'	then '(-)DESCONTADA'
				when '3'	then '(-)CAUCIONADA'
				when '4'	then 'VINCULADA'
				when '5'	then 'ADVOGADO'
				when '6'	then 'JUDICIAL'
				
END										AS 'TIPO_COBRANÇA',
------------------------------------------------------------------
CASE WHEN A.E1_PORTADO <> '' 
		THEN C.A6_NREDUZ
		ELSE 'SEM BANCO'
END										AS 'BANCO',
------------------------------------------------------------------
CONVERT(DATE,A.E1_EMISSAO)				AS 'EMISSAO',
CONVERT(DATE,A.E1_VENCREA)				AS 'DATA_VENCTO', 
A.E1_PREFIXO							AS 'PREFIXO',
----------------------------------------------------------------
CASE	A.E1_TIPO
		WHEN 'AB-'	THEN	'(-)ABATIMENTO'  
		WHEN 'DP'	THEN	'DUPLICATA'
		WHEN 'NCC'	THEN	'(-)NOTA DEB FORNEC(DEV. CPRA)'
		WHEN 'NF'	THEN	'NOTA FISCAL'
		WHEN 'RA'	THEN	'(-)RECBTO ANTECIPADO'
		ELSE 'SEM DESCRICAO'
END										AS 'TIPO',
----------------------------------------------------------------
A.E1_NUM								AS 'NUMERO',
----------------------------------------------------------------
case when A.E1_PARCELA = '' 
		then '1' 
		else A.E1_PARCELA 
end										AS 'PARCELA',
----------------------------------------------------------------
CASE	WHEN E1_TIPO IN ('AB-','RA','NCC') 
		THEN A.E1_SALDO*-1 
		ELSE A.E1_SALDO					
END										AS 'VLR_SALDO'
----------------------------------------------------------------


FROM  

SE1010 A			INNER JOIN		----CONTAS A RECEBER 

SA1010 B ON			B.A1_FILIAL		=	A.E1_FILIAL					AND	----CADASTRO CLIENTE
					B.A1_COD		=	A.E1_CLIENTE				AND
					B.A1_LOJA		=	A.E1_LOJA	
					LEFT JOIN
					
SA6010 C ON			C.A6_FILIAL		=	A.E1_FILIAL					AND  ----CADASTRO BANCOS
					C.A6_COD		=	A.E1_PORTADO				AND
					C.A6_AGENCIA	=	A.E1_AGEDEP					AND
					C.A6_NUMCON		=	A.E1_CONTA					AND
					C.A6_BLOCKED	<> '1'							AND
					C.D_E_L_E_T_				<> '*'				
					
					
WHERE	A.D_E_L_E_T_	<> '*'	
AND		A.E1_SALDO		>  0




---UTILIZE ABAIXO QUANTOS UNIONS FOREM SUAS EMPRESAS/FILIAIS DENTRO DA BASE DO PROTHEUS, REPLICANDO TODA A QUERY E ALTERANDO 
---A REFERÊNCIA DAS TABELAS E O CONTEÚDO DA COLUNA "EMPRESA", CASO NÃO HAJA NECESSIDADE, ELIMINE O RESTANTE DA QUERY A PARTIR DAQUI.
--------------------------------------------------------------------------------	
UNION
--------------------------------------------------------------------------------


SELECT DISTINCT 
'SUA_EMPRESA02'							AS 'EMPRESA',
------SUBSTITUA ACIMA A CONSTANTE "SUA_EMPRESAXX" PARA O NOME DA EMPRESA PROPRIETÁRIA DAS TABELAS
----------------------------------------------------------------
CASE datepart(month,A.E1_VENCREA)
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
Convert(char(4),Year(A.E1_VENCREA))		AS 'ANO',
(DATEPART(WEEK,A.E1_VENCREA))			AS 'SEMANA',
----------------------------------------------------------------	
----ISNULL(B.A1_ZZCLASS,'SEM SEGMENTO')		AS 'SEGMENTO',	
A.E1_CLIENTE+A.E1_LOJA					AS 'COD_CLI_LOJA',
B.A1_NOME								AS 'CLIENTE',
----------------------------------------------------------------
case when (A.E1_VALOR-A.E1_SALDO) > 0
		then 'LIQU_PARCIAL' 
		else 'ABERTO'
end										AS 'SITUACAO',
----------------------------------------------------------------
CASE A.E1_SITUACA 
				when '0'	then 'CARTEIRA'
				when '1'	then 'COBR_SIMPLES'
				when '2'	then '(-)DESCONTADA'
				when '3'	then '(-)CAUCIONADA'
				when '4'	then 'VINCULADA'
				when '5'	then 'ADVOGADO'
				when '6'	then 'JUDICIAL'
				
END										AS 'TIPO_COBRANÇA',
------------------------------------------------------------------
CASE WHEN A.E1_PORTADO <> '' 
		THEN C.A6_NREDUZ
		ELSE 'SEM BANCO'
END										AS 'BANCO',
------------------------------------------------------------------
CONVERT(DATE,A.E1_EMISSAO)				AS 'EMISSAO',
CONVERT(DATE,A.E1_VENCREA)				AS 'DATA_VENCTO', 
A.E1_PREFIXO							AS 'PREFIXO',
----------------------------------------------------------------
CASE	A.E1_TIPO
		WHEN 'AB-'	THEN	'(-)ABATIMENTO'  
		WHEN 'DP'	THEN	'DUPLICATA'
		WHEN 'NCC'	THEN	'(-)NOTA DEB FORNEC(DEV. CPRA)'
		WHEN 'NF'	THEN	'NOTA FISCAL'
		WHEN 'RA'	THEN	'(-)RECBTO ANTECIPADO'
		ELSE 'SEM DESCRICAO'
END										AS 'TIPO',
----------------------------------------------------------------
A.E1_NUM								AS 'NUMERO',
----------------------------------------------------------------
case when A.E1_PARCELA = '' 
		then '1' 
		else A.E1_PARCELA 
end										AS 'PARCELA',
----------------------------------------------------------------
CASE	WHEN E1_TIPO IN ('AB-','RA','NCC') 
		THEN A.E1_SALDO*-1 
		ELSE A.E1_SALDO					
END										AS 'VLR_SALDO'
----------------------------------------------------------------


FROM  

SE1020 A			INNER JOIN		----CONTAS A RECEBER 

SA1020 B ON			B.A1_FILIAL		=	A.E1_FILIAL					AND	----CADASTRO CLIENTE
					B.A1_COD		=	A.E1_CLIENTE				AND
					B.A1_LOJA		=	A.E1_LOJA	
					LEFT JOIN
					
SA6020 C ON			C.A6_FILIAL		=	A.E1_FILIAL					AND  ----CADASTRO BANCOS
					C.A6_COD		=	A.E1_PORTADO				AND
					C.A6_AGENCIA	=	A.E1_AGEDEP					AND
					C.A6_NUMCON		=	A.E1_CONTA					AND
					C.A6_BLOCKED	<> '1'							AND
					C.D_E_L_E_T_				<> '*'				
					
					
WHERE	A.D_E_L_E_T_	<> '*'	
AND		A.E1_SALDO		>  0


GO


