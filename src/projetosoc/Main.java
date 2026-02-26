package projetosoc;

public class Main {
	public static void main(String[] args) {
		
		ClienteDAO clienteDao = new ClienteDAO();
		Cliente cliente = clienteDao.findById(1);
		
		ProdutoDAO produtoDao = new ProdutoDAO();
		Produto produto = produtoDao.findById(2);
		
		System.out.println("Nome: " + cliente.getNome());
		
		System.out.println("Email: " + cliente.getEmail());
		
		System.out.println("Nome: " + produto.getDescricao());
		
		System.out.println("Email: " + produto.getPreco());
	}
}
