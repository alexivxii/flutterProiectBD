import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


class AllBreedsPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<AllBreedsPage> {
  List DataListAllBreeds;
  Future<String> _fetchDataAllPayment() async {

    final response =
    await http.get('http://10.0.2.2:5000/api/pet/getspeciesbreeds');
    DataListAllBreeds = json.decode(response.body);
    print(DataListAllBreeds);
    print(DataListAllBreeds.length);
    return "Succes";
  }

  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(
//          title: Text('Login Screen App'),
//        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    padding: EdgeInsets.fromLTRB(0,20,20,25),
                    child: Row(
                      children: <Widget>[
                        IconButton(

                          icon: Icon(Icons.arrow_back_ios),
                          onPressed:(){
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(width: 100),
                        Text(
                          'All breeds',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )),
                Container(
                  height: 500,
                    child: FutureBuilder(
                        future: _fetchDataAllPayment(),
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: DataListAllBreeds.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(

                                    child: Column(
                                      children: [
                                        Text(DataListAllBreeds[index]['SpeciesName'].toString(),style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 30),
                                        ),
                                        Text(DataListAllBreeds[index]['BreedName'].toString(),style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 30),
                                        ),
                                        SizedBox(height: 20,),
                                      ],
                                    ),
                                  );});
                          }
                          else return Container();
                        }
                    )
                ),
              ],
            ))
    );
  }
}