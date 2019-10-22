create database selects
go
use selects
 
create table funcionario(
id int identity not null primary key,
nome varchar(100) not null,
sobrenome varchar(200) not null,
logradouro varchar(200) not null,
numero int not null CHECK(numero > 0),
bairro varchar(100) null,
cep char(8) null CHECK(LEN(cep) = 8),
ddd char(2) DEFAULT ('11') null,
telefone char(8) null CHECK(LEN(telefone) = 8),
data_nasc datetime not null CHECK(data_nasc < GETDATE()),
salario decimal(7,2) not null)
 
create table projeto(
codigo int not null identity(1001,1) primary key,
nome varchar(200) not null,
descricao varchar(300) null)
 
create table funcproj(
id_funcionario int not null,
codigo_projeto int not null,
data_inicio datetime not null,
data_fim datetime not null,
CONSTRAINT chk_dt CHECK(data_fim > data_inicio),
primary key (id_funcionario, codigo_projeto),
foreign key (id_funcionario) references funcionario (id),
foreign key (codigo_projeto) references projeto (codigo))
 
select * from funcionario
select * from projeto
select * from funcproj
 
insert into funcionario (nome, sobrenome, logradouro, numero, bairro, cep, ddd, telefone, data_nasc, salario) values
('Fulano',  'da Silva', 'R. Voluntários da Patria',    8150,   'Santana',  '05423110', '11',   '76895248', '15/05/1974',   4350.00),
('Cicrano', 'De Souza', 'R. Anhaia', 353,   'Barra Funda',  '03598770', '11',   '99568741', '25/08/1984',   1552.00),
('Beltrano',    'Dos Santos',   'R. ABC', 1100, 'Artur Alvim',  '05448000', '11',   '25639854', '02/06/1963',   2250.00),
('Tirano',  'De Souza', 'Avenida Águia de Haia', 4430, 'Artur Alvim',  '05448000', NULL,   NULL,   '15/10/1975',   2804.00)
 
insert into projeto values
('Implantação de Sistemas','Colocar o sistema no ar'),
('Modificação do módulo de cadastro','Modificar CRUD'),
('Teste de Sistema de Cadastro',NULL)
 
insert into funcproj values
(1, 1001, '18/04/2015', '30/04/2015'),
(3, 1001, '18/04/2015', '30/04/2015'),
(1, 1002, '06/05/2015', '10/05/2015'),
(2, 1002, '06/05/2015', '10/05/2015'),
(3, 1003, '11/05/2015', '13/05/2015')

SELECT GETDATE() As dia_atual

--cast
SELECT CAST('120' AS INT) AS char_to_int
SELECT CAST(120 AS CHAR(3)) AS int_to_char
SELECT Convert(INT , '120') AS char_to_int_Convert
SELECT Convert(CHAR(3),120) AS int_to_char_Convert
--ddnnaa

SELECT CONVERT(CHAR(10), GETDATE(), 103) AS data_br

--hhmm
SELECT CONVERT(CHAR(5), GETDATE(), 108) AS hora_br

SELECT CONVERT(CHAR(10), GETDATE(), 103) AS data_br ,CONVERT(CHAR(5), GETDATE(), 108) AS hora_br

--vai contar os caracteres
SELECT LEN('Banco de Dados') AS tamanho_char

--------------------------------------------------x-------------------------------------------------------
SELECT id,nome,sobrenome,logradouro,numero cep,ddd,telefone FROM funcionario
WHERE nome ='Fulano' AND sobrenome LIKE '%Silva%'

-----------------------NAO TEM TELE------------

SELECT id,nome,sobrenome,logradouro,numero cep,ddd,telefone FROM funcionario

WHERE telefone IS  null
---------------TEM TEL-------------
SELECT id,nome,sobrenome,logradouro,numero cep,ddd,telefone FROM funcionario

WHERE telefone IS NOT null

----------------------------id , nome e sobrenome concatenado dos que tem tel--------------

SELECT id,nome +' '+ sobrenome AS nome_completo ,logradouro +' , ' + Cast (numero AS VARCHAR(5))+' ,'+ cep AS endereço , Convert (CHAR(10),data_nasc, 103) AS dta_nasc FROM funcionario
WHERE telefone IS NOT NULL

  --ORDER BY nome DESC , sobrenome ASC
  ORDER BY data_nasc ASC 


----------------as---------------------------
SELECT  id_funcionario,
        codigo_projeto,
	    CONVERT(CHAR(10), data_inicio ,103) AS data_inicio,
        CONVERT(CHAR(10) ,data_fim , 103) AS data_fim
        FROM funcproj

