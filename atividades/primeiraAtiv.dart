// Primeira atividade: implementar, numa linguagem OO (sugestão: Dart), as classes discutidas em sala de aula, 
// com o algoritmo de total de uma venda sendo implementado SEM usar laços explícitos (for, while etc).

void main() {

  Produto produto1 = Produto(preco: 4.5, descricao: "Macarrão", dataValidade: "20/06/2023");
  Produto produto2 = Produto(preco: 22.0, descricao: "Leite de soja", dataValidade: "23/03/2023");
  Produto produto3 = Produto(preco: 26.0, descricao: "Body Splash Giovanna Baby", dataValidade: "20/02/2024");

  Item item1 = Item(quantidade: 6, produto: produto1);
  Item item2 = Item(quantidade: 3, produto: produto2);
  Item item3 = Item(quantidade: 2, produto: produto3);

  Venda venda = Venda(dataVenda: "13/03/2023", itens: [item1, item2, item3]);

  print("O total da venda é: R\$${venda.total()}");

}

class Item {
  double quantidade;
  Produto produto;
  
  Item({required this.quantidade, required this.produto});
  
  double total1() => this.quantidade * produto.preco;
  
}

class Produto {
  double preco;
  String descricao;
  String dataValidade;
  
  Produto({required this.preco, required this.descricao, required this.dataValidade});

}

class Venda {
  String dataVenda;
  List<Item> itens;
  
  double total() => itens.fold(0,(sum,element) => sum + element.total1());
  
  Venda({required this.dataVenda, required this.itens});
    
}
