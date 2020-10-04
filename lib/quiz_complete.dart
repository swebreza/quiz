import 'package:flutter/material.dart';
import 'package:opentrivia/home.dart';

class resultpage extends StatefulWidget {
  int marks;
  resultpage({Key key , @required this.marks}) : super(key : key);
  @override
  _resultpageState createState() => _resultpageState(marks);
}

class _resultpageState extends State<resultpage> {

  int marks;
  _resultpageState(this.marks);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 33,color: Colors.white70),),
        elevation: 10,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Material(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      child: Container(
                        width: 300.0,
                        height: 300.0,
                        child: ClipRect(
                          child: Image(
                            image: AssetImage(
                                "assets/Images/Fun.png" ),),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 15.0,
                        ),
                        child: Center(
                          child: Text(
                            "You Scored $marks",
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Quando",
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
                  },
                  color: Colors.cyan,
                  child: Text("Continue", style: TextStyle(fontSize: 20.0,color: Colors.white),),
                  padding: EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 27.0,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}