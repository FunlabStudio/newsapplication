import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapplication/models/Country_Model.dart';
import 'package:newsapplication/screens/homePage.dart';

class CountrySelection extends StatefulWidget {
  @override
  _CountrySelectionState createState() => _CountrySelectionState();
}

class _CountrySelectionState extends State<CountrySelection> {
  List<CountryModel> countrySelection = <CountryModel>[
    CountryModel(
      imgUrl: 'https://www.worldometers.info/img/flags/small/tn_ca-flag.gif',
      countryCode: 'ca',
      countryName: 'Canada',
    ),
    CountryModel(
      imgUrl: 'https://www.worldometers.info/img/flags/small/tn_ca-flag.gif',
      countryCode: 'ca',
      countryName: 'Pakistan',
    ),
    CountryModel(
      imgUrl: 'https://www.worldometers.info/img/flags/small/tn_ca-flag.gif',
      countryCode: 'ca',
      countryName: 'Canada',
    ),
    CountryModel(
      imgUrl: 'https://www.worldometers.info/img/flags/small/tn_ca-flag.gif',
      countryCode: 'ca',
      countryName: 'Canada',
    ),
    CountryModel(
      imgUrl: 'https://www.worldometers.info/img/flags/small/tn_ca-flag.gif',
      countryCode: 'ca',
      countryName: 'Canada',
    ),
    CountryModel(
      imgUrl: 'https://www.worldometers.info/img/flags/small/tn_ca-flag.gif',
      countryCode: 'ca',
      countryName: 'Canada',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Daily',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'News',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: countrySelection.length,
          itemBuilder: (context, index) {
            return CountryTile(
              imageUrl: countrySelection[index].imgUrl,
              countryCode: countrySelection[index].countryCode,
              countryName: countrySelection[index].countryName,
            );
          },
        )),
      ),
      //
    );
  }
}

class CountryTile extends StatelessWidget {
  final imageUrl, countryName, countryCode;
  CountryTile({this.imageUrl, this.countryName, this.countryCode});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      image: imageUrl,
                      cntryName: countryName,
                    )));
      },
      child: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 400,
                    height: 200,
                    fit: BoxFit.cover,
                  )),
              Container(
                width: 400,
                height: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black38,
                ),
                child: Text(
                  countryName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
