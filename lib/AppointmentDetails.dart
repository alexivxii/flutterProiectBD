import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class AppointmentDetails extends StatefulWidget {

  List parametrii;
  AppointmentDetails({Key key, this.parametrii}) : super(key:key);
//widget.id

  @override
  State<StatefulWidget> createState() => new _State();
}


class _State extends State<AppointmentDetails> {

  TextEditingController StatusController = TextEditingController();

  List DataList;

  Future<http.Response> UpdateStatus (String status) async {
    var url ='http://10.0.2.2:5000/api/appointment';

    Map data = {
      "AppointmentId" : DataList[0]['AppointmentId'],
      "DoctorId": DataList[0]['DoctorId'],
      "PetId": DataList[0]['PetId'],
      "Date": DataList[0]['Date'],
      "Hour": DataList[0]['Hour'],
      "Status": status,
      "Description": DataList[0]['Description'],
      "Price": DataList[0]['Price']
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.put(url,
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print(response.body);
    return response;
  }

  Future<http.Response> DeleteAppointment (int id) async {
    var url ='http://10.0.2.2:5000/api/appointment/${id}';


    var response = await http.delete(url,
        headers: {"Content-Type": "application/json"},

    );
    print(response.body);
    return response;
  }

  Future<http.Response> DeleteAppointmentServices (int id) async {
    var url ='http://10.0.2.2:5000/api/appointmentservice/${id}';


    var response = await http.delete(url,
      headers: {"Content-Type": "application/json"},

    );
    print(response.body);
    return response;
  }

  Future<String> _fetchData(List param) async {

    final response = await http.get('http://10.0.2.2:5000/api/appointment/details/${param[0]}/${param[1]}');
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
                          'Details',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    cursorColor: const Color(0xffff3737),
                    controller: StatusController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Status',
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
                      child: Text('Modify Status', style: TextStyle(fontSize: 18),),
                      onPressed: () {
                        UpdateStatus(StatusController.text);
                      },
                    )),
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
                      child: Text('Delete Appointment', style: TextStyle(fontSize: 18),),
                      onPressed: () {
                        DeleteAppointmentServices(DataList[0]['AppointmentId']);
                        DeleteAppointment(DataList[0]['AppointmentId']);
                      },
                    )),
                Container(
                  height: 400,
                    margin: EdgeInsets.only(top:20,left:20, right:20),
                    child: FutureBuilder(
                        future: _fetchData(widget.parametrii),
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: DataList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    child: FlatButton(
                                      child: Column(
                                        children: [
                                          Text("Dr. ${DataList[index]['DoctorLastName']}",style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 25),
                                          ),
                                          Text(DataList[index]['OwnerPhoneNumber'],style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 25),
                                          ),
                                          Text(DataList[index]['PetName'],style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 25),
                                          ),
                                          Text(DataList[index]['SpeciesName'],style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 25),
                                          ),
                                          Text(DataList[index]['BreedName'],style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 25),
                                          ),
                                          Text(DataList[index]['ServiceName'],style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 25),
                                          ),
                                          Text(DataList[index]['Status'],style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 25),
                                          ),
                                          Text("${DataList[index]['Price'].toString()} RON",style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 25),
                                          ),
                                          Text(DataList[index]['Description'],style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 25),
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