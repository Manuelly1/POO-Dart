import 'package:flutter/material.dart';

var dataObjects = [
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
  },
  
  {
    "name": "American Pale Ale", 
    "style": "Pale Ale", 
    "ibu": "30-50"
  },
  
  {
    "name": "India Pale Ale", 
    "style": "India Pale Ale", 
    "ibu": "40-60"
  },
  
  {
    "name": "Stout", 
    "style": "Stout", 
    "ibu": "30-60"
  },
  
  {
    "name": "Belgian Witbier", 
    "style": "Witbier", 
    "ibu": "10-20"
  },
  
  {
    "name": "Pilsner", 
    "style": "Pilsner", 
    "ibu": "25-45"
  },
  
  {
    "name": "Brown Ale", 
    "style": "Brown Ale", 
    "ibu": "20"
  },
  
  {
    "name": "Hefeweizen", 
    "style": "Weissbier ", 
    "ibu": "10-15"
  },
  
  {
    "name": "Double IPA", 
    "style": " Double India Pale Ale", 
    "ibu": "60-120"
  },
  
  {
    "name": "Saison", 
    "style": "Farmhouse Ale", 
    "ibu": "20-35"
  }

];


void main() {
  //MyApp app = MyApp();
  newMyApp app = newMyApp();

  runApp(app);
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
          body: Center(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataBodyWidget(
                      objects: dataObjects,
                      columnNames: ["Nome", "Estilo", "IBU"],
                      propertyNames: ["name", "style", "ibu"]
                    )
                  )
                ),
          bottomNavigationBar: NewNavBar(),
        ));
  }
}

class NewNavBar extends StatelessWidget {
  NewNavBar();

  void botaoFoiTocado(int index) {
    print("Tocaram no botão $index");
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(onTap: botaoFoiTocado, items: const [
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
    ]);
  }
}

class newMyApp extends StatelessWidget { //para a class MytileWidget
  
  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Dicas"),
          ),
          body: Center(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: MytileWidget(
                      objects: dataObjects,
                      columnNames: ["Nome", "Estilo", "IBU"],
                      propertyNames: ["name", "style", "ibu"]
                    )
                  )
                ),
          bottomNavigationBar: NewNavBar(),
        ));
  }
}

class MytileWidget extends StatelessWidget { 
  final List<Map<String, dynamic>> objects;
  final List<String> columnNames;
  final List<String> propertyNames;

  MytileWidget({this.objects = const [],this.columnNames = const [], this.propertyNames = const []});

  @override
  
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: objects.length,
      itemBuilder: (context, index) {
        final obj = objects[index];

        return ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: columnNames.length,
                itemBuilder: (context, index){
                  return Text('${columnNames[index]}: ${obj[propertyNames[index]]}');
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: propertyNames.length,
                itemBuilder: (context, index) {
                  return Text('${propertyNames[index]}: ${obj[propertyNames[index]]}');
                },
              )
            ],
          ),
        );
      },
    );
  }
}

class DataBodyWidget extends StatelessWidget {
  List<Map<String, dynamic>> objects;
  List<String> columnNames;
  List<String> propertyNames;

  DataBodyWidget({this.objects = const [], this.columnNames = const [], this.propertyNames = const []});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: columnNames.map((name) => DataColumn(
        label: Expanded(
          child: Text(name, style: TextStyle(fontStyle: FontStyle.italic)))
          )
        ).toList(),
        
      rows: objects.map((obj) => DataRow(
        cells: propertyNames.map((propName) => DataCell(Text(obj[propName]))
        ).toList()))
        .toList());
  }
}
