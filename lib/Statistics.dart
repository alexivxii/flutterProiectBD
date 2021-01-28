import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


class StatisticsPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<StatisticsPage> {
  List DataListBreedsMostApps;
  List DataListPriceOverAverage;
  List DataListMonthsMostApps;
  List DataListPercentageCancelled;

  Future<String> stateChange; ///variabila care dicteaza schimbarea state ului

  TextEditingController MonthController = TextEditingController();

  Future<String> _fetchBreedsMostApps() async {

    final response =
    await http.get('http://10.0.2.2:5000/api/user/statistics/breedsmostapps');
    DataListBreedsMostApps = json.decode(response.body);
    print(DataListBreedsMostApps);
    print(DataListBreedsMostApps.length);
    return "Succes";
  }
  Future<String> _fetchPriceOverAverage() async {

    final response =
    await http.get('http://10.0.2.2:5000/api/user/statistics/priceoveraverage');
    DataListPriceOverAverage = json.decode(response.body);
    print(DataListPriceOverAverage);
    print(DataListPriceOverAverage.length);
    return "Succes";
  }
  Future<String> _fetchMonthsMostApps() async {

    final response =
    await http.get('http://10.0.2.2:5000/api/user/statistics/monthsmostapps');
    DataListMonthsMostApps = json.decode(response.body);
    print(DataListMonthsMostApps);
    print(DataListMonthsMostApps.length);
    return "Succes";
  }

  Future<String> _fetchPercentageCanceled(int luna) async {

    final response =
    await http.get('http://10.0.2.2:5000/api/user/statistics/percentagecanceledformonth/${luna}');
    DataListPercentageCancelled = json.decode(response.body);
    print(DataListPercentageCancelled);
    print(DataListPercentageCancelled.length);
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
                          'Statistics',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )),
                Column(
                  children: [
                    Text('Breeds with most appointments',style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                    ),
                  ],
                ),
                Container(
                    child: FutureBuilder(
                        future: _fetchBreedsMostApps(),
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: DataListBreedsMostApps.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(

                                    child: Column(
                                      children: [
                                        Text(DataListBreedsMostApps[index]['BreedName'].toString(),style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 25),
                                        ),
                                        Text(DataListBreedsMostApps[index]['Numar'].toString(),style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 25),
                                        ),
                                      ],
                                    ),
                                  );});
                          }
                          else return Container();
                        }
                    )
                ),
                SizedBox(height: 10,),
                Column(
                  children: [
                    Text('Owner with price over \n average for one app',style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                    ),
                  ],
                ),
                Container(
                    child: FutureBuilder(
                        future: _fetchPriceOverAverage(),
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: DataListPriceOverAverage.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(

                                    child: Column(
                                      children: [

                                        Text(DataListPriceOverAverage[index]['OwnerPhoneNumber'].toString(),style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 25),
                                        ),
                                      ],
                                    ),
                                  );});
                          }
                          else return Container();
                        }
                    )
                ),
                SizedBox(height: 10,),
                Column(
                  children: [
                    Text('Months with most apps in current year',style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                    ),
                  ],
                ),
                Container(
                    child: FutureBuilder(
                        future: _fetchMonthsMostApps(),
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: DataListMonthsMostApps.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(

                                    child: Column(
                                      children: [

                                        Text("Luna ${DataListMonthsMostApps[index]['LUNA'].toString()}",style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 25),
                                        ),
                                        Text("Numar ${DataListMonthsMostApps[index]['NUMAR'].toString()}",style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 25),
                                        ),
                                      ],
                                    ),
                                  );});
                          }
                          else return Container();
                        }
                    )
                ),
                SizedBox(height: 10,),
                Column(
                  children: [
                    Text('Introduce Month (Nr) \nfrom current year by far\n for % of cancelled apps',style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                    ),
                  ],
                ),
                Container(
                  width: 180,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    cursorColor: const Color(0xffff3737),
                    controller: MonthController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Month (Number)',
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
                          stateChange =  _fetchPercentageCanceled(int.parse(MonthController.text));
                        });


                      },
                    )),
                Container(
                    child: FutureBuilder(
                        future: stateChange,
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: DataListPercentageCancelled.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(

                                    child: Column(
                                      children: [
                                        Text('Procentajul',style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 30),
                                        ),
                                        Text(DataListPercentageCancelled[index]['Procentaj'].toString(),style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 30),
                                        ),
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