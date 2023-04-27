import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

var dataObjects = [];

void main() {

  MyApp app = MyApp();
  runApp(app);

}


class MyApp extends StatelessWidget {
  
  @override

  Widget build(BuildContext context) {
    //print("no build da classe MyApp");

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


class NewNavBar extends HookWidget {

  NewNavBar();

  @override

  Widget build(BuildContext context) {    
    //print("no build da classe NewNavBar");

    var state = useState(1);

    return BottomNavigationBar(
      onTap: (index){
        state.value = index;
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
        )

      ]);

  }

}

class NewNavBar2 extends StatefulWidget {
  NewNavBar2();

  @override
  
  _NewNavBar2State createState() => _NewNavBar2State();
}

class _NewNavBar2State extends State<NewNavBar2> {
  
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  
  Widget build(BuildContext context) {
//    print("no build da classe NewNavBar2");
    return BottomNavigationBar(
      onTap: _onItemTapped,
      currentIndex: _selectedIndex,
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

class DataTableWidget extends StatelessWidget {

  final List jsonObjects;

  DataTableWidget( {this.jsonObjects = const [] });

  @override

  Widget build(BuildContext context) {
    //print("no build da classe DataTableWidget");    

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
