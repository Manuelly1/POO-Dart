import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:transparent_image/transparent_image.dart';

enum TableStatus { idle, loading, ready, error }

class DataService {
  final ValueNotifier<Map<String, dynamic>> tableStateNotifier = ValueNotifier({
    'status': TableStatus.idle,
    'dataObjects': [],
    'columnNames': [],
  });

  void carregar(int index) {
    final funcoes = [carregarCafes, carregarCervejas, carregarNacoes, carregarCartoes];
    tableStateNotifier.value = {
      'status': TableStatus.loading,
      'dataObjects': [],
      'columnNames': [],
    };

    funcoes[index]();
  }

  void carregarCafes() async {
    try {
      var coffeesUri = Uri(
          scheme: 'https',
          host: 'random-data-api.com',
          path: 'api/coffee/random_coffee',
          queryParameters: {'size': '5'});

      var jsonString = await http.read(coffeesUri);
      var coffeesJson = jsonDecode(jsonString);
      tableStateNotifier.value = {
        'status': TableStatus.ready,
        'dataObjects': coffeesJson,
        'columnNames': ['Nome', 'Origem', 'Variedade', 'Notas', 'Intensidade'],
        'propertyNames': ['blend_name', 'origin', 'variety', 'notes', 'intensifier']
      };
    } catch (error) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'dataObjects': [],
        'columnNames': [],
      };
    }
  }

  void carregarNacoes() async {
    try {
      var nationsUri = Uri(
          scheme: 'https',
          host: 'random-data-api.com',
          path: 'api/nation/random_nation',
          queryParameters: {'size': '5'});

      var jsonString = await http.read(nationsUri);
      var nationsJson = jsonDecode(jsonString);
      tableStateNotifier.value = {
        'status': TableStatus.ready,
        'dataObjects': nationsJson,
        'columnNames': ['Nacionalidade', 'Idioma', 'Capital', 'Esporte Nacional'],
        'propertyNames': ['nationality', 'language', 'capital', 'national_sport']
      };
    } catch (error) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'dataObjects': [],
        'columnNames': [],
      };
    }
  }

  void carregarCervejas() async {
    try {
      var beersUri = Uri(
          scheme: 'https',
          host: 'random-data-api.com',
          path: 'api/beer/random_beer',
          queryParameters: {'size': '5'});

      var jsonString = await http.read(beersUri);
      var beersJson = jsonDecode(jsonString);
      tableStateNotifier.value = {
        'status': TableStatus.ready,
        'dataObjects': beersJson,
        'columnNames': ["Nome", "Estilo", "IBU"],
        'propertyNames': ["name", "style", "ibu"],
      };
    } catch (error) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'dataObjects': [],
        'columnNames': [],
      };
    }
  }

  void carregarCartoes() async {
    var creditCardsUri = Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: 'api/v2/credit_cards',
      queryParameters: {'size': '5'}
    );

    try {
      var jsonString = await http.read(creditCardsUri);
      var creditCardsJson = jsonDecode(jsonString);
      tableStateNotifier.value = {
        'status': TableStatus.ready,
        'dataObjects': creditCardsJson,
        'columnNames': ['Número', 'Nome', 'Bandeira', 'Data de Validade'],
        'propertyNames': ['number', 'name', 'brand', 'expirationDate']
      };
    } catch (error) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'dataObjects': [],
        'columnNames': [],
      };
    }
  }
}

final dataService = DataService();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
         primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Bebidas e outras informações"),
        ),
        backgroundColor: Colors.grey,
        body: ValueListenableBuilder(
          valueListenable: dataService.tableStateNotifier,
          builder: (_, value, __) {
            switch (value['status']) {
              case TableStatus.idle:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: 'https://images.pexels.com/photos/3361170/pexels-photo-3361170.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                        width: 200,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Seja bem-vindo(a)!",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Selecione alguma das opções abaixo:",
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              case TableStatus.loading:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case TableStatus.ready:
                return DataTableWidget(
                  jsonObjects: value['dataObjects'],
                  columnNames: value['columnNames'],
                  propertyNames: value['propertyNames'],
                );
              case TableStatus.error:
                return Center(
                  child: Text(
                    "Ocorreu um erro ao carregar os dados. Verifique sua conexão de internet e tente novamente.",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                return Text("...");
            }
          },
        ),
        bottomNavigationBar: NewNavBar(itemSelectedCallback: dataService.carregar),
      ),
    );
  }
}

class NewNavBar extends HookWidget {
    final _itemSelectedCallback;

    NewNavBar({itemSelectedCallback}): _itemSelectedCallback = itemSelectedCallback ?? (int) {}

    @override
    
    Widget build(BuildContext context) {
      var state = useState(1);
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          state.value = index;
          _itemSelectedCallback(index);
        },
        currentIndex: state.value,
        items: const [
          BottomNavigationBarItem(
            label: "Cafés",
            icon: Icon(Icons.coffee_outlined),
          ),
          BottomNavigationBarItem(
              label: "Cervejas", 
              icon: Icon(Icons.local_drink_outlined)
          ),
          BottomNavigationBarItem(
              label: "Nações", 
              icon: Icon(Icons.flag_outlined)
          ),
          BottomNavigationBarItem(
              label: "Cartões de crédito",
              icon: Icon(Icons.credit_card_outlined)
          )
        ]
      );
    }
}


class DataTableWidget extends StatelessWidget {
    final List<dynamic> jsonObjects;
    final List<String> columnNames;
    final List<String> propertyNames;

    const DataTableWidget({
      required this.jsonObjects,
      required this.columnNames,
      required this.propertyNames,
    });

    @override
    
    Widget build(BuildContext context) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: List<DataColumn>.generate(
            columnNames.length,
            (index) => DataColumn(
              label: Text(columnNames[index]),
            ),
          ),
          rows: List<DataRow>.generate(
            jsonObjects.length,
            (index) => DataRow(
              cells: List<DataCell>.generate(
                columnNames.length,
                (cellIndex) => DataCell(
                  Text(jsonObjects[index][propertyNames[cellIndex]].toString()),
                ),
              ),
            ),
          ),
        ),
      );
    }
}
