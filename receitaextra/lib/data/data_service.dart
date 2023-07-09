import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../util/decididor.dart';
import '../util/ordenador.dart';
import '../util/filtro.dart';

var valores = [3, 7, 15]; 

enum TableStatus { idle, loading, ready, error }
enum ItemType {food, bank, restaurant, none;

  String get asString => '$name';

  List<String> get columns => this == food ? ["Prato", "Ingrediente", "Medição"] : 
    this == bank ? ["Nome", "Número da conta", "Número de roteamento"] : 
    this == restaurant ? ["Nome", "Tipo", "Número de telefone"] :
    [];

  List<String> get properties => this == food ? ["dish", "ingredient", "measurement"] :
    this == bank ? ["bank_name", "account_number", "routing_number"] : 
    this == restaurant ? ["name", "type", "phone_number"] : 
    [];
}

class DataService {
  static int get MAX_N_ITEMS => valores[2];
  static int get MIN_N_ITEMS => valores[0];
  static int get DEFAULT_N_ITEMS => valores[1];

  int _numberOfItems = DEFAULT_N_ITEMS;

  set numberOfItems(n){
    _numberOfItems = n < 0 ? MIN_N_ITEMS: n > MAX_N_ITEMS? MAX_N_ITEMS: n;
  }

  final ValueNotifier<Map<String, dynamic>> tableStateNotifier = ValueNotifier({
    'status': TableStatus.idle,
    'dataObjects': [],
    'itemType': ItemType.none,
  });

  void carregar(index){
    final params = [ItemType.food, ItemType.restaurant, ItemType.food];

    carregarPorTipo(params[index]);  
  }

  void ordenarEstadoAtual(String propriedade, [bool cresc = true]) {
    List objetos = tableStateNotifier.value['dataObjects'] ?? [];

    if (objetos.isEmpty) return;

    Ordenador ord = Ordenador();

    var objetosOrdenados = [];
    bool crescente = cresc;

    bool precisaTrocar(atual, proximo) {
      final ordemCorreta = crescente ? [atual, proximo] : [proximo, atual];
      return ordemCorreta[0][propriedade].compareTo(ordemCorreta[1][propriedade]) > 0;
    }

    // objetosOrdenados = ord.ordenar(objetos, DecididorJson(propriedade, crescente).precisaTrocar, crescente);
    objetosOrdenados = ord.segundoOrdenar(objetos, precisaTrocar);

    emitirEstadoOrdenado(objetosOrdenados, propriedade);
  }

  void filtrarEstadoAtual(final String filtro) {
    List objetos = tableStateNotifier.value['previousObjects'] ?? [];
    
    if (objetos == []) return;

    List propriedades = tableStateNotifier.value['propertyNames'];

    Filtrador fil = Filtrador();

    DecididorFiltro d = DecididorFiltroJSON(propriedades);

    var objetosFiltrados = fil.filtrar(objetos, filtro, d.dentroDoFiltro);

    emitirEstadoFiltrado(objetos, objetosFiltrados, filtro);
  }


  Uri montarUri(ItemType type) {
      return Uri(
          scheme: 'https',
          host: 'random-data-api.com',
          path: 'api/${type.asString}/random_${type.asString}',
          queryParameters: {'size': '$_numberOfItems'});
  }
  
  Future<List<dynamic>> acessarApi(Uri uri) async {
    var jsonString = await http.read(uri);
    var json = jsonDecode(jsonString);

    json = [...tableStateNotifier.value['dataObjects'], ...json];

    return json;
  }

  void emitirEstadoFiltrado(List objetosOriginais, List objetosFiltrados, String filtro) {
    var estado = Map<String, dynamic>.from(tableStateNotifier.value);
    estado['previousObjects'] = objetosOriginais;
    estado['dataObjects'] = objetosFiltrados;
    estado['filterCriteria'] = filtro;
    tableStateNotifier.value = estado;
  }

  void emitirEstadoOrdenado(List objetosOrdenados, String propriedade){
    var estado = Map<String, dynamic>.from(tableStateNotifier.value);

    estado['dataObjects'] = objetosOrdenados;
    estado['sortCriteria'] = propriedade;
    estado['ascending'] = true;
    tableStateNotifier.value = estado;
  }

  void emitirEstadoCarregando(ItemType type) {
    tableStateNotifier.value = {
      'status': TableStatus.loading,
      'dataObjects': [],
      'itemType': type,
      'previousObjects': []
    };
  }

  void emitirEstadoPronto(ItemType type, var json) {
    tableStateNotifier.value = {
      'itemType': type,
      'status': TableStatus.ready,
      'dataObjects': json,
      'propertyNames': type.properties,
      'columnNames': type.columns,
      'previousObjects': json
    };
  }

  bool temRequisicaoEmCurso() =>
    tableStateNotifier.value['status'] == TableStatus.loading;

  bool mudouTipoDeItemRequisitado(ItemType type) =>
    tableStateNotifier.value['itemType'] != type;

  void carregarPorTipo(ItemType type) async {
    //ignorar solicitação se uma requisição já estiver em curso
    if (temRequisicaoEmCurso())
    {
      return;
    } 
    if (mudouTipoDeItemRequisitado(type)) {
      emitirEstadoCarregando(type);
    }

    var uri = montarUri(type);
    var json = await acessarApi(uri);

    emitirEstadoPronto(type, json);
  }
}

final dataService = DataService();

// decididor de ordenação
class DecididorJson implements Decididor {
  final String prop;
  final bool crescente;

  DecididorJson(this.prop, [this.crescente = true]);

  @override
  
  bool precisaTrocar(dynamic atual, dynamic proximo, bool crescente) {
    try {
      final ordemCorreta = crescente ? [atual, proximo] : [proximo, atual];
      return ordemCorreta[0][prop].compareTo(ordemCorreta[1][prop]) > 0;
    } catch (error) {
      return false;
    }
  }
}

class DecididorFiltroJSON extends DecididorFiltro {
  final List propriedades;

  DecididorFiltroJSON(this.propriedades);

  @override

  bool dentroDoFiltro(objeto, filtro) {
    bool achouAoMenosUm = false;
    for (int i=0; i<propriedades.length-1; i++) {
      achouAoMenosUm = objeto[propriedades[i]].contains(filtro) ? true : false;
      if (achouAoMenosUm) break;
    }
    return achouAoMenosUm;
  }
}