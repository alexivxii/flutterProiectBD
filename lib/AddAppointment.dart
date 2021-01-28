import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


class AddAppointments extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<AddAppointments> {
  TextEditingController DateController = TextEditingController();
  TextEditingController HourController = TextEditingController();
  TextEditingController StatusController = TextEditingController();
  TextEditingController DescriptionController = TextEditingController();
  TextEditingController PriceController = TextEditingController();
  TextEditingController OwnerPhoneNumberController = TextEditingController();
  TextEditingController PetNameController = TextEditingController();

  String _mySelectionServices;
  String _mySelectionDoctors;
  String _mySelectionBreeds;
  bool isInitialized;

  List<bool> CheckedItems;
  List DataListServices;
  List DataListDoctors;
  List DataListBreeds;
  List DataListPetId;
  List DataListAppId;



  Future<String> _fetchServices() async {
    print("aici");
    final response = await http.get('http://10.0.2.2:5000/api/service');
    DataListServices = json.decode(response.body);
    print(DataListServices);
    print(DataListServices.length);
   // CheckedItems = List.filled(DataListServices.length, false);


    if(isInitialized == false)
    {
      CheckedItems = List.filled(DataListServices.length, false); /// problema era ca, fara isInitialized, mie imi facea initializarea de checkedItems cu false la fiecare setState
      isInitialized = true;
    }

    return "Succes";
  }

  Future<String> _fetchDoctors() async {
    print("aici");
    final response = await http.get('http://10.0.2.2:5000/api/doctor');
    DataListDoctors = json.decode(response.body);
    print(DataListDoctors);
    print(DataListDoctors.length);

    return "Succes";
  }

  Future<String> _fetchBreeds() async {
    print("aici");
    final response = await http.get('http://10.0.2.2:5000/api/breeds');
    DataListBreeds = json.decode(response.body);
    print(DataListBreeds.length);

    return "Succes";
  }

