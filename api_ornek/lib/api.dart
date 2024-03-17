import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'model/todos.dart';

class RemoteApi extends StatefulWidget {
  const RemoteApi({super.key});

  @override
  State<RemoteApi> createState() => _RemoteApiState();
}

class _RemoteApiState extends State<RemoteApi> {

  Future<List<Todos>>_getuserList() async{
    try{
      var response=await Dio().get('https://jsonplaceholder.typicode.com/todos');
      List<Todos>_userList=[];
      if(response.statusCode==200){
        _userList=(response.data as List).map((e) => Todos.fromMap(e)).toList();
    }
      return _userList;
    }
    on DioException catch(e){
      return Future.error(e.message!);
    }
  }

  late final Future<List<Todos>>_userList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userList=_getuserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Remote api with the",style: TextStyle(fontSize: 24,color: Colors.white),),),
      body: FutureBuilder<List<Todos>>(
        future: _userList,
        builder: (context,Snapshot){
          if(Snapshot.hasData){
            var userList=Snapshot.data!;
            return ListView.builder(
              itemCount: userList.length,
                itemBuilder: (context,index){
                var user=userList[index];
                return Card(
                  elevation: 2,
                  child: ListTile(
                    title:Text(user.title.toString()),
                    subtitle: Text(user.userId.toString()),
                    leading: Text(user.id.toString()),
                  ),
                );
                }
            );
          }
          else if(Snapshot.hasError){
            return Text(Snapshot.error.toString());
          }
          else{
            return CircularProgressIndicator();
          }
        }
      )
    );
  }
}
