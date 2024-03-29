import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum TableStatus{idle,loading,ready,error}
enum ItemType{beer, coffee, nation, none}

class DataService{
  final ValueNotifier<Map<String,dynamic>> tableStateNotifier = ValueNotifier({
        'status':TableStatus.idle,
        'dataObjects':[],
        'itemType': ItemType.none
    });

  void carregar(int index) {
    final funcoes = [carregarCafes, carregarCervejas, carregarNacoes];
    funcoes[index]();
  }

  void carregarCafes() {
    _carregarItens(ItemType.coffee, 'api/coffee/random_coffee', ['blend_name', 'origin', 'variety']);
  }

  void carregarNacoes() {
    _carregarItens(ItemType.nation, 'api/nation/random_nation', ['nationality', 'capital', 'language', 'national_sport']);
  }

  void carregarCervejas() {
    _carregarItens(ItemType.beer, 'api/beer/random_beer', ['name', 'style', 'ibu']);
  }

  void _carregarItens(ItemType itemType, String path, List<String> propertyNames) {
    // Ignorar solicitação se uma requisição já estiver em curso
    if (tableStateNotifier.value['status'] == TableStatus.loading) return;
    // Emitir estado de carregamento se os itens em exibição não forem do mesmo tipo
    if (tableStateNotifier.value['itemType'] != itemType) {
      tableStateNotifier.value = {
        'status': TableStatus.loading,
        'dataObjects': [],
        'itemType': itemType,
      };
    }

    var uri = Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: path,
      queryParameters: {'size': '10'},
    );
    http.read(uri).then((jsonString) {
      var itemsJson = jsonDecode(jsonString);

      // Se já houver itens no estado da tabela
      if (tableStateNotifier.value['status'] != TableStatus.loading) {
        itemsJson = [...tableStateNotifier.value['dataObjects'], ...itemsJson];
      }
      tableStateNotifier.value = {
        'itemType': itemType,
        'status': TableStatus.ready,
        'dataObjects': itemsJson,
        'propertyNames': propertyNames,
        'columnNames': propertyNames,
      };
    });
  }


}

final dataService = DataService();

void main() {
  MyApp app = MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {
  final functionsMap = {
    ItemType.beer: dataService.carregarCervejas,
    ItemType.coffee: dataService.carregarCafes,
    ItemType.nation: dataService.carregarNacoes
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: ValueListenableBuilder(
            valueListenable: dataService.tableStateNotifier,
            builder: (_, value, __) {
              int itemCount = value['dataObjects'].length;
              String itemCountText = itemCount > 0 ? '($itemCount)' : '';
              return Text('Dicas $itemCountText');
            },
          ),
        ),
        body: ValueListenableBuilder(
          valueListenable: dataService.tableStateNotifier,
          builder: (_, value, __) {
            switch (value['status']) {
              case TableStatus.idle:
                return Center(child: Text("Toque algum botão, abaixo..."));
              case TableStatus.loading:
                return Center(child: CircularProgressIndicator());
              case TableStatus.ready:
                return ListWidget(
                  jsonObjects: value['dataObjects'],
                  propertyNames: value['propertyNames'],
                  scrollEndedCallback: functionsMap[value['itemType']],
                );
              case TableStatus.error:
                return Text("Lascou");
            }
            return Text("...");
          },
        ),
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: dataService.tableStateNotifier,
          builder: (_, value, __) {
            int itemCount = value['dataObjects'].length;

            return NewNavBar(
              itemSelectedCallback: (index) => dataService.carregar(index),
            );
          },
        ),
      ),
    );
  }
}


class NewNavBar extends HookWidget {
  final _itemSelectedCallback;

  NewNavBar({itemSelectedCallback}) : _itemSelectedCallback = itemSelectedCallback ?? (int) {}

  @override
  Widget build(BuildContext context) {
    var state = useState(1);

    return BottomNavigationBar(
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
          icon: Icon(Icons.local_drink_outlined),
        ),
        BottomNavigationBarItem(
          label: "Nações",
          icon: Icon(Icons.flag_outlined),
        ),
      ],
    );
  }
}


class ListWidget extends HookWidget {
  final dynamic _scrollEndedCallback;
  final List jsonObjects;
  final List<String> propertyNames;

  ListWidget( {this.jsonObjects = const [], this.propertyNames= const [], void Function()? scrollEndedCallback }):
    _scrollEndedCallback = scrollEndedCallback ?? false;

  @override

  Widget build(BuildContext context) {
    var controller = useScrollController();
    useEffect((){controller.addListener((){
        if (controller.position.pixels == controller.position.maxScrollExtent){
          print('end reached');
          if (_scrollEndedCallback is Function)
            _scrollEndedCallback();
        }
      },

    );
    },[controller]
    );

    return ListView.separated(    
      controller: controller,
      padding: EdgeInsets.all(10),
      separatorBuilder: (_,__) => Divider(
          height: 5,
          thickness: 2,
          indent: 10,
          endIndent: 10,
          color: Theme.of(context).primaryColor,
        ),
      itemCount: jsonObjects.length+1,
      itemBuilder: (_, index){
        if (index==jsonObjects.length)
          return Center(child: LinearProgressIndicator());
        
        var title = jsonObjects[index][propertyNames[0]];
        var content = propertyNames.sublist(1).map( (prop) => jsonObjects[index][prop] ).join(" - ");

        return Card(     
          shadowColor: Theme.of(context).primaryColor,     
          child: Column( 
            children: [
              SizedBox(height: 10),
              //a primeira propriedade vai em negrito
              Text("${title}\n",style: TextStyle(fontWeight: FontWeight.bold)
              ),
              //as demais vão normais
              Text(content),
              SizedBox(height: 10)
            ]
          )
        ); 
      },
    );
  }
}
