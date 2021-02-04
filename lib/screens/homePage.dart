import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapplication/models/Category_Model.dart';
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
  List<CatergoryModel> categorySelection = <CatergoryModel>[
    CatergoryModel(
        img:
            'https://images.unsplash.com/photo-1590232918080-66313d51bd9f?ixid=MXwxMjA3fDB8MHxzZWFyY2h8M3x8YnVzc2luZXNzfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        name: 'Business',
        code: 'business'),
    CatergoryModel(
        img:
            'https://images.unsplash.com/photo-1496169514208-d9affacc58ba?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Nnx8ZW50ZXJ0YWlubWVudHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        name: 'Entertainment',
        code: 'entertainment'),
    CatergoryModel(
        img:
            'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NXx8Z2VuZXJhbHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        name: 'General',
        code: 'general'),
    CatergoryModel(
        img:
            'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?ixid=MXwxMjA3fDB8MHxzZWFyY2h8M3x8aGVhbHRofGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        name: 'Health',
        code: 'health'),
    CatergoryModel(
        img:
            'https://images.unsplash.com/photo-1532094349884-543bc11b234d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8c2NpZW5jZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        name: 'Science',
        code: 'science'),
    CatergoryModel(
        img:
            'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8c3BvcnRzfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        name: 'Sports',
        code: 'sports'),
    CatergoryModel(
        img:
            'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
        name: 'Technology',
        code: 'technology'),
  ];
  List<CountryNews> _list;
  bool isLoading = true;

  newsData() async {
    NewsIntegration newsIntegration = new NewsIntegration();
    await newsIntegration.newsData(widget.cntryCode);
    setState(() {
      isLoading = false;
    });
    // ApiIntegration.countryData(widget.cntryCode).then((value) async {
    //   var responseData = await value.stream.toBytes();
    //   var responseString = String.fromCharCodes(responseData);
    //   final _list = countryNewsFromJson(responseString);
    //   //print(articles);
    // });
    // ApiIntegration newsClass = new ApiIntegration();
    // await newsClass.countryData(widget.cntryCode);
    // _list = newsClass.news;
    // //print(_list.length);
    //
    // setState(() {
    //   isLoading = false;
    // });
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
          backgroundColor: Colors.transparent,
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
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Container(
                        padding: EdgeInsets.all(10),
                        height: 100,
                        //color: Colors.black26,
                        child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: categorySelection.length,
                          itemBuilder: (context, index) {
                            return CategoryTile(
                              picture: categorySelection[index].img,
                              name: categorySelection[index].name,
                              code: categorySelection[index].code,
                            );
                          },
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 90),
                        child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return ArticleTile();
                          },
                        )),
                  ],
                ),
              ));
  }
}

//Category Tile
class CategoryTile extends StatelessWidget {
  String picture, name, code;
  CategoryTile({this.code, this.name, this.picture});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(right: 10),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: picture,
                  width: 100,
                  height: 60,
                  fit: BoxFit.cover,
                )),
            Container(
              width: 100,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black38,
              ),
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArticleTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl:
                  'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'The Title Will be Here',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",
            style: TextStyle(
              fontSize: 15,
              color: Colors.black54,
            ),
          ),
          Text(
            'Publish Date:02/04/2021' + ' ' + 'Publish Time: 8:52',
            style: TextStyle(
              color: Colors.black26,
              fontSize: 10,
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
