import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_iller/model/iller_model.dart';

import 'model/iller_model.dart';

class LocalJson extends StatefulWidget {
  const LocalJson({super.key});

  @override
  State<LocalJson> createState() => _LocalJsonState();
}

class _LocalJsonState extends State<LocalJson> {

  Future<List<Iller>> illerjsonoku() async{
    try {
      debugPrint("5 saniyenil işlem başladı");
      await Future.delayed(Duration(seconds: 5));
      debugPrint("5 saniyenilk işlem bitti");

      String okunanString=await DefaultAssetBundle.of(context).loadString("assets/data/iller.json");

      var jsonarray=jsonDecode(okunanString);

      List<Iller> tumiller = (jsonarray as List).map((illermap) => Iller.fromMap(illermap)).toList();

      debugPrint(tumiller.length.toString());
      return tumiller;
    }
    catch(e){
      debugPrint(e.toString());
      return Future.error(e.toString());
    }

  }
  late final Future<List<Iller>> listeyidoldur;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listeyidoldur=illerjsonoku();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("json verilerim",style: TextStyle(fontSize: 24,color: Colors.white),),
      ),
      body: FutureBuilder<List<Iller>>(
        future:listeyidoldur,
        initialData: [
          Iller(id: 0, ilAdi: "van", plakaKodu: "65"),
        ],
        builder: (context,Snapshot) {
          if(Snapshot.hasData){
            List<Iller>illerlistesi=Snapshot.data!;
            return ListView.builder(
              itemCount: illerlistesi.length,
                itemBuilder: (context,index){
                Iller oankiller=illerlistesi[index];
                  return Card(
                    elevation: 2,
                    color: Colors.transparent,
                    child: ListTile(
                      title: Text(oankiller.ilAdi,style: TextStyle(fontSize: 24),),
                      leading: CircleAvatar(child: Text(oankiller.id.toString(),style: TextStyle(fontSize: 20),),),
                      trailing: Text(oankiller.plakaKodu,style: TextStyle(fontSize: 20),),
                    ),
                  );
                }
            );
          }
          else if(Snapshot.hasError){
            return Center(
              child: Text(Snapshot.error.toString()),
            );
          }
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
       )

    );
  }
}
