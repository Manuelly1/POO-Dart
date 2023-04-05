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
            columns: const <DataColumn> [
              DataColumn(
                label: Text(
                  'Nome'
               //   style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Estilo'
                 // style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'IBU'
                 // style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('La Fin Du Monde')),
                DataCell(Text('Bock')),
                DataCell(Text('65')),
              ]),
              DataRow(cells: [
                DataCell(Text('Sapporo Premium')),
                DataCell(Text('Sour Ale')),
                DataCell(Text('54')),
              ]),
              DataRow(cells: [
                DataCell(Text('Duvel')),
                DataCell(Text('Plisner')),
                DataCell(Text('82')),
              ]),
              DataRow(cells: [
                DataCell(Text('Sierra Nevada Pale Ale')),
                DataCell(Text('American Pale Ale')),
                DataCell(Text('38')),
              ]),
              DataRow(cells: [
                DataCell(Text('Guinness Draught')),
                DataCell(Text('Irish Dry Stout')),
                DataCell(Text('45')),
              ]),
              DataRow(cells: [
                DataCell(Text('Samuel Adams Boston Lager')),
                DataCell(Text('Vienna Lager')),
                DataCell(Text('30')),
              ]),
              DataRow(cells: [
                DataCell(Text('La Fin Du Monde')),
                DataCell(Text('Belgian Tripel ')),
                DataCell(Text('19')),
              ]),
              DataRow(cells: [
                DataCell(Text('Miller Lite')),
                DataCell(Text('American Light Lager')),
                DataCell(Text('10')),
              ]),
              DataRow(cells: [
                DataCell(Text('Rogue Dead Guy Ale')),
                DataCell(Text('Maibock')),
                DataCell(Text('40')),
              ]),
              DataRow(cells: [
                DataCell(Text('Pilsner Urquell')),
                DataCell(Text('Czech Pilsner')),
                DataCell(Text('40')),
              ]),
              DataRow(cells: [
                DataCell(Text('Paulaner')),
                DataCell(Text('Munich Helles Lager')),
                DataCell(Text('18')),
              ]),
               DataRow(cells: [
                DataCell(Text('Heineken')),
                DataCell(Text('International Pale Lager')),
                DataCell(Text('23')),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
