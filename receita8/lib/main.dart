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
  });

  void carregar(int index) {
    final funcoes = [carregarCafes, carregarCervejas, carregarNacoes, carregarCartoes];
    
    tableStateNotifier.value = {
      'status': TableStatus.loading,
      'dataObjects': [],
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
        'columnNames': ['Nacionalidade', 'Idioma', 'Capital', 'Esporte Nac.'],
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
        'columnNames': ['Número do cartão de crédito', 'Data de vencimento', 'Tipo do cartão'],
        'propertyNames': ['credit_card_number', 'credit_card_expiry_date', 'credit_card_type']
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

class DataTableWidget extends StatefulWidget {
  final List<dynamic> jsonObjects;
  final List<String> columnNames;
  final List<String> propertyNames;
  final int initialSortColumnIndex;

  const DataTableWidget({
    required this.jsonObjects,
    required this.columnNames,
    required this.propertyNames,
    this.initialSortColumnIndex = 0,
  });

  @override

  _DataTableWidgetState createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
    late List<dynamic> sortedJsonObjects;
    late List<bool> sortAscending;
    late int currentSortColumnIndex;

    @override

    void initState() {
      super.initState();
      sortedJsonObjects = widget.jsonObjects;
      sortAscending = List<bool>.filled(widget.columnNames.length, true);
      currentSortColumnIndex = widget.initialSortColumnIndex;
      sortData(currentSortColumnIndex);
    }

    void sortData(int columnIndex) {
      setState(() {
        currentSortColumnIndex = columnIndex;
        final int sign = sortAscending[columnIndex] ? 1 : -1;
        sortedJsonObjects.sort((a, b) => sign * a[widget.propertyNames[columnIndex]].toString().compareTo(b[widget.propertyNames[columnIndex]].toString()));
        sortAscending[columnIndex] = !sortAscending[columnIndex];
      });
    }

    @override

    Widget build(BuildContext context) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: List<DataColumn>.generate(
            widget.columnNames.length,
            (index) => DataColumn(
              label: GestureDetector(
                child: Text(widget.columnNames[index]),
                onTap: () => sortData(index),
              ),
            ),
          ),
          rows: List<DataRow>.generate(
            sortedJsonObjects.length,
            (index) => DataRow(
              cells: List<DataCell>.generate(
                widget.columnNames.length,
                (cellIndex) => DataCell(
                  Text(sortedJsonObjects[index][widget.propertyNames[cellIndex]].toString()),
                ),
              ),
          ),
        ),
      ),
    );
  }
}
