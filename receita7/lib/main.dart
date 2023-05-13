import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:convert';

class DataService {
  final ValueNotifier<List<Map<String, dynamic>>> tableStateNotifier =
      ValueNotifier([]);

  void carregar(int index) async {
    if (index == 0) {
      await carregarCafes();
    } else if (index == 1) {
      await carregarCervejas();
    } else if (index == 2) {
      await carregarNacoes();
    }
  }

  Future<void> carregarCervejas() async {
    var beersUri = Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: 'api/beer/random_beer',
      queryParameters: {'size': '5'},
    );

    var jsonString = await http.read(beersUri);
    var beersJson = jsonDecode(jsonString);

    tableStateNotifier.value = List.from(beersJson); 
  }

  Future<void> carregarCafes() async {
    var coffeeUri = Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: 'api/coffee/random_coffee',
      queryParameters: {'size': '5'},
    );

    var jsonString = await http.read(coffeeUri);
    var coffeesJson = jsonDecode(jsonString);

    tableStateNotifier.value = List.from(coffeesJson); 
  }

  Future<void> carregarNacoes() async {
    var nationsUri = Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: 'api/nation/random_nation',
      queryParameters: {'size': '5'},
    );

    var jsonString = await http.read(nationsUri);
    var nationsJson = jsonDecode(jsonString);

    tableStateNotifier.value = List.from(nationsJson); 
  }
}

final dataService = DataService();

void main() {

  MyApp app = MyApp();
  runApp(app);

}

class MyApp extends StatefulWidget {
  
  @override
  
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DataService dataService = DataService();

  int _selectedIndex = 0;

  static const List<Map<String, dynamic>> _navBarItems = [
    {
      'label': 'Cafés',
      'icon': Icon(Icons.coffee_outlined),
      'columnNames': ['Nome', 'Origem', 'Variedade', 'Notas', 'Intensidade'],
      'propertyNames': ['blend_name', 'origin', 'variety', 'notes', 'intensifier'],
    },
    {
      'label': 'Cervejas',
      'icon': Icon(Icons.local_drink_outlined),
      'columnNames': ['Nome', 'Estilo', 'IBU'],
      'propertyNames': ['name', 'style', 'ibu'],
    },
    {
      'label': 'Nações',
      'icon': Icon(Icons.flag_outlined),
      'columnNames': ['Nacionalidade', 'Idioma', 'Capital', 'Esporte Nac'],
      'propertyNames': ['nationality', 'language', 'capital', 'national_sport'],
    },
  ];

  @override
  
  void initState() {
    super.initState();
    dataService.carregar(_selectedIndex);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      dataService.carregar(_selectedIndex);
    });
  }

  @override
  
  Widget build(BuildContext context) {
    final navBarItem = _navBarItems[_selectedIndex];
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dicas'),
        ),
        body: ValueListenableBuilder<List<Map<String, dynamic>>>(
          valueListenable: dataService.tableStateNotifier,
          builder: (context, value, child) {
            return DataTableWidget(
              jsonObjects: value,
              columnNames: navBarItem['columnNames'],
              propertyNames: navBarItem['propertyNames'],
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            for (var item in _navBarItems)
              BottomNavigationBarItem(
                label: item['label'],
                icon: item['icon'],
              ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}



class NewNavBar extends HookWidget {
  final _itemSelectedCallback;
  NewNavBar({itemSelectedCallback}):
    _itemSelectedCallback = itemSelectedCallback ?? (int){}

  @override

  Widget build(BuildContext context) {
    var state = useState(1);
    return BottomNavigationBar(
      onTap: (index){
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
            icon: Icon(Icons.local_drink_outlined)),
        BottomNavigationBarItem(
          label: "Nações",
          icon: Icon(Icons.flag_outlined))
      ]
    );
  }

}


class DataTableWidget extends StatelessWidget {
    final List jsonObjects;
    final List<String> columnNames;
    final List<String> propertyNames;

    DataTableWidget({this.jsonObjects = const [], this.columnNames = const [], this.propertyNames = const []});

    @override
    
    Widget build(BuildContext context) {
      return DataTable(
          columns: columnNames
              .map(
                (name) => DataColumn(
                  label: Expanded(child: Text(name, style: TextStyle(fontStyle: FontStyle.italic))),
                ),
              ).toList(),
          rows: jsonObjects
              .map(
                (obj) => DataRow(
                  cells: propertyNames
                      .map(
                        (propName) => DataCell(Text(obj[propName] ?? "")),
                      ).toList(),
                ),
              ).toList()
            );
    }
}
