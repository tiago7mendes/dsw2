package edu.ifsp.loja.modelo;

import java.sql.Date;
import java.util.List;

public class Pedido {

	private int id;
	private int cliente_id;
	private Date dt_criacao;
	private List<PedidoItem> itens;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	public int getClienteId() {
		return cliente_id;
	}

	public void setClienteId(int cliente_id) {
		this.cliente_id = cliente_id;
	}
	
	public Date getDtCriacao() {
		return dt_criacao;
	}

	public void setDtCriacao(Date dt_criacao) {
		this.dt_criacao = dt_criacao;
	}

	public List<PedidoItem> getItens() {
		return itens;
	}

	public void setItens(List<PedidoItem> itens) {
		this.itens = itens;
	}

}
