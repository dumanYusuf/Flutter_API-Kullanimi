import 'package:flutter/material.dart';

import '../model/haber.dart';

double _fontsize=16;
Color color =Colors.black;

class DetaySayfa extends StatefulWidget {

  Haber haber;
  DetaySayfa({required this.haber});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();}

bool yukleniyormu=true;

class _DetaySayfaState extends State<DetaySayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.haber.title),),
      body:  Column(
        children: [
        yukleniyormu ?  Container(
            height: 200,
            decoration: BoxDecoration(
              image:DecorationImage(
                image: NetworkImage(widget.haber.urlToImage),
                fit: BoxFit.cover
              )
            ),
          ):CircularProgressIndicator(),
          SizedBox(height: 10,),
          Text(widget.haber.author,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          Text(widget.haber.content,style: TextStyle(fontSize: _fontsize),),
          SizedBox(height: 10,),
          Text(widget.haber.publishedAt.toString(),style: TextStyle(fontSize: _fontsize),)

        ],
      )
    );
  }
}
