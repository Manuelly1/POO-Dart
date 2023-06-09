import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


enum TableStatus{idle,loading,ready,error}
enum ItemType{beer, coffee, nation, none}

class DataService{
  static const MAX_N_ITEMS = 15;
  static const MIN_N_ITEMS = 3;
  static const DEFAULT_N_ITEMS = 7;

  int _numberOfItems = DEFAULT_N_ITEMS;

  set numberOfItems(n){
    _numberOfItems = n < 0 ? MIN_N_ITEMS: n > MAX_N_ITEMS? MAX_N_ITEMS: n;
  }

  int get numberOfItems {
    return _numberOfItems;
  }

  final ValueNotifier<Map<String,dynamic>> tableStateNotifier = ValueNotifier({
        'status':TableStatus.idle,
        'dataObjects':[],
        'itemType': ItemType.none
  });
  
  bool cafeSelected = false;
  bool cervejaSelected = false;
  bool nacoesSelected = false;

  void carregar(index) {
    final funcoes = [carregarCafes, carregarCervejas, carregarNacoes];

    // Desmarca todos os itens de menu
    cafeSelected = false;
    cervejaSelected = false;
    nacoesSelected = false;

    // Marca o item de menu selecionado
    if (index == 0) {
      cafeSelected = true;
    } else if (index == 1) {
      cervejaSelected = true;
    } else if (index == 2) {
      nacoesSelected = true;
    }

    funcoes[index]();
  }

  void carregarDados(ItemType itemType, String path, List<String> propertyNames, List<String> columnNames) {
    //ignorar solicitação se uma requisição já estiver em curso
    if (tableStateNotifier.value['status'] == TableStatus.loading) return;
    if (tableStateNotifier.value['itemType'] != itemType) {
      tableStateNotifier.value = {
        'status': TableStatus.loading,
        'dataObjects': [],
        'itemType': itemType
      };
    }

    var uri = Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: path,
      queryParameters: {'size': '$_numberOfItems'},
    );

    http.read(uri).then((jsonString) {
      var jsonData = jsonDecode(jsonString);
      //se já houver dados no estado da tabela...
      if (tableStateNotifier.value['status'] != TableStatus.loading) {
        jsonData = [...tableStateNotifier.value['dataObjects'], ...jsonData];
      }
      tableStateNotifier.value = {
        'itemType': itemType,
        'status': TableStatus.ready,
        'dataObjects': jsonData,
        'propertyNames': propertyNames,
        'columnNames': columnNames,
      };
    });
  }

  void carregarCafes() {
    carregarDados(
      ItemType.coffee,
      'api/coffee/random_coffee',
      ["blend_name", "origin", "variety"],
      ["Nome", "Origem", "Tipo"],
    );
  }

  void carregarNacoes() {
    carregarDados(
      ItemType.nation,
      'api/nation/random_nation',
      ["nationality", "capital", "language", "national_sport"],
      ["Nome", "Capital", "Idioma", "Esporte"],
    );
  }

  void carregarCervejas() {
    carregarDados(
      ItemType.beer,
      'api/beer/random_beer',
      ["name", "style", "ibu"],
      ["Nome", "Estilo", "IBU"],
    );
  }
}

final dataService = DataService();