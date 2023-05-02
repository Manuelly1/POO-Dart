import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DataService {
  final ValueNotifier<List> tableStateNotifier = new ValueNotifier([]);

  void carregar(int index) {
    if (index == 1) {
      carregarCervejas();
    } else if (index == 0) {
      carregarCafes();
    } else if (index == 2) {
      carregarNacoes();
    }
  }

  void carregarCervejas() {
    tableStateNotifier.value = [
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
    ];
  }

  void carregarCafes() {
    tableStateNotifier.value = [
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
    ];
  }

  void carregarNacoes() {
    tableStateNotifier.value = [
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
    ];
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
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Dicas"),
        ),
        body: ValueListenableBuilder(
          valueListenable: dataService.tableStateNotifier,
          builder: (_, value, __) {
            return DataTableWidget(
              jsonObjects: value,
              propertyNames: ["name", "style", "ibu"],
              columnNames: ["Nome", "Estilo", "IBU"],
            );
          },
        ),
        bottomNavigationBar: NewNavBar(onItemSelected: dataService.carregar),
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

  DataTableWidget({this.jsonObjects = const [], this.columnNames = const ["Nome", "Estilo", "IBU"], this.propertyNames = const ["name", "style", "ibu"]});

  @override
  
  Widget build(BuildContext context) {
    return DataTable(
        columns: columnNames
            .map(
              (name) => DataColumn(
                label: Expanded(child: Text(name, style: TextStyle(fontStyle: FontStyle.italic))),
              ),
            )
            .toList(),
        rows: jsonObjects
            .map(
              (obj) => DataRow(
                cells: propertyNames
                    .map(
                      (propName) => DataCell(Text(obj[propName] ?? "")),
                    )
                    .toList(),
              ),
            )
            .toList());
  }
}
