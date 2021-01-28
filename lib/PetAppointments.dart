import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:proiectbd/AppointmentDetails.dart';

class PetAppointments extends StatefulWidget {

  int petid;
  PetAppointments({Key key, this.petid}) : super(key:key);

//widget.id

  @override
  State<StatefulWidget> createState() => new _State();
}


class _State extends State<PetAppointments> {


  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List DataList;

  Future<String> _fetchData(int id) async {

    final response = await http.get('http://10.0.2.2:5000/api/pet/searchAppointment/${id}');
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
                        SizedBox(width: 30),
                        Text(
                          'Pet Appointments',
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
                    margin: EdgeInsets.only(top:20,left:20, right:20),
                    child: FutureBuilder(
                        future: _fetchData(widget.petid),
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
                                          Text(DataList[index]['ServiceName'],style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 30),
                                          ),
                                          Text(DataList[index]['Status'],style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 30),
                                          ),
                                          SizedBox(height: 20,)
                                        ],
                                      ),
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