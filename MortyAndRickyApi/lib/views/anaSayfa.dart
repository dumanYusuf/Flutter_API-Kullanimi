import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rick_andmorty/views/detaySayfa.dart';
import '../model/rickAndMorty.dart';

 Color yaziRengi=Colors.white;
 double fontsize=14;

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

 Future<List<Cizgi>> _getUser()async{
  try{
    var response= await Dio().get("https://rickandmortyapi.com/api/character/");
    List<Cizgi>_userList=[];
    if(response.statusCode==200){
      debugPrint(response.data.toString());
      _userList = (response.data["results"] as List).map((e) => Cizgi.fromMap(e)).toList();
    }
    return _userList;
  }
  on DioException catch(e){
    return Future.error(e.message.toString());
  }

}

class _AnaSayfaState extends State<AnaSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rick And Morty"),),
    body: FutureBuilder<List<Cizgi>>(
        future: _getUser(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            var cizgiFilm=snapshot.data!;
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index){
                    var oankideger=cizgiFilm[index];
                    return InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetaySayfa(cizgi: oankideger,)));
                      },
                      child: Card(
                        elevation: 3,
                        color: Colors.grey,
                        child: Container(
                          width: 200,
                          height: 200,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(oankideger.image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                flex: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10,),
                                    Text(oankideger.name,style: TextStyle(color: yaziRengi,fontSize: fontsize,fontWeight: FontWeight.bold),),
                                   Row(
                                     children: [
                                       Text(oankideger.status.toString(),style: TextStyle(color: yaziRengi,fontSize: fontsize),),
                                       Text("-",style: TextStyle(color: Colors.white),),
                                       Text(oankideger.species.toString(),style: TextStyle(color: yaziRengi,fontSize: fontsize),),
                                     ],
                                   ),
                                    SizedBox(height: 10,),
                                    Text("- location",style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold),),
                                    Text(oankideger.location.name,style: TextStyle(color: yaziRengi,fontSize: fontsize,),),
                                    SizedBox(height: 7,),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );

                  });
          }
          else if(snapshot.hasError){
            return Center(child: CircularProgressIndicator());
          }
          else{
            return Center(child: CircularProgressIndicator());
          }

        }),
    );
  }
}
