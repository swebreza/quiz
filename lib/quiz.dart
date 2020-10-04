import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'quiz_complete.dart';
import 'package:audioplayers/audio_cache.dart';
import 'home.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class getjson extends StatelessWidget {
  String categoryname;
  getjson(this.categoryname);
  String assettoload;

  setasset() {
    assettoload = "assets/Categories/Movie.json";
  }

  @override
  Widget build(BuildContext context) {
    setasset();

    return FutureBuilder(
      future:
      DefaultAssetBundle.of(context).loadString(assettoload, cache: false),
      builder: (context, snapshot) {
        List mydata = json.decode(snapshot.data.toString());
        if (mydata == null) {
          return Scaffold(
            body: Center(
              child: Text(
                "Loading",
              ),
            ),
          );
        } else {
          return quizpage(mydata: mydata);
        }
      },
    );
  }
}

class quizpage extends StatefulWidget {
  final List mydata;

  quizpage({Key key, @required this.mydata}) : super(key: key);
  @override
  _quizpageState createState() => _quizpageState(mydata);
}

class _quizpageState extends State<quizpage> {
  final List mydata;
  _quizpageState(this.mydata);

  Color colortoshow = Colors.deepPurpleAccent;
  int marks = 0;
  int i = 1;
  bool disableAnswer = false;
  int j = 2;
  int timer = 15;
  String showtimer = "15";
  final player = AudioCache();
  Map<String, Color> btncolor = {
    "a": Colors.deepPurpleAccent,
    "b": Colors.deepPurpleAccent,
    "c": Colors.deepPurpleAccent,
    "d": Colors.deepPurpleAccent,
  };

  bool canceltimer = false;

  @override
  void initState() {
    starttimer();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void starttimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextquestion();
        } else if (canceltimer == true) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
        showtimer = timer.toString();
      });
    });
  }

  void nextquestion() {
    canceltimer = false;
    timer = 15;
    setState(() {
      if (mydata[2][j.toString()]!=null) {
        i = j;
        j++;
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => resultpage(marks: marks),
        ));
      }
      btncolor["a"] = Colors.deepPurpleAccent;
      btncolor["b"] = Colors.deepPurpleAccent;
      btncolor["c"] = Colors.deepPurpleAccent;
      btncolor["d"] = Colors.deepPurpleAccent;
      disableAnswer = false;
    });
    starttimer();
  }

  void checkanswer(String k) {
    if (mydata[2][i.toString()] == mydata[1][i.toString()][k]) {
      marks = marks + 1;
    }

    Timer(Duration(milliseconds: 1499), nextquestion);
    setState(() {
      canceltimer = true;
      disableAnswer = true;
      if (mydata[2][i.toString()] == mydata[1][i.toString()]['a']) {
        btncolor['a'] = Colors.green[500];
      }
      if (mydata[2][i.toString()] == mydata[1][i.toString()]['b']) {
        btncolor['b'] = Colors.green[500];
      }
      if (mydata[2][i.toString()] == mydata[1][i.toString()]['c']) {
        btncolor['c'] = Colors.green[500];
      }
      if (mydata[2][i.toString()] == mydata[1][i.toString()]['d']) {
        btncolor['d'] = Colors.green[500];
      }
      if (mydata[2][i.toString()] != mydata[1][i.toString()][k]) {
        btncolor[k] = Colors.red[500];
        player.play('wrong_ans.wav');
      }
      else{
        player.play('right_ans.wav');
      }
    });
  }

  Widget choicebutton(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: () => checkanswer(k),
        child: Text(
          mydata[1][i.toString()][k],
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Alike",
            fontSize: 16.0,
          ),
          maxLines: 1,
        ),
        color: btncolor[k],
        minWidth: 200.0,
        height: 45.0,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          return showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text("You want to exit"),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));canceltimer = false;
                    },
                    child: Text(
                      'Yes',
                    ),
                  )
                ],
              ));
        },
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              ClipPath(
                clipper: WaveClipperTwo(),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.pinkAccent,
                        Colors.deepPurpleAccent,
                      ])),
                  height: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white70,
                          child: Text(
                            "$i",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Expanded(
                          child: Text(
                            mydata[0][i.toString()],
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 150.0),
                    Column(
                      children: <Widget>[
                        choicebutton('a'),
                        choicebutton('b'),
                        choicebutton('c'),
                        choicebutton('d'),
                      ],
                    ),
                    SizedBox(height: 120),
                    Column(
                      children: <Widget>[
                        Text(
                          showtimer,
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Times New Roman',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
