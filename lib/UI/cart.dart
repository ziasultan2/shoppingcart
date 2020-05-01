import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zia/model/Shopping.dart';
import 'package:zia/theme/Color.dart';

class Cart extends StatefulWidget {
  List<Shopping> shopping;

  Cart({Key key, this.shopping}) : super(key: key);
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  var t;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context, widget.shopping);
            }),
        title: Text('SHOPPING CART'),
      ),
      body: Container(
        child: Card(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: ListView(
              children: <Widget>[
                Column(
                  children: getList(),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'TOTAL',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        '\$${t.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColor.theme),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Colors.pink,
          width: MediaQuery.of(context).size.width,
          child: FlatButton(
            onPressed: () async {
//              Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                    builder: (context) => Continuing(
//                      shopping: widget.shopping,
//                    ),
//                  ));

//                                    shopping.forEach( (item) => print(item.quantity));
            },
            color: Colors.pink,
            child: Text(
              "CONTINUE",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Raleway',
                fontSize: 18.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getList() {
    List<Widget> listItem = [];
    var sum = 0.00;
    for (int i = 0; i < widget.shopping.length; i++) {
      var total = widget.shopping[i].price * widget.shopping[i].quantity;
      listItem.add(
        Container(
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3.0,
                    blurRadius: 5.0)
              ],
              color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    height: 90,
                    child: CachedNetworkImage(
                      imageUrl: 'http://www.layzeyapp.com/layzey/storage/app/' +
                          widget.shopping[i].url,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.shopping[i].name.toUpperCase(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: (MediaQuery.of(context).size.width > 375)
                              ? 16
                              : 14,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      '\$${widget.shopping[i].price}',
                      style: TextStyle(
                          fontSize: (MediaQuery.of(context).size.width > 375)
                              ? 18
                              : 16,
                          color: AppColor.priceColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Quantity',
                          style: TextStyle(
                            fontSize: (MediaQuery.of(context).size.width > 375)
                                ? 16
                                : 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Flexible(
                          child: IconButton(
                              icon: Icon(
                                Icons.indeterminate_check_box,
                                color: AppColor.fontColor,
                                size: (MediaQuery.of(context).size.width > 375)
                                    ? 25
                                    : 16,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (widget.shopping[i].quantity > 1) {
                                    widget.shopping[i].quantity--;

                                    widget.shopping[i].itemTotal -=
                                        widget.shopping[i].price;
                                    print(widget.shopping[i].itemTotal);
                                  }
                                });
                              }),
                        ),
                        Text('${widget.shopping[i].quantity}'),
                        Flexible(
                          child: IconButton(
                            icon: Icon(
                              Icons.add_box,
                              color: AppColor.theme,
                              size: (MediaQuery.of(context).size.width > 375)
                                  ? 25
                                  : 16,
                            ),
                            onPressed: () {
                              setState(() {
                                widget.shopping[i].quantity++;
                                widget.shopping[i].itemTotal +=
                                    widget.shopping[i].price;
                              });
                            },
                            color: AppColor.theme,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Flexible(
                  flex: 2,
                  child: Text(
                    '\$${widget.shopping[i].itemTotal.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )),
              Flexible(
                flex: 1,
                child: IconButton(
                    icon: Icon(
                      Icons.close,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.shopping.removeAt(i);
                      });
                    }),
              ),
            ],
          ),
        ),
      );
      sum += total;
    }
    setState(() {
      t = sum;
    });

    return listItem;
  }
}
