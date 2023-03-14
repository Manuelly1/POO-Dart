// Primeira atividade: implementar, numa linguagem OO (sugestão: Dart), as classes discutidas em sala de aula, 
// com o algoritmo de total de uma venda sendo implementado SEM usar laços explícitos (for, while etc).

void main() {

  Produto produto1 = Produto(preco: 4.5, descricao: "Macarrão", data: "20/06/2023");
  Produto produto2 = Produto(preco: 22.0, descricao: "Leite de soja", data: "23/03/2023");
  Produto produto3 = Produto(preco: 26.0, descricao: "Body Splash Giovanna Baby", data: "20/02/2024");

  Item item1 = Item(6, p1);
  Item iitem2 = Item(3, p2);
  Item item3 = Item(2, p3);

  Venda venda = Venda(data: "13/03/2023", itens: [item1, item2, item3]);

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
  String data;
  
  Produto({required this.preco, required this.descricao, required this.data});

}

class Venda {
  double data;
  List<Item> itens;
  
  double total() => itens.fold(0,(sum,element) => sum + element.total1());
  
  Venda({required this.data, required this.itens});
    
}