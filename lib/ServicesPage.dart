import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ServicesPage extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => new _State();
}


class _State extends State<ServicesPage> {

  int selectedId;
  TextEditingController servicenameController = TextEditingController();
  List DataList;
  List DataListCheck;

  Future<void> _showMyDialogAdd() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Service'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  width: 100,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    cursorColor: const Color(0xffff3737),
                    controller: servicenameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Service Name',
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              textColor: Colors.white,
              color: const Color(0xffff3737),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                  side: BorderSide(color: const Color(0xffff3737))
              ),
              child: Text('Add Service', style: TextStyle(fontSize: 15),),
              onPressed: () async{
                await AddService(servicenameController.text);
                setState(() {

                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Service Name'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  width: 100,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    cursorColor: const Color(0xffff3737),
                    controller: servicenameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Service Name',
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              textColor: Colors.white,
              color: const Color(0xffff3737),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                  side: BorderSide(color: const Color(0xffff3737))
              ),
              child: Text('Update Service', style: TextStyle(fontSize: 15),),
              onPressed: () {
                UpdateService(servicenameController.text);
                setState(() {

                });
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              textColor: Colors.white,
              color: const Color(0xffff3737),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                  side: BorderSide(color: const Color(0xffff3737))
              ),
              child: Text('Delete Service', style: TextStyle(fontSize: 15),),
              onPressed: () async {
                print(selectedId);
                await CheckIfServiceUsed(selectedId);
                print(DataList);
                if(DataListCheck[0]['Column1'] != 0)
                  print("Serviciul este utilizat intr un appointment, nu poate fi sters");
                else await DeleteService(selectedId);
                setState(() {

                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<http.Response> UpdateService (String sname) async {
    var url ='http://10.0.2.2:5000/api/service';

    Map data = {
      "ServiceId" : selectedId,
      "ServiceName" : sname

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

  Future<http.Response> DeleteService (int id) async {
    var url ='http://10.0.2.2:5000/api/service/${id}';


    var response = await http.delete(url,
      headers: {"Content-Type": "application/json"},

    );
    print(response.body);
    return response;
  }

  Future<String> CheckIfServiceUsed(int id) async {

    final response = await http.get('http://10.0.2.2:5000/api/service/used/${id}');
    DataListCheck = json.decode(response.body);
    print(DataListCheck);
    print(DataListCheck.length);
    return "Succes";
  }

  Future<http.Response> AddService(String servicename) async {

    var url = 'http://10.0.2.2:5000/api/service';
    Map data = {
      "ServiceName": servicename
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

  Future<String> _fetchData() async {

    final response = await http.get('http://10.0.2.2:5000/api/service');
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
                          'Services',
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
                      child: Text('Add Service', style: TextStyle(fontSize: 18),),
                      onPressed: () {
                        _showMyDialogAdd();
                      },
                    )),
                Container(
                    margin: EdgeInsets.only(top:20,left:20, right:20),
                    child: FutureBuilder(
                        future: _fetchData(),
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: DataList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    child: FlatButton(
                                      onPressed: () {
                                        selectedId = DataList[index]['ServiceId'];
                                        _showMyDialog();
                                      },
                                      child: Column(
                                        children: [
                                          Text(DataList[index]['ServiceName'],style: TextStyle(
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