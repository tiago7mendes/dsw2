package edu.ifsp.loja.controllers.produto;

import java.sql.Date;

public record PedidoDTO(Integer id, Integer cliente_id, Date dt_criacao) {}
