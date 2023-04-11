import 'package:flutter/material.dart';
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

        body: DataBodyWidget(objects:[

          "La Fin Du Monde - Bock - 65 ibu",

          "Sapporo Premiume - Sour Ale - 54 ibu",

          "Duvel - Pilsner - 82 ibu"

        ]),

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

          label: "Cervejas", icon: Icon(Icons.local_drink_outlined)),

      BottomNavigationBarItem(label: "Nações", icon: Icon(Icons.flag_outlined))

    ]);

  }

}

class DataBodyWidget extends StatelessWidget {

  List<String> objects;

  DataBodyWidget( {this.objects = const [] });



  Expanded processarUmElemento(String obj){

    return Expanded(                

          child: Center(child: Text(obj)),

        );

  }



  @override

  Widget build(BuildContext context) {

    List<Expanded> allTheLines = objects.map( 

      (obj) => Expanded(

        child: Center(child: Text(obj)),

        )

      ).toList();

    return Column(children: allTheLines);

  }

}