SELECT  DISTINCT CONVERT(CHAR(10), data_inicio ,103) AS data_inicio
      --  CONVERT(CHAR(10) ,data_fim , 103) AS data_fim
        FROM funcproj





	SELECT id,
	       nome+'  '+ sobrenome As nome_Completo,
		   salario
		   FROM funcionario
		   WHERE  salario BETWEEN 2500 AND 4000

		   SELECT id,
	       nome+'  '+ sobrenome As nome_Completo,
		   salario
		   FROM funcionario
		   WHERE  salario < 2500 OR salario > 4000
           ORDER BY  salario ASC


		   SELECT id,
	       nome+'  '+ sobrenome As nome_Completo,
		   salario
		   FROM funcionario
		   WHERE  salario NOT BETWEEN 2500 AND 4000
		   ORDER BY salario ASC


		   select CAST(salario *1.12 AS DECIMAL(9,2)) AS  novo_salario,
		   salario +salario *0.12 AS novo_salario_outro
		   FROM funcionario
		   WHERE nome LIKE '%salario%'
		   -------------------------------------------------------22-10-2019----------------------------------------------
		   

		   --Substring
		   --SubString('String',pos inicial, qtde de chars
		   select SUBSTRING('Banco de dados',1,5) AS sub

		   select SUBSTRING('Banco de dados',7,2) AS sub
		-- select SUBSTRING('Banco de dados',6,4) AS sub
			
			--LTRIM & RTRIM, TRIM tira espaços branco indesejaveis , L - left , R - Rigth

			select LTRIM(SUBSTRING('Banco de dados',6,4)) AS sub
			select RTRIM(SUBSTRING('Banco de dados',6,4)) AS sub
			select RTRIM(LTRIM(SUBSTRING('Banco de dados',6,4))) AS sub


			------------------------------MANIPULAÇÃO DE DATA
			SELECT GETDATE() AS hoje

			SELECT DAY(GETDATE()) AS dia_hj, 
			MONTH(GETDATE()) AS MES, 
			YEAR(GETDATE()) AS ANO,
			DATEPART(WEEKDAY, GETDATE())AS DIASEMANA,
			DATEPART(WEEK, GETDATE())AS SEMANA

			-----------------------------DATEADD(DIA OU ANO OU MES , DIFERENÇA SENDO SOMA OU SUB, PARAMETRO ): DATA
			SELECT CONVERT(CHAR(10),GETDATE(),107)AS HOJE, DATEADD(DAY,10,GETDATE()) AS DAQUI_10_DIAS,
			CONVERT(CHAR(10), DATEADD(DAY,10,GETDATE()),107) AS DAQUI_CONVERT

			-----------------------------DATEDIFF(2 DATAS, 1 PARAMETROS): INT
			SELECT DATEDIFF(DAY,'24/10/2019',GETDATE()) AS DIF
			SELECT DATEDIFF(DAY,'20/10/2019',GETDATE())*3 AS BAN

			SELECT CAST(DATEDIFF(DAY,'20/10/2019',GETDATE())*3 AS VARCHAR(4)) + ' Dias' as ban_cast

			--__--__--__--__--__---__--__--__--__--__---__--__--__--__--__---__--__--__--__--__---__--__--__--__--__---__--__--__--__--__--

			select * from funcionario

			insert into funcionario values
			('Fulano','da silva Junior','R. Voluntarios da patria', 8150, 'santana','05423110','11','32549876','09/09/1990',1235.50)


			update funcionario set bairro = null  where id =5

			--cep: XXXXX-XXX   tel (XXX) XXXX-XXXX
			--case when then end
			SELECT id, nome+'  '+ sobrenome As nome_Completo,
		    substring(cep,1,5) + '-'+ SUBSTRING(cep,6,3) AS CEP,
				case when cast(SUBSTRING(telefone,1,1) as int) >= 6 then
					'('+ddd+') 9'+SUBSTRING(telefone,1,4)+'-'+SUBSTRING(telefone,5,4) 
				else
					'('+ddd+') '+SUBSTRING(telefone,1,4)+'-'+SUBSTRING(telefone,5,4) 
				end
					as tel ,
			logradouro + ' '+ cast(numero as varchar(5)) +
				case when bairro IS NOT NULL THEN
					 ' - ' +bairro
				ELSE
					''
				END
				AS endereco_Completo 
		    FROM funcionario


		   --__--__--__--__--__---__--__--__--__--__---__--__--__--__--__---__--__--__--__--__---__--__--__--__--__---__--__--__--__--__--

		   select * from funcproj

		   --qtde dias trabaljados pelo func naquele projeto

		   select id_funcionario, codigo_projeto, DATEDIFF(day, data_inicio, data_fim) as total_dias from funcproj

		   --id func q tem menos de 10 dias de projeto

		   select distinct id_funcionario, codigo_projeto, DATEDIFF(day, data_inicio, data_fim) as total_dias from funcproj where DATEDIFF(day, data_inicio, data_fim) < 10

		   --cod projeto q tem menos de 10 dias de projeto

		   select distinct codigo_projeto, DATEDIFF(day, data_inicio, data_fim) as total_dias from funcproj where DATEDIFF(day, data_inicio, data_fim) < 10



		    --__--__--__--__--__---__--__--__--__--__---__--__--__--__--__---__--__--__--__--__---__--__--__--__--__---__--__--__--__--__--

			--subQuerry

			select nome from projeto where codigo in(select codigo_projeto from funcproj where id_funcionario in (select id from funcionario where nome='beltrano'))

			--ex1 considerando anos bissextos , fazer uma querry q retorna 
			--id, nome , idade de todos os funcs

			--ex2 fazaer uma consulta q dado oo nome do projeto , retorne o id e o nome distinto dos func q trabalharam nele
		

