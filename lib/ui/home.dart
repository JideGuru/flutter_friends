import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

//Import HTTP
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  final String header;

  Home({Key key, this.header}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}


class HomeState extends State<Home> {


  Map allData;
  List data;
  var isLoading = false;

  //Function to parse JSON
  Future getJson() async {
    setState(() {
      isLoading = true;
    });

    //API for getting the data
    String apiLink = "http://faker.wecode.ng/api/v1/faker/people/";
    print(apiLink);

    http.Response response = await http.get(apiLink);
    if (response.statusCode == 200) {
      allData = jsonDecode(response.body); //JSON.decode ins older versions of flutter


      data = allData['response'];

      print(data.toString());

      setState(() {
        isLoading = false;
      });
    }else {
      throw Exception('Failed to load');
    }

  }


  @override
  void initState() {
    super.initState();
    getJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.header,
          style: TextStyle(
            color: Colors.red,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon:Icon(
                Icons.info_outline,
                color: Colors.red,
              ),
              onPressed: () => _showAlertInfo(context)
          )

        ],
      ),

      //Body
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(
        ),
      )
          :Center(
        child: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          padding: EdgeInsets.all(16.0),
          itemBuilder: (BuildContext context, int position) {

            //Set divider for every thing in odd position(There is a better way to do it)
            if (position.isOdd) return Divider();
            final index = position ~/ 2;
            String sname = data[index]['surname'];
            String fname = data[index]['firstName'];
            String fullname = "$sname $fname";
            String email = data[index]['email'];
            String sex = data[index]['sex'];
            String digits = data[index]['mobile_number'];
            String address = data[index]['address'];

            String message = "Addess: $address \nMobile: $digits \nEmail: $email \nSex: $sex";
            return ListTile(
              title: Text("$fullname"),

              subtitle: Text("$address \n$email \n$digits \n"),

              leading: CircleAvatar(
                backgroundColor: Colors.red,
                child: Text(
                  "$sex",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900
                  ),
                ),
              ),

              onTap: (){
                _showAlertMessage(context, fullname, message);
              },
            );

          },
        ),
      ),


    );
  }

  //Function to Show Alert Dialog for showing messages
  void _showAlertMessage(BuildContext context, String title, String message){
    var alert = new AlertDialog(
      title: Text("$title"),
      content: Text("$message"),

      actions: <Widget>[

        FlatButton(
          onPressed: (){Navigator.pop(context);},
          child: Text("OK"),
        )
      ],
    );

    showDialog(context: context, builder: (context)=> alert);
  }

  //Function to Show Alert Dialog for showing app details
  void _showAlertInfo(BuildContext context){
    var alert = new AlertDialog(
      title: Text("Info"),
      content: Text("Made With Flutter by JideGuru"),

      actions: <Widget>[

        FlatButton(
          onPressed: (){Navigator.pop(context);},
          child: Text("OK"),
        )
      ],
    );

    showDialog(context: context, builder: (context)=> alert);
  }
}
