import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:proiectbd/AppointmentDetails.dart';

class DoctorPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<DoctorPage> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  List DataList;
  Future<String> stateChange; ///variabila care dicteaza schimbarea state ului
  int picked; ///id ul primit

//  Future<int> _fetchId(String last, String first) async {
//    print('a${last}a');
//    final response = await http.get('http://10.0.2.2:5000/api/doctor/searchDoctorId/${last}/${first}');
//    DataList = json.decode(response.body);
//    print(DataList);
//    print(DataList.length);

//    if(DataList[0]['DoctorId'] != null && DataList[0]['DoctorId']!=doctorid)
//    setState(() {
//      doctorid = DataList[0]['DoctorId'];
//    });

//    return DataList[0]['DoctorId'];
 // }

//  Future<String> _fetchData(int id) async {
//    print("aici");
//    final response = await http.get('http://10.0.2.2:5000/api/doctor/searchAppointment/${id}');
//    DataList = json.decode(response.body);
//    print(DataList);
//    print(DataList.length);
//
//    return "Succes";
//  }

  Future<String> _fetchData(String last, String first) async {
    print("aici");
    final response = await http.get('http://10.0.2.2:5000/api/doctor/searchAppointmentTry/${last}/${first}');
    DataList = json.decode(response.body);
    print(DataList);
    print(DataList.length);

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
                          'Doctors',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )),

                Row(
                  children: [
                    Container(
                      width: 180,
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        cursorColor: const Color(0xffff3737),
                        controller: lastnameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Last name',
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 180,
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        cursorColor: const Color(0xffff3737),
                        controller: firstnameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'First name',
                        ),
                      ),
                    ),
                  ],
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

//                        picked = await _fetchId(lastnameController.text,firstnameController.text);

//                        setState(() {
//                          stateChange = _fetchData(picked);
//                        });
                        setState(() {
                          stateChange = _fetchData(lastnameController.text,firstnameController.text);
                        });


                      },
                    )),
                Container(
                    height: 400,
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
                                        List detalii = [DataList[index]['AppointmentId'],DataList[index]['ServiceName']];
                                        print(detalii);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => AppointmentDetails(parametrii: detalii),
                                            ));
                                      },
                                      child: Column(
                                        children: [
                                          Text(DataList[index]['Date'].toString().substring(0,10),style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 30),
                                          ),
                                          Text(DataList[index]['Hour'],style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 30),
                                          ),
                                          Text("Status ${DataList[index]['Status']}",style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 30),
                                          ),
                                          Text(DataList[index]['ServiceName'],style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 30),
                                          ),
                                          Text(DataList[index]['BreedName'],style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 30),
                                          ),
                                          SizedBox(height: 20,),
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