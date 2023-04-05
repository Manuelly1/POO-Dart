import 'package:flutter/material.dart';

void projeto2() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabela de cervejas',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cervejas', style: TextStyle(color: Colors.black38)),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text('Nome'
                    //   style: TextStyle(fontStyle: FontStyle.italic),
                    ),
              ),
              DataColumn(
                label: Text('Estilo'
                    // style: TextStyle(fontStyle: FontStyle.italic),
                    ),
              ),
              DataColumn(
                label: Text('IBU'
                    // style: TextStyle(fontStyle: FontStyle.italic),
                    ),
              ),
              DataColumn(
                label: Text('Local de fabricação'),
              ),
              DataColumn(
                label: Text('Teor alcoólico'))
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('La Fin Du Monde')),
                DataCell(Text('Bock')),
                DataCell(Text('65')),
                DataCell(Text('Canadá')),
                DataCell(Text('9% de álcool')),
              ]),
              DataRow(cells: [
                DataCell(Text('Sapporo Premium')),
                DataCell(Text('Sour Ale')),
                DataCell(Text('54')),
                DataCell(Text('Estados Unidos')),
                DataCell(Text('4,9% de álcool')),
              ]),
              DataRow(cells: [
                DataCell(Text('Duvel')),
                DataCell(Text('Plisner')),
                DataCell(Text('82')),
                DataCell(Text('Bélgica')),
                DataCell(Text('8,5% de álcool')),
              ]),
              DataRow(cells: [
                DataCell(Text('Sierra Nevada Pale Ale')),
                DataCell(Text('American Pale Ale')),
                DataCell(Text('38')),
                DataCell(Text('Estados Unidos')),
                DataCell(Text('5,6% de álcool')),
              ]),
              DataRow(cells: [
                DataCell(Text('Guinness Draught')),
                DataCell(Text('Irish Dry Stout')),
                DataCell(Text('45')),
                DataCell(Text('Irlanda')),
                DataCell(Text('4,1% de álcool')),
              ]),
              DataRow(cells: [
                DataCell(Text('Samuel Adams Boston Lager')),
                DataCell(Text('Vienna Lager')),
                DataCell(Text('30')),
                DataCell(Text('Estados Unidos')),
                DataCell(Text('5,0% de álcool')),
              ]),
              DataRow(cells: [
                DataCell(Text('La Fin Du Monde')),
                DataCell(Text('Belgian Tripel ')),
                DataCell(Text('19')),
                DataCell(Text('Canadá')),
                DataCell(Text('9,0% de álcool')),
              ]),
              DataRow(cells: [
                DataCell(Text('Miller Lite')),
                DataCell(Text('American Light Lager')),
                DataCell(Text('10')),
                DataCell(Text('Estados Unidos')),
                DataCell(Text('5,0% de álcool')),
              ]),
              DataRow(cells: [
                DataCell(Text('Rogue Dead Guy Ale')),
                DataCell(Text('Maibock')),
                DataCell(Text('40')),
                DataCell(Text('Estados Unidos')),
                DataCell(Text('6,6% de álcool')),
              ]),
              DataRow(cells: [
                DataCell(Text('Pilsner Urquell')),
                DataCell(Text('Czech Pilsner')),
                DataCell(Text('40')),
                DataCell(Text('República Tcheca')),
                DataCell(Text('4,4% de álcool')),
              ]),
              DataRow(cells: [
                DataCell(Text('Paulaner')),
                DataCell(Text('Munich Helles Lager')),
                DataCell(Text('18')),
                DataCell(Text('Alemanha')),
                DataCell(Text('5,5% de álcool')),
              ]),
              DataRow(cells: [
                DataCell(Text('Heineken')),
                DataCell(Text('International Pale Lager')),
                DataCell(Text('23')),
                DataCell(Text('Holanda')),
                DataCell(Text('4,5% de álcool')),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
