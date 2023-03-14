// Primeira atividade: implementar, numa linguagem OO (sugestão: Dart), as classes discutidas em sala de aula, 
// com o algoritmo de total de uma venda sendo implementado SEM usar laços explícitos (for, while etc).

void main() {

  Produto massa = Produto(preco: 4.5, descricao: "Macarrão", dataValidade: "20/06/2023");
  Produto leite = Produto(preco: 16.0, descricao: "Leite de soja", dataValidade: "23/03/2023");
  Produto perfume = Produto(preco: 26.0, descricao: "Body Splash Giovanna Baby", dataValidade: "20/02/2024");

  Item pacotes = Item(quantidade: 6, produto: massa);
  Item caixas = Item(quantidade: 3, produto: leite);
  Item frascos = Item(quantidade: 2, produto: perfume);

  Venda venda = Venda(dataVenda: "13/03/2023", itens: [pacotes, caixas, frascos]);

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
