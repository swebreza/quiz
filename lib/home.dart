import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'quiz.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> categoryname =[
    "GK", "Geography", "History",
    "Science", "Books",
    "Country", "Olympics",
    "Cricket", "Football", "Basketball",
    "Music", "Harry Potter", "Movie",
    "Web Series", "Anime",
    "Celebrity", "Fun", "Video Games"
  ];

  Widget customcard(int no){
    final langname= categoryname[no];
    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap:() => Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => getjson(langname),
        ),),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image(
              height: 100,
              width: 100,
              image: AssetImage(
                  "assets/Images/$langname.png" ),),
            Text(categoryname[no],style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QUIZ',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 33,color: Colors.white70),),
        elevation: 10,
        centerTitle: true,),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers:<Widget>[
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              crossAxisSpacing: 0,
              childAspectRatio: .8,
            ),
            delegate: SliverChildBuilderDelegate((BuildContext context,int index){
              return customcard(index);
            },childCount: 18,
            ),),],),
    );
  }
}