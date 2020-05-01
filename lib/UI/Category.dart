import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zia/model/productModel.dart';
import 'package:http/http.dart' as http;
import 'package:zia/theme/Color.dart';

class Category extends StatefulWidget {
  var id;
  Category(@required this.id);
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  Future<List<ProductModel>> _getProducts() async {
    var data = await http.get(
        'https://layzeyapp.com/api/v1/user/category/${widget.id}',
        headers: {
          "Accept": "application/json",
          'Authorization':
              'JnpkcTeXF6h2maUyLYIs8wBsiZZte6Zsdku0tUASLqwE39FGhNykmal3yWDG'
        });
    var jsonData = json.decode(data.body);

    List<ProductModel> products = [];

    for (var o in jsonData) {
      ProductModel productModel = ProductModel(
          o['id'], o['name'], o['image'], o['price'].toDouble(), 0);
      products.add(productModel);
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('name'),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: ListView(
          children: <Widget>[
            FutureBuilder(
              future: _getProducts(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  );
                } else {
                  return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 0,
                      ),
//                          childAspectRatio: 16 / 19),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Padding(
                            padding: EdgeInsets.only(
                                top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
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
                              child: Stack(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Image(
                                          image: new NetworkImage(
                                              'http://www.layzeyapp.com/layzey/storage/app/' +
                                                  snapshot.data[index].image),
                                          fit: BoxFit.contain,
                                          height: 100.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 16,
                                            child: Text(
                                              '${snapshot.data[index].name}',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 15),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 8,
                                            child: Text(
                                              '\$${snapshot.data[index].price.toStringAsFixed(2)}',
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.cloud_done,
                                          size: 30,
                                          color: Colors.lightGreen,
                                        ),
                                        onPressed: null),
                                  )
                                ],
                              ),
                            ));
                      });
                } // else
              },
            ),
          ],
        ),
      ),
    );
  }
}
