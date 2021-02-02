import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapplication/models/country_wise_news.dart';
import 'package:newsapplication/screens/login.dart';
import 'package:newsapplication/service/Api_integration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final String image, cntryCode;
  HomePage({this.image, this.cntryCode});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Article> list;

  newsData() async {
    // ApiIntegration.countryData(widget.cntryCode).then((value) async {
    //   var responseData = await value.stream.toBytes();
    //   var responseString = String.fromCharCodes(responseData);
    //   final _list = countryNewsFromJson(responseString);
    //   //print(articles);
    // });
    ApiIntegration newsClass = new ApiIntegration();
    var data = await newsClass.countryData(widget.cntryCode);
    list = newsClass;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cntryCode),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('UserId');
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Text(list[index].title);
          },
        ),
      ),
    );
  }
}
