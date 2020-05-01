import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zia/UI/Category.dart';
import 'package:zia/model/category.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<CategoryModel>> _getCategory() async {
    var data =
        await http.get('https://layzeyapp.com/api/v1/user/category', headers: {
      "Accept": "application/json",
      'Authorization':
          'JnpkcTeXF6h2maUyLYIs8wBsiZZte6Zsdku0tUASLqwE39FGhNykmal3yWDG'
    });
    var jsonData = json.decode(data.body);
    List<CategoryModel> categories = [];

    for (var o in jsonData) {
      CategoryModel categoryModel =
          CategoryModel(o['id'], o['name'], o['image'], 0);
      categories.add(categoryModel);
    }
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 30, left: 15, right: 10),
        child: FutureBuilder(
          future: _getCategory(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              );
            } else {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 20,
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Padding(
                        padding: EdgeInsets.only(
                            top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
                        child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Category(snapshot.data[index].id),
                              ));
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width / 2.4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 3.0,
                                          blurRadius: 5.0)
                                    ],
                                    color: Colors.white),
                                child: Column(children: [
                                  Hero(
                                      tag: snapshot.data[index].id,
                                      child: Container(
                                          padding: EdgeInsets.all(10),
                                          height: 120,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      'http://www.layzeyapp.com/layzey/storage/app/' +
                                                          snapshot.data[index]
                                                              .image),
                                                  fit: BoxFit.contain)))),
                                  SizedBox(height: 15.0),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(snapshot.data[index].name,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Color(0xFF575E67),
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ]))));
                  });
            } // else
          },
        ),
      ),
    );
  }
}
