import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';



enum TableStatus{idle,loading,ready,error}
enum ItemType{beer, coffee, nation, none}




class DataService{

  

  final ValueNotifier<Map<String,dynamic>> tableStateNotifier 

                            = ValueNotifier({

                              'status':TableStatus.idle,

                              'dataObjects':[],
                              'itemType': ItemType.none

                            });

  

  void carregar(index){

    final funcoes = [carregarCafes, carregarCervejas, carregarNacoes];

    tableStateNotifier.value = {

      'status': TableStatus.loading,

      'dataObjects': []

    };

    funcoes[index]();

  }



  void carregarCafes(){

    var coffeesUri = Uri(

      scheme: 'https',

      host: 'random-data-api.com',

      path: 'api/coffee/random_coffee',

      queryParameters: {'size': '10'});



    http.read(coffeesUri).then( (jsonString){

      var coffeesJson = jsonDecode(jsonString);

      tableStateNotifier.value = {

        'status': TableStatus.ready,

        'dataObjects': coffeesJson,

        'propertyNames': ["blend_name","origin","variety"],

        'columnNames': ["Nome", "Origem", "Tipo"]

      };

    });

    

  }



  void carregarNacoes(){

    var nationsUri = Uri(

      scheme: 'https',

      host: 'random-data-api.com',

      path: 'api/nation/random_nation',

      queryParameters: {'size': '10'});



    http.read(nationsUri).then( (jsonString){

      var nationsJson = jsonDecode(jsonString);

      tableStateNotifier.value = {
        'itemType': ItemType.nation,

        'status': TableStatus.ready,

        'dataObjects': nationsJson,

        'propertyNames': ["nationality","capital","language","national_sport"],

        'columnNames': ["Nome", "Capital", "Idioma","Esporte"]

      };

    });

  }



  void carregarCervejas(){

    var beersUri = Uri(

      scheme: 'https',

      host: 'random-data-api.com',

      path: 'api/beer/random_beer',

      queryParameters: {'size': '10'});



    http.read(beersUri).then( (jsonString){

      var beersJson = jsonDecode(jsonString);

      tableStateNotifier.value = {
        'itemType': ItemType.nation,

        'status': TableStatus.ready,

        'dataObjects': beersJson,

        'propertyNames': ["name","style","ibu"],

        'columnNames': ["Nome", "Estilo", "IBU"]

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



  @override

  Widget build(BuildContext context) {

    return MaterialApp(

      

      theme: ThemeData(primarySwatch: Colors.deepPurple),

      debugShowCheckedModeBanner:false,

      home: Scaffold(

        appBar: AppBar( 

          title: const Text("Dicas"),

          ),

        body: ValueListenableBuilder(

          valueListenable: dataService.tableStateNotifier,

          builder:(_, value, __){

            switch (value['status']){

              case TableStatus.idle: 

                return Center(child: Text("Toque algum botão, abaixo..."));

              case TableStatus.loading:

                return Center(child: CircularProgressIndicator());

              case TableStatus.ready: 

                return ListWidget(

                  jsonObjects: value['dataObjects'], 

                  propertyNames: value['propertyNames'] 

                  

                );

              case TableStatus.error: 

                return Text("Lascou");

            }

            return Text("...");

            

          }

        ),

        bottomNavigationBar: NewNavBar(itemSelectedCallback: dataService.carregar),

      ));

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

            label: "Cervejas", icon: Icon(Icons.local_drink_outlined)),



        BottomNavigationBarItem(

          label: "Nações", icon: Icon(Icons.flag_outlined))

      ]);



  }



}


class ListWidget extends HookWidget {



  final List jsonObjects;

  final List<String> propertyNames;





class ListWidget extends HookWidget {

  final dynamic _scrollEndedCallback;



  final List jsonObjects;

  final List<String> propertyNames;



  ListWidget( {this.jsonObjects = const [], this.propertyNames= const [], void Function()? scrollEndedCallback }):

    _scrollEndedCallback = scrollEndedCallback ?? false;

    

  

  @override

  Widget build(BuildContext context) {

    var controller = useScrollController();

    useEffect(

      (){

        controller.addListener(

          (){

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

        var content = propertyNames

                        .sublist(1)

                        .map( (prop) => jsonObjects[index][prop] )

                        .join(" - ");



        return Card(     

          shadowColor: Theme.of(context).primaryColor,     

          child: Column( 

            children: [

              SizedBox(height: 10),

              //a primeira propriedade vai em negrito

              Text(                    

                "${title}\n",

                 style: TextStyle(fontWeight: FontWeight.bold)

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

