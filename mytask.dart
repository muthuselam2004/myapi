import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;


class mytask extends StatefulWidget {
  const mytask({super.key});

  @override
  State<mytask> createState() => _mytaskState();
}

class _mytaskState extends State<mytask> {

  List usersList=[];
  Future<List<details>> getUsers() async {
    try {
      var apiResponse = await http.get(
          Uri.parse("https://dummy-json.mock.beeceptor.com/continents"));
      usersList = jsonDecode(apiResponse.body);
      print(usersList);
      if(apiResponse.statusCode==200){
        return usersList.map((myJson)=>details.fromJson(myJson)).toList();
      }
      else{
        throw Exception("Something went wrong");
      }
    }

    catch (e) {
      throw Exception(e);
    }


}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("MY API TASK",style: GoogleFonts.abhayaLibre(color: Colors.black)),),
      ),
      body: FutureBuilder(future: getUsers(), builder: (context,snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        else if (snapshot.hasError) {
          return Text("Error:${snapshot.error}");
        }
        else if (snapshot.hasData) {
          return ListView.builder(
              itemCount: usersList.length,
              itemBuilder: (context, int index) {
                final user = usersList[index];
                return Card(
                  color: Colors.white60,
                  child: ListTile(
                    title:   Text(user['name'],style: GoogleFonts.cabin(color: Colors.black),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                          Table(
                            columnWidths: const{
                              0:IntrinsicColumnWidth(),
                              1:FlexColumnWidth(),
                            },
                            children: [
                              TableRow(
                                children: [
                                  Text("code",style:GoogleFonts.aBeeZee(fontSize: 15,color: Colors.black),),
                                  Text(": ${user['code'].toString()}",style: GoogleFonts.aBeeZee(fontSize: 15,color: Colors.black),)
                                ]
                              ),
                              TableRow(
                                children: [
                                  Text("AreaSqkm",style: GoogleFonts.aBeeZee(fontSize: 15,color: Colors.black),),
                                  Text(": ${user['areaSqKm'].toString()}",style: GoogleFonts.aBeeZee(fontSize: 15,color: Colors.black),)
                                ]
                              ),
                              TableRow(
                                  children: [
                                    Text("Population",style: GoogleFonts.aBeeZee(fontSize: 15,color: Colors.black),),
                                    Text(": ${user['population'].toString()}",style: TextStyle(fontSize: 15,color: Colors.black),)
                                  ]
                              ),
                              TableRow(
                                  children: [
                                    Text("Lines",style: GoogleFonts.aBeeZee(fontSize: 15,color: Colors.black),),
                                    Text(": ${user['lines'][0]}""\n ${user['lines'][1]}",style: GoogleFonts.aBeeZee(fontSize: 15,color: Colors.black),)
                                  ]
                              ),
                              TableRow(
                                  children: [
                                    Text("countries",style: GoogleFonts.aBeeZee(fontSize: 15,color: Colors.black),),
                                    Text(": ${user['countries'].toString()}",style: GoogleFonts.aBeeZee(fontSize: 15,color: Colors.black),)
                                  ]
                              ),
                              TableRow(
                                  children: [
                                    Text("oceans",style: GoogleFonts.aBeeZee(fontSize: 15,color: Colors.black),),
                                    Text(": ${user['oceans'][0]}",style: GoogleFonts.aBeeZee(fontSize: 15,color: Colors.black),)
                                  ]
                              ),
                              TableRow(
                                  children:[
                                    Text("DevelopedCountries"
                                      ,style: GoogleFonts.aBeeZee(fontSize: 15,color: Colors.black),),
                                    Text(
                                      ": ${user['developedCountries'] != null && user['developedCountries'].length > index
                                          ? "${user['developedCountries'][0]}"
                                          "\n  ${user['developedCountries'][1]}"
                                          "\n  ${user['developedCountries'][2]}"
                                          : 'N/A'}",
                                      style: GoogleFonts.aBeeZee(fontSize: 15,color: Colors.black),
                                    ),
                                  ]
                              ),

                            ],

                          ),

                        ],
                      )
                  ),
                );
              }
          );
        }
        else {
          return Text("No data found");
        }
      })
    );
  }
}


class details {
  String? code;
  String? name;
  int? areaSqKm;
  int? population;
  List<String>? lines;
  int? countries;
  List<String>? oceans;
  List<String>? developedCountries;

  details(
      {this.code,
        this.name,
        this.areaSqKm,
        this.population,
        this.lines,
        this.countries,
        this.oceans,
        this.developedCountries});

  details.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    areaSqKm = json['areaSqKm'];
    population = json['population'];
    lines = json['lines'].cast<String>();
    countries = json['countries'];
    oceans = json['oceans'].cast<String>();
    developedCountries = json['developedCountries'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['areaSqKm'] = this.areaSqKm;
    data['population'] = this.population;
    data['lines'] = this.lines;
    data['countries'] = this.countries;
    data['oceans'] = this.oceans;
    data['developedCountries'] = this.developedCountries;
    return data;
  }
}

