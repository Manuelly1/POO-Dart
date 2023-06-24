import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../util/ordenador.dart';

enum TableStatus{idle,loading,ready,error}

enum ItemType{
  beer, coffee, nation, none;

  String get asString => '$name';

  List<String> get columns => this == coffee? ["Nome", "Origem", "Tipo"] :
                              this == beer? ["Nome", "Estilo", "IBU"]:
                              this == nation? ["Nome", "Capital", "Idioma","Esporte"]:
                              [] ;
  List<String> get properties => this == coffee? ["blend_name","origin","variety"] :
                              this == beer? ["name","style","ibu"]:
                              this == nation? ["nationality","capital","language","national_sport"]:
                              [] ;

}

class DataService{
  static const MAX_N_ITEMS = 15;
  static const MIN_N_ITEMS = 3;
  static const DEFAULT_N_ITEMS = 7;

  int _numberOfItems = DEFAULT_N_ITEMS;

  set numberOfItems(n){
    _numberOfItems = n < 0 ? MIN_N_ITEMS: n > MAX_N_ITEMS? MAX_N_ITEMS: n;
  }

  final ValueNotifier<Map<String,dynamic>> tableStateNotifier = ValueNotifier({
      'status':TableStatus.idle,
      'dataObjects':[],
      'itemType': ItemType.none
  });

  void carregar(index){
    final params = [ItemType.coffee, ItemType.beer, ItemType.nation];
    carregarPorTipo(params[index]);
  }

void ordenarEstadoAtual(String propriedade) {
    List objetos = tableStateNotifier.value['dataObjects'] ?? [];

    if (objetos == []) return;

    Ordenador ord = Ordenador();

    var objetosOrdenados = [];

    objetosOrdenados = ord.ordenar(objetos, propriedade);
  
    emitirEstadoOrdenado(objetosOrdenados, propriedade);
  }

  Uri montarUri(ItemType type){
    return Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: 'api/${type.asString}/random_${type.asString}',
      queryParameters: {'size': '$_numberOfItems'});
  }

  Future<List<dynamic>> acessarApi(Uri uri) async{
    var jsonString = await http.read(uri);
    var json = jsonDecode(jsonString);
    json = [...tableStateNotifier.value['dataObjects'], ...json];
    
    return json;
  }

  void emitirEstadoOrdenado(List objetosOrdenados, String propriedade){
    var estado = Map<String, dynamic>.from(tableStateNotifier.value);
    
    estado['dataObjects'] = objetosOrdenados;
    estado['sortCriteria'] = propriedade;
    estado['ascending'] = true;

    tableStateNotifier.value = estado;
  }

  void emitirEstadoCarregando(ItemType type){
    tableStateNotifier.value = {
        'status': TableStatus.loading,
        'dataObjects': [],
        'itemType': type
      };
  }

  void emitirEstadoPronto(ItemType type, var json){
    tableStateNotifier.value = {
        'itemType': type,
        'status': TableStatus.ready,
        'dataObjects': json,
        'propertyNames': type.properties,
        'columnNames': type.columns
      };
  }

  bool temRequisicaoEmCurso() => tableStateNotifier.value['status'] == TableStatus.loading;
  
  bool mudouTipoDeItemRequisitado(ItemType type) => tableStateNotifier.value['itemType'] != type;

  void carregarPorTipo(ItemType type) async{
    //ignorar solicitação se uma requisição já estiver em curso
    if (temRequisicaoEmCurso()) {
        return;
    } 
    if (mudouTipoDeItemRequisitado(type)){
      emitirEstadoCarregando(type);
    }

    var uri = montarUri(type);
    var json = await acessarApi(uri);

    emitirEstadoPronto(type, json);
  }
}
