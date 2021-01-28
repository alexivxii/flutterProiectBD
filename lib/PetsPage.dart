import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:proiectbd/PetAppointments.dart';

class PetsPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<PetsPage> {
  TextEditingController PhoneNumberController = TextEditingController();
  List DataList;
  List DataListPay;
  Future<String> stateChange; ///variabila care dicteaza schimbarea state ului
  String picked; ///raspunsul primit


  Future<String> _fetchData(String phone) async {
    print("aici");
    final response = await http.get('http://10.0.2.2:5000/api/pet/searchPhone/${phone}');
    DataList = json.decode(response.body);
    print(DataList);
    print(DataList.length);

    return "Succes";
  }

  Future<String> _fetchDataPay(String phone) async {
    print("aici");
    final response = await http.get('http://10.0.2.2:5000/api/user/statistics/clientmaxpay/${phone}');
    DataListPay = json.decode(response.body);
    print(DataListPay);
    print(DataListPay.length);

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
                    padding: EdgeInsets.fromLTRB(0,20,20,20),
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
                          'Patients',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )),
                    Container(
                      width: 180,
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        cursorColor: const Color(0xffff3737),
                        controller: PhoneNumberController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Phone Number',
                        ),
                      ),
                    ),

                Container(
                    height: 50,
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: const Color(0xffff3737),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          side: BorderSide(color: const Color(0xffff3737))
                      ),
                      child: Text('Search', style: TextStyle(fontSize: 18),),
                      onPressed: () async{



                        setState(() {
                          stateChange =  _fetchData(PhoneNumberController.text);
                        });


                      },
                    )),
                Container(
                    margin: EdgeInsets.only(top:20,left:20, right:20),
                    child: FutureBuilder(
                        future: _fetchDataPay(PhoneNumberController.text),
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: DataListPay.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    child: FlatButton(
                                      child: Column(
                                        children: [
                                          Text("${DataListPay[index]['Column1'].toString()} RON",style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 30),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );});
                          }
                          else return Container();
                        }
                    )
                ),
                SizedBox(height: 20,),
                Container(
                    margin: EdgeInsets.only(top:20,left:20, right:20),
                    child: FutureBuilder(
                        future: stateChange,
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: DataList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => PetAppointments(petid: DataList[index]['PetId']),
                                            ));
                                      },
                                      child: Column(
                                        children: [
                                          Text(DataList[index]['PetName'],style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 30),
                                          ),
                                          Text(DataList[index]['BreedName'],style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 30),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );});
                          }
                          else return Container();
                        }
                    )
                )
              ],
            ))
    );
  }
}