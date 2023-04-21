import 'package:flutter/material.dart';

var dataObjects = [];

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

        body: DataTableWidget(jsonObjects:dataObjects),

        bottomNavigationBar: NewNavBar(),

      ));

  }

}



class NewNavBar extends StatelessWidget {

  NewNavBar();



  void buttonTapped(int index) {

    print("Tocaram no botão $index");

  }



  @override

  Widget build(BuildContext context) {

    return BottomNavigationBar(onTap: buttonTapped, items: const [

      BottomNavigationBarItem(

        label: "Cafés",

        icon: Icon(Icons.coffee_outlined),

      ),

      BottomNavigationBarItem(

          label: "Cervejas", icon: Icon(Icons.local_drink_outlined)),

      BottomNavigationBarItem(label: "Nações", icon: Icon(Icons.flag_outlined))

    ]);

  }

}



class DataTableWidget extends StatelessWidget {

  final List jsonObjects;

  DataTableWidget( {this.jsonObjects = const [] });



  @override

  Widget build(BuildContext context) {

    

    var columnNames = ["Nome","Estilo","IBU"],

        propertyNames = ["name", "style", "ibu"];

    

    return DataTable(

      columns: columnNames.map( 

                (name) => DataColumn(

                  label: Expanded(

                    child: Text(name, style: TextStyle(fontStyle: FontStyle.italic))

                  )

                )

              ).toList(),

      rows: jsonObjects.map( 

        (obj) => DataRow(

            cells: propertyNames.map(

              (propName) => DataCell(Text(obj[propName]))

            ).toList()

          )

        ).toList());

  }

}