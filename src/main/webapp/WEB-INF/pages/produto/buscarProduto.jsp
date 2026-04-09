<%@page import="com.mysql.cj.protocol.x.SyncFlushDeflaterOutputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="edu.ifsp.loja.controllers.produto.BuscarProdutoForm" %>
<%@ page import="edu.ifsp.loja.controllers.produto.ProdutoDTO" %>
<%@ page import="edu.ifsp.loja.util.StringUtil" %>
<%@ page import="java.util.List" %>

<%
BuscarProdutoForm form = (BuscarProdutoForm)request.getAttribute("form");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Loja Web2</title>
<script>
function gotoPage(page) {
	const form = document.querySelector('#search-form');
	const pageInput = form.querySelector('input[name="page"]');
	pageInput.value = page;
	form.submit();		
}

function movePage(offset) {
	const currentPage = <%= form.getPage() %>;
	gotoPage(currentPage + offset);
}

function transportPage(num) {
	gotoPage(num);
}

let crescente = true;

function ordenarPorPreco() {
    const tabela = document.getElementById("tabela-produtos");
    const tbody = tabela.querySelector("tbody");
    const linhas = Array.from(tbody.querySelectorAll("tr"));

    linhas.sort((a, b) => {
        const precoA = parseFloat(a.children[2].innerText);
        const precoB = parseFloat(b.children[2].innerText);

        if (crescente) {
            return precoA - precoB;
        } else {
            return precoB - precoA;
        }
    });

    // Reinsere as linhas ordenadas
    linhas.forEach(linha => tbody.appendChild(linha));

    // Alterna ordem
    crescente = !crescente;
}
</script>
</head>
<body>
	<h1>Buscar produtos</h1>
	<form id="search-form" method="get" action="<%= request.getContextPath() %>/produto/buscar">
		<label for="descricao">Descrição: </label>
		<input type="text" name="descricao" id="descricao" value="<%= StringUtil.emptyIfNull(form.getDescricao()) %>">
		<br>

		<label for="preco-minimo">Preço Mínimo: </label>
		<input type="number" name="precoMinimo" id="preco-minimo" value="<%= form.getPrecoMinimo() %>">
		<br>
				
		<label for="preco-maximo">Preço Máximo: </label>
		<input type="number" name="precoMaximo" id="preco-maximo" value="<%= form.getPrecoMaximo() %>">
		<br>

		<input type="hidden" name="page" value="1">
		
		<label for="pageSize">Quantidade de Itens: </label>
		<input type="number" name="pageSize" value="<%= form.getPageSize() %>">
		<br>

		<button type="submit">Buscar</button>
	</form>
	
	<%
	int totalRegistros = 0;
	if (request.getAttribute("produtos") != null) {
		List<ProdutoDTO> produtos = (List<ProdutoDTO>)request.getAttribute("produtos");
		totalRegistros = request.getAttribute("totalRegistros") != null
				? (Integer) request.getAttribute("totalRegistros")
				: 0;
	%>
	<br>
	<table border="1" id="tabela-produtos">
    <thead>
        <tr>
            <th>ID</th>
            <th>Descrição</th>
            <th onclick="ordenarPorPreco()" style="cursor:pointer;">
                Preço
            </th>
        </tr>
    </thead>
    <tbody>
        <% for (ProdutoDTO p : produtos) { %>
        <tr>
            <td><%= p.id() %></td>
            <td><%= p.descricao() %></td>
            <td><%= p.preco() %></td>
        </tr>
        <% } %>
    </tbody>
</table>
	
	<%int totalPage = (int) Math.ceil((double) totalRegistros / form.getPageSize()); %>
	<p>Quantidade de produtos: <%= totalRegistros %></p>
	
	<%if(form.getPage() != 1){ %>
	<a href="#" onclick="movePage(-1)">Anterior</a> 
	<%} %>
	
	<%if(form.getPage() != totalPage){ %>
	<a href="#" onclick="movePage(1)">Próxima</a>
	<%} %>
	<br>
	
	<% for(int t = 1; t <= totalPage; t++) {%>
	<a href="#" onclick="transportPage(<%= t%>)">[<%= t %>]</a>
	<%} %>	
	<%
	} else {
	%>
	<p>Nenhum resultado encontrado para os critérios informados.</p>
	<%
	}
	%>
	
	
</body>
</html>