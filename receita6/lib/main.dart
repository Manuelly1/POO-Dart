import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DataService {
  final ValueNotifier<List> tableStateNotifier = new ValueNotifier([]);

  final Map<int, List<Map<String, String>>> _dataMap = {
    0: [
      {
        "name": "Café brasileiro",
        "type": "Arábica",
        "strength": "Médio"
      },
      {
        "name": "Café colombiano",
        "type": "Arábica",
        "strength": "Forte"
      },
      {
        "name": "Café turco",
        "type": "Robusta",
        "strength": "Muito forte"
      }
    ],
    
    1: [
      {
        "name": "La Fin Du Monde",
        "style": "Bock",
        "ibu": "65"
      },
      {
        "name": "Sapporo Premiume",
        "style": "Sour Ale",
        "ibu": "54"
      },
      {
        "name": "Duvel",
        "style": "Pilsner",
        "ibu": "82"
      }
    ],

    2: [
      {
        "name": "Brasil",
        "continent": "América do Sul",
        "population": "213,3 milhões"
      },
      {
        "name": "Japão",
        "continent": "Ásia",
        "population": "126,5 milhões"
      },
      {
        "name": "Itália",
        "continent": "Europa",
        "population": "60,4 milhões"
      }
    ],
  };

  void carregar(int index) {
    tableStateNotifier.value = _dataMap[index] ?? [];
  }
}


void main() {
  runApp(MyApp());
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
      'columnNames': ['Nome', 'Tipo', 'Intensidade'],
      'propertyNames': ['name', 'type', 'strength'],
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
      'columnNames': ['Nome', 'Continente', 'População'],
      'propertyNames': ['name', 'continent', 'population'],
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
        body: ValueListenableBuilder<List>(
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
  final void Function(int)? onItemSelected;

  NewNavBar({this.onItemSelected});

  @override
  
  Widget build(BuildContext context) {
    var state = useState(1);
    return BottomNavigationBar(
        onTap: (index) {
          state.value = index;
          onItemSelected?.call(index);
        },
        currentIndex: state.value,
        items: const [
          BottomNavigationBarItem(
            label: "Cafés",
            icon: Icon(Icons.coffee_outlined),
          ),
          BottomNavigationBarItem(
            label: "Cervejas",
            icon: Icon(Icons.local_drink_outlined),
          ),
          BottomNavigationBarItem(
            label: "Nações",
            icon: Icon(Icons.flag_outlined),
          )
        ]);
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
