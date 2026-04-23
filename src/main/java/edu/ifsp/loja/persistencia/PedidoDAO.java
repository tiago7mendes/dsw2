package edu.ifsp.loja.persistencia;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import edu.ifsp.loja.modelo.Pedido;

public class PedidoDAO {
	public void save(Pedido pedido) {
		try {
			Connection conn = DatabaseConnector.getConnection();
			try {
				conn.setAutoCommit(false);
				
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(
						"SELECT id, descricao, preco FROM produto WHERE id = " + id);

				rs.close();
				stmt.close();
				conn.commit();
				conn.close();
				
			} catch (SQLException e) {
				conn.rollback();
				e.printStackTrace();
			}
		} catch (SQLException e) {
			throw new DataAccessException(e);
		}
	}
}