  Future<http.Response> InsertPets ( String name, String phonenumber, int breedid) async {
    var url ='http://10.0.2.2:5000/api/pet';

    Map data = {
      "PetName": name,
      "OwnerPhoneNumber": phonenumber,
      "BreedId": breedid
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print(response.body);
    return response;
  }

  Future<http.Response> InsertAppointmentServices (int appid, int serviceid) async {
    var url ='http://10.0.2.2:5000/api/AppointmentService';

    Map data = {
      "AppointmentId": appid,
      "ServiceId": serviceid
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print(response.body);
    return response;
  }


  Future<http.Response> InsertAppointments (int doctorid, int petid ,String date, String hour, String status, String description,String price) async {
    var url ='http://10.0.2.2:5000/api/appointment';

    Map data = {
      "DoctorId": doctorid,
      "PetId": petid,
      "Date": date,
      "Hour": hour,
      "Status": status,
      "Description": description,
      "Price": price
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print(response.body);
    return response;
  }

  Future<String> _fetchPetId(String petname, String phonenumber) async {

    final response = await http.get('http://10.0.2.2:5000/api/pet/getidpet/${petname}/${phonenumber}');
    DataListPetId = json.decode(response.body);
    print(DataListPetId);
    //print(DataListPetId.length);
    return "Succes";
  }

  Future<String> _fetchAppointmentId(int doctorid, int petid, String date, String hour) async {

    final response = await http.get('http://10.0.2.2:5000/api/appointment/getappid/${doctorid}/${petid}/${date}/${hour}');
    DataListAppId = json.decode(response.body);
    print(DataListAppId);
    //print(DataListPetId.length);
    return "Succes";
  }

  initState() {
    super.initState();
    isInitialized = false;
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
                        SizedBox(width: 60),
                        Text(
                          'Add Appointment',
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
                    controller: DateController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Date',
                    ),
                  ),
                ),
                Container(
                  width: 180,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    cursorColor: const Color(0xffff3737),
                    controller: HourController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Hour',
                    ),
                  ),
                ),
                Container(
                  width: 180,
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
                  width: 180,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    cursorColor: const Color(0xffff3737),
                    controller: DescriptionController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description',
                    ),
                  ),
                ),
                Container(
                  width: 180,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    cursorColor: const Color(0xffff3737),
                    controller: PriceController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Price',
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top:10,left:10, right:10),
                    child: Center(
                      child: FutureBuilder(
                          future: _fetchServices(),
                          builder: (context, snapshot){
                            if(snapshot.hasData){
                              return ListView.builder(
                              shrinkWrap: true,
                              itemCount: DataListServices.length,
                              itemBuilder: (BuildContext context, int index) {
                                return new Card(
                                  child: new Container(
                                    padding: new EdgeInsets.all(10.0),
                                    child: Column(
                                      children: <Widget>[
                                        new CheckboxListTile(
                                            activeColor: Colors.red,
                                            dense: true,
                                            //font change
                                            title: new Text(
                                              DataListServices[index]['ServiceName'],
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0.5),
                                            ),
                                            value: CheckedItems[index],
                                            onChanged: (bool val) {
                                              setState(() {
                                                CheckedItems[index] = val;
                                              });
                                            })
                                      ],
                                    ),
                                  ),
                                );
                              }
                              );
                            }
                            else return Container();
                          }
                      ),
                    )
                ),
                Container(
                    margin: EdgeInsets.only(top:10,left:20, right:20),
                    child: Center(
                      child: FutureBuilder(
                          future: _fetchDoctors(),
                          builder: (context, snapshot){
                            if(snapshot.hasData){
                              return DropdownButton(
                                items: DataListDoctors.map((item) {
                                  return new DropdownMenuItem(
                                    child: new Text('${item['DoctorFirstName']} ${item['DoctorLastName']}'),
                                    value: item['DoctorId'].toString(),
                                  );
                                }).toList(),
                                onChanged: (newVal) {
                                  setState(() {
                                    _mySelectionDoctors = newVal;
                                  });
                                },
                                value: _mySelectionDoctors,
                              );
                            }
                            else return Container();
                          }
                      ),
                    )
                ),
                Container(
                  width: 180,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    cursorColor: const Color(0xffff3737),
                    controller: PetNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Pet Name',
                    ),
                  ),
                ),
                Container(
                  width: 180,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    cursorColor: const Color(0xffff3737),
                    controller: OwnerPhoneNumberController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Owner Phone Number',
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top:10,left:10, right:10),
                    child: Center(
                      child: FutureBuilder(
                          future: _fetchBreeds(),
                          builder: (context, snapshot){
                            if(snapshot.hasData){
                              return DropdownButton(
                                items: DataListBreeds.map((item) {
                                  return new DropdownMenuItem(
                                    child: new Text(item['BreedName']),
                                    value: item['BreedId'].toString(),
                                  );
                                }).toList(),
                                onChanged: (newVal) {
                                  setState(() {
                                    _mySelectionBreeds = newVal;
                                  });
                                },
                                value: _mySelectionBreeds,
                              );
                            }
                            else return Container();
                          }
                      ),
                    )
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
                      child: Text('Confirm', style: TextStyle(fontSize: 18),),
                      onPressed: () async{
                        //_mySelectionServicesId = DataListServices.firstWhere((element) => element['ServiceName'] == _mySelectionServices);
                        print("LALALALLA");
//                        print(_mySelectionServices);
//                        print(CheckedItems);
                       //InsertAppointments (DateController.text, HourController.text, StatusController.text, DescriptionController.text,PriceController.text);
                        print(_mySelectionBreeds.runtimeType);
//                        print("tipul lui breed id este");
//                        print(DataListBreeds[0]["BreedId"].runtimeType);

                        await _fetchPetId(PetNameController.text, OwnerPhoneNumberController.text);
                        if(DataListPetId.length == 0) {
                          print("da este null");
                          InsertPets(PetNameController.text, OwnerPhoneNumberController.text, int.parse(_mySelectionBreeds));
                        }

                        await InsertAppointments(int.parse(_mySelectionDoctors),DataListPetId[0]['PetId'],DateController.text, HourController.text, StatusController.text, DescriptionController.text, PriceController.text);
                        await _fetchAppointmentId(int.parse(_mySelectionDoctors), DataListPetId[0]['PetId'], DateController.text, HourController.text);

                        for(int i=0; i<CheckedItems.length; i++)
                          {
                            if(CheckedItems[i] == true)
                              {
                                /// INDEXUL DIN CHECKED ITEMS NU CORESPUNDE NEAPARAT CU ID UL SERVICIULUI
                                InsertAppointmentServices(DataListAppId[0]['AppointmentId'], DataListServices[i]['ServiceId']);
                              }
                          }

                      },
                    )),
              ],
            ))
    );
  }
}