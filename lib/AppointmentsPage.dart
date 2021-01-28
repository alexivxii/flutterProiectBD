import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:proiectbd/AppointmentDetails.dart';
import 'package:proiectbd/AddAppointment.dart';
import 'package:proiectbd/ServicesPage.dart';

class AppointmentsPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<AppointmentsPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List DataList;
  DateTime selectedDate = DateTime.utc(2020,3,4);

  Future<String> _fetchData(String DataCalendar) async {

    final response = await http.get('http://10.0.2.2:5000/api/appointment/bydate/${DataCalendar}');
    DataList = json.decode(response.body);
    print(DataList);
    print(DataList.length);
    return "Succes";
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(), // This will change to light theme.
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    };
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
                          'Appointments',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
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
                      child: Text('Add Appointment', style: TextStyle(fontSize: 18),),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddAppointments(),
                            ));
                      },
                    )),
                Container(
                    height: 50,
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: const Color(0xffff3737),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          side: BorderSide(color: const Color(0xffff3737))
                      ),
                      child: Text('Services', style: TextStyle(fontSize: 18),),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServicesPage(),
                            ));
                      },
                    )),
                Container(
                  margin: EdgeInsets.only(top:20,left:20, right:20),
                  height: 50,

                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: InkWell(
                    onTap: () => _selectDate(context),
                    child: Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.calendar_today,
                            color: Color(0xffA8A8A8),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Select date',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xffA8A8A8),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        //Flat button cu text in care este data selectata iar la apasare se deschide calendarul
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "${selectedDate.toLocal()}".split(' ')[0],
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Color(0xff1E2138)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                    Container(
                      height: 400,
                        margin: EdgeInsets.only(top:20,left:20, right:20),
                        child: FutureBuilder(
                          future: _fetchData("${selectedDate.toLocal()}"),
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
                                      Text(DataList[index]['Hour'],style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 30),
                                      ),
                                        Text("Doctor ${DataList[index]['DoctorLastName']}",style: TextStyle(
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