import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:http/http.dart'as http;

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {

  final String _apikey="114dfacfb4265a79d66ee14aa00fdf5a"; //api anahtarım
  final String _baseUrl="http://api.exchangeratesapi.io/v1/latest?access_key=";//sorgu yollayacagım adres

  Map<String,double> _oranlar={//items degerlerini tutuyor
    // "USD":32.30,
    //"EUR":35.19
  };

  String _secilenkur="USD";
  double _sonuc=0;

  TextEditingController _controller=TextEditingController();

  @override
  void initState() {
    super.initState();
    vericekinternetten();
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kur Dönüştürme"),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                  ),
                  onChanged: (String yenideger){
                    _hesapla();
                  },
                ),
                ),
                SizedBox(width: 10),
                DropdownButton<String>(
                    icon: Icon(Icons.arrow_downward),
                    value: _secilenkur,
                    items: _oranlar.keys.map((String kur){
                      return DropdownMenuItem<String>(
                          value: kur,
                          child: Text(kur));
                    }).toList(),
                    onChanged: (String? yenideger){
                      if(yenideger != null){
                        _secilenkur=yenideger;
                        _hesapla();
                      }
                    }
                )
              ],
            ),
            SizedBox(height: 16,),
            Text("${_sonuc.toStringAsFixed(2).toString()} TL",style: TextStyle(fontSize: 24),),
            Container(
              height: 2,
              color: Colors.black,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _oranlar.keys.length,
                itemBuilder: _buildListItem,
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget? _buildListItem(BuildContext context, int index) {
    return ListTile(
      title: Text(_oranlar.keys.toList()[index],style: TextStyle(fontSize: 24),),
      trailing: Text(_oranlar.values.toList()[index].toString(),style: TextStyle(fontSize: 24),),
    );
  }

  void _hesapla(){
    double? _deger=double.tryParse(_controller.text);
    double? _oran=_oranlar[_secilenkur];

    if(_deger != null && _oran != null){
      setState(() {
        _sonuc=_deger*_oran;
      });
    }
  }

  void vericekinternetten()async{
      Uri uri =Uri.parse(_baseUrl+_apikey);
         http.Response response=await http.get(uri);

         Map<String,dynamic>parsedResponse=jsonDecode(response.body);
         Map<String,dynamic> rates=parsedResponse["rates"];

         double? baseTlKuru=rates["TRY"];
         if(baseTlKuru != null){
           for(String ulkeKuru in rates.keys){
             double? baseKuru =double.tryParse(rates[ulkeKuru].toString());
             if(baseKuru != null){
               double tlKuru=baseTlKuru/baseKuru;
               _oranlar[ulkeKuru]=tlKuru;
             }
           }
         }

         setState(() {

         });

  }
}
