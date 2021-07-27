import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var player = AudioCache();
  Map<String, bool> score = {};
  Map<String, List> choices = {
    '🍎': [
      Colors.red,
      ['Apple', 'تفاحة']
    ],
    '🍋': [
      Colors.yellow,
      ['Lemon', 'ليمونة']
    ],
    '🍊': [
      Colors.orange,
      ['Orange', 'برتقالة']
    ],
    '🍇': [
      Colors.purpleAccent,
      ['Grapes', 'عنب']
    ],
    '🍐': [
      Colors.lightGreenAccent,
      ['Pear', 'كمثري']
    ],
    '🍉': [
      Colors.green,
      ['Watermelon', 'بطيخة']
    ],
    '🥥': [
      Colors.brown,
      ['Coconut', 'جوز هند']
    ],
  };
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          'Let us learn from fruits.!',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: choices.keys.map((element) {
                return Draggable<String>(
                  data: element,
                  child: Movable(
                    emoji: score[element] == true ? '✔' : element,
                  ),
                  feedback: Movable(
                    emoji: element,
                  ),
                  childWhenDragging: Movable(
                    emoji: '🐰',
                  ),
                );
              }).toList()
                ..shuffle(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: choices.keys.map((element) {
                return buildTarget(element);
              }).toList()
                ..shuffle(),
            ),
          ],
        )
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        backgroundColor: Colors.redAccent,
        onPressed: () {
          setState(() {
            score.clear();
          });
        },
      ),
    );
  }

  Widget buildTarget(element) {
    return DragTarget<String>(
      builder: (context, incoming, rejected) {
        if (score[element] == true) {
          return Container(
            margin: EdgeInsets.all(8),
            child: Text(
              'Congratulations!',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            color: Colors.white,
            alignment: Alignment.center,
            height: 80,
            width: 200,
          );
        } else {
          return Container(
            margin: EdgeInsets.all(8),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    choices[element][1][1],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    choices[element][1][0],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
            color: choices[element][0],
            alignment: Alignment.center,
            height: 80,
            width: 200,
          );
        }
      },
      onWillAccept: (data) => data == element,
      onAccept: (data) {
        setState(() {
          print(data);
          score[element] = true;
          player.play('clap.mp3');
        });
      },
      onLeave: (data) => null,
    );
  }
}

class Movable extends StatelessWidget {
  String emoji;
  Movable({this.emoji});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(15),
        height: 100,
        child: Center(
          child: Text(
            emoji,
            style: TextStyle(
              fontSize: 60,
            ),
          ),
        ),
      ),
    );
  }
}
