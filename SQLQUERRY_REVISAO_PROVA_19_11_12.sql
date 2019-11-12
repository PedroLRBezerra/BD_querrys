--SIte Leandro COlevati
	--Matreriais
		--BD
			--SimualdoPRova

create database exbd2
go
restore database exbd2 from disk = 'c:\temp\exbd2.bak' with recovery, replace

Use exbd2

select * from autores

--OK Fazer uma consulta que retorne o nome do cliente e a data do empr�stimo formatada padr�o BR (dd/mm/yyyy)
SELECT cli.nome , CONVERT(char(10), emp.data, 103) AS data_emprestimo FROM clientes AS cli , emprestimo AS emp WHERE 
emp.cod_cli = cli.cod

--OK Fazer uma consulta que retorne Nome do autor e Quantos livros foram escritos por Cada autor, ordenado pelo n�mero de livros. Se o nome do autor tiver mais de 25 caracteres, mostrar s� os 13 primeiros.
SELECT CASE WHEN (LEN(aut.nome) >25) THEN
			SUBSTRING(aut.nome,1,13)+'.'
		ELSE
			aut.nome 
		END AS nome,
		COUNT(liv.cod) AS livros FROM autores AS aut , livros as liv 
		WHERE liv.cod_autor=aut.cod
		GROUP BY aut.nome
		ORDER BY livros DESC


--NOK Fazer uma consulta que retorne o nome do autor e o pa�s de origem do livro com maior n�mero de p�ginas cadastrados no sistema
--SELECT aut.nome, aut.pais , MAX(liv.pag) FROM autores aut, livros liv
--WHERE liv.cod_autor = aut.cod 
--GROUP BY aut.nome, aut.pais

--OK Fazer uma consulta que retorne Nome e endere�o concatenado dos clientes que tem livros emprestados
SELECT DISTINCT cli.nome, cli.logradouro +' , '+CAST(cli.numero as VARCHAR(5)) AS Endereco FROM clientes cli, emprestimo emp
WHERE cli.cod = emp.cod_cli

/*
Nome dos Clientes, sem repetir e, concatenados como
ender�o_telefone, o logradouro, o numero e o telefone) dos
clientes que N�o pegaram livros. Se o logradouro e o 
n�mero forem nulos e o telefone n�o for nulo, mostrar s� o telefone. Se o telefone for nulo e o logradouro e o n�mero n�o forem nulos, mostrar s� logradouro e n�mero. Se os tr�s existirem, mostrar os tr�s.
O telefone deve estar mascarado XXXXX-XXXX
*/


SELECT DISTINCT cli.nome ,
	CASE WHEN((cli.logradouro IS NOT NULL) AND (cli.numero IS NOT NULL)) THEN
		CASE WHEN(cli.telefone IS NOT NULL) THEN
			'TELEFONE: '+SUBSTRING(cli.telefone,1,5)+'-'+SUBSTRING(cli.telefone,6,4)
			+' | ENDERECO: '+cli.logradouro +' , '+CAST(cli.numero as VARCHAR(5))
		ELSE
			 'ENDERECO: '+cli.logradouro +' , '+CAST(cli.numero as VARCHAR(5))
		END
		ELSE
		CASE WHEN(cli.telefone IS NOT NULL) THEN
			'TELEFONE: '+SUBSTRING(cli.telefone,1,5)+'-'+SUBSTRING(cli.telefone,6,4)
		END
	END AS telefone_Endereco
FROM clientes cli LEFT OUTER JOIN emprestimo emp
ON cli.cod = emp.cod_cli 
WHERE emp.cod_cli is null

--OK Fazer uma consulta que retorne quantos livros n�o foram emprestados
SELECT count(livros.cod) FROM livros LEFT OUTER JOIN emprestimo emp
ON livros.cod = emp.cod_livro
WHERE emp.cod_cli is null

--OK Fazer uma consulta que retorne Nome do Autor, Tipo do corredor e quantos livros, ordenados por quantidade de livro

SELECT aut.nome , cor.tipo, count(liv.cod) as Livros FROM autores aut, corredor cor, livros liv
WHERE aut.cod = liv.cod_autor AND cor.cod = liv.cod_corredor
GROUP BY cor.tipo, aut.nome

-- Considere que hoje � dia 18/05/2012, fa�a uma consulta que apresente o nome do cliente, o nome do livro, o total de dias que cada um est� com o livro
--e, uma coluna que apresente, caso o n�mero de dias seja superior a 4, apresente 'Atrasado', caso contr�rio, apresente 'No Prazo'