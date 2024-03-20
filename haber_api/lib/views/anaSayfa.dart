import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:haber_api/model/haber.dart';
import 'package:haber_api/views/detaySayfa.dart';



Color yaziRengi=Colors.white;
double fontsize=14;

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

Future<List<Haber>> _getUser()async{
  try{
    var response= await Dio().get("https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=4f1dbd15ec5343f48b519ebfbf825b90");
    List<Haber>_userList=[];
    if(response.statusCode==200){
      debugPrint(response.data.toString());
      _userList = (response.data["articles"] as List).map((e) => Haber.fromMap(e)).toList();
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
      appBar: AppBar(title: Text("News"),),
      body: FutureBuilder<List<Haber>>(
          future: _getUser(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              var _haber=snapshot.data!;
              return ListView.builder(
                itemCount: _haber.length,
                  itemBuilder: (context, index) {
                      var oankihaber=_haber[index];
                      return InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetaySayfa(haber: oankihaber)));
                        },
                        child: Card(
                          elevation: 3,
                          child: ListTile(
                            title: Text(oankihaber.title,style: TextStyle(fontSize: 24),),
                            subtitle: Text(oankihaber.description),
                          ),
                        ),
                      );
                  },
              );
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
