// interface gráfica
import 'package:flutter/material.dart';

TextStyle _boldTextStyle = TextStyle(
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    fontSize: 23,
    color: Colors.lightBlueAccent);

void main() {
  MaterialApp app = MaterialApp(
    theme: ThemeData(primarySwatch: Colors.pink),
    home: Scaffold(
      appBar: AppBar(title: Text("Artistas que valem à pena você conhecer")),
      body: Padding(
        padding: EdgeInsets.all(35.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("- Artcis Monkeys", style: _boldTextStyle),
                    Text("- Coldplay", style: _boldTextStyle),
                    Text("- Ed Sheeran", style: _boldTextStyle),
                    Text("- Cigarettes After Sex", style: _boldTextStyle),
                    SizedBox(height: 30),
                    Text("- Sleeping at Last", style: _boldTextStyle),
                    Text("- Twenty One Pilots", style: _boldTextStyle),
                    Text("- Imagine Dragons", style: _boldTextStyle),
                    Text("- Eric Clapton", style: _boldTextStyle),
                    SizedBox(height: 30),
                    Text("- Ludovico Einaudi", style: _boldTextStyle),
                    Text("- The Neighbourhood", style: _boldTextStyle),
                    Text("- Bruno Mars", style: _boldTextStyle),
                    Text("- The Weeknd", style: _boldTextStyle),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: AnimatedOpacity(
                  opacity: 2.0,
                  duration: Duration(seconds: 2),
                  curve: Curves.easeIn,
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSid_EwuhEaCucwdBrqILmUD94qUZvG9F5RbOip4xT8u_dfnBBzBJzn5dZDDpk2VN9AcQk&usqp=CAU',
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ElevatedButton(
            child: Row(
              children: [
                Icon(Icons.thumb_up),
              ],
            ),
            onPressed: () {
              // função que permite que o botão seja pressionado
            },
          ),
          ElevatedButton(
            child: Row(
              children: [
                Icon(Icons.thumbs_up_down),
              ],
            ),
            onPressed: () {},
          ),
          ElevatedButton(
            child: Row(
              children: [
                Icon(Icons.thumb_down),
              ],
            ),
            onPressed: () {},
          ),
        ],
      ),
    ),
  );

  runApp(app);
}
