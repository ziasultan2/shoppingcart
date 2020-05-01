class Shopping {
  int _id;
  String _name;
  String _url;
  double _price;
  int _quantity;
  double _itemTotal;

  Shopping(this._id, this._name, this._url, this._price, this._quantity,
      this._itemTotal);

  int get quantity => _quantity;

  set quantity(int value) {
    _quantity = value;
  }

  double get price => _price;

  set price(double value) {
    _price = value;
  }

  double get itemTotal => _itemTotal;

  set itemTotal(double value) {
    _itemTotal = value;
  }

  String get url => _url;

  set url(String value) {
    _url = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.id;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    return data;
  }
}
