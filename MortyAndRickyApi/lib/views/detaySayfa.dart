import 'package:flutter/material.dart';
import 'package:rick_andmorty/model/rickAndMorty.dart';

class DetaySayfa extends StatelessWidget {

  Color _color=Colors.black;
  double _fontzize=24;

  Cizgi cizgi;
  DetaySayfa({required this.cizgi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("The Rick and Morty Detay Sayfası"),),
      body: SingleChildScrollView(
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
             width: double.infinity,
              height: 300,
             decoration: BoxDecoration(
               image: DecorationImage(
                 image: NetworkImage(cizgi.image),
                 fit: BoxFit.cover
               )
             ),
            ),
            SizedBox(height: 10,),
            Text("name - " +cizgi.name,style: TextStyle(color: _color,fontSize: _fontzize),),
            Text("status - " +cizgi.status,style: TextStyle(color: _color,fontSize: _fontzize),),
            Text("species - " +cizgi.species,style: TextStyle(color: _color,fontSize: _fontzize),),
            Text("type - " +cizgi.type,style: TextStyle(color: _color,fontSize: _fontzize),),
            Text("gender - " +cizgi.gender,style: TextStyle(color: _color,fontSize: _fontzize),),
            Text("origin - " +cizgi.origin.name,style: TextStyle(color: _color,fontSize: _fontzize),),
            Text("location - " +cizgi.location.name,style: TextStyle(color: _color,fontSize: _fontzize),),
            Text("created - " +cizgi.created.toString(),style: TextStyle(color: _color,fontSize: _fontzize),),
            Text("images - " +cizgi.image,style: TextStyle(color: _color,fontSize: _fontzize),),
          ],
        ),
      ),
    );
  }
}
