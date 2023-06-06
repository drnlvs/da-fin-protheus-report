# Protheus Fin Report
> **Python | SQL** :white_check_mark: 



## Motivação 
Necessidade de um relatório financeiro com os dados do **ERP Protheus da TOTVS®** que contemplasse o contas a pagar, a receber e o saldo bancário e fosse enviado via e-mail.
Também por necessidade da organização, o saldo bancário total seria informado semanalmente em uma planilha, para que conseguissem inputar outros saldos que se fizessem necessários e o relatório demonstraria duas visões, uma semanal e outra geral com 60 dias a frente (configurável).



## Demo Relatório

Cabeçalho demonstrando os resumos para a semana vigente.
![report-01](report-01.jpg)

Resumo da semana com valor acumulado por Cliente (receber) e Fornecedor (pagar)
![report-02](report-02.jpg)

Geral acumulado (60 dias) com soma.
![report-03](report-03.jpg)
![report-04](report-04.jpg)


## Instalação
* install requeriments.txt;
* criar as queries em sua base de dados;
* ajusta nome da empresa e necessidade de UNION nas queries;
* ajusta no arquivo py as variáveis do banco na sessão "CRIA VARIÁVEIS";
* ajusta no arquivo py as variáveis na sessão "CONFIGURANDO ENVIO DE EMAILS";
* ajusta no arquivo py o diretório do arquivo xlsx na sessão "CRIANDO DATAFRAME SALDOS BANCÁRIOS"



---
