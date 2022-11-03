class Batch {
  Batch({
    required this.id,
    required this.name,
    required this.items,
  });
  late final int id;
  late final String name;
  late final List<Items> items;

  Batch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    items = List.from(json['items']).map((e) => Items.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['items'] = items.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Items {
  Items({
    required this.name,
    required this.binNo,
    required this.orders,
    required this.img,
  });
  late final String name;
  late final String img;
  late final int binNo;
  late final List<Orders> orders;

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    binNo = json['binNo'];
    orders = List.from(json['orders']).map((e) => Orders.fromJson(e)).toList();
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['binNo'] = binNo;
    _data['img'] = img;
    _data['orders'] = orders.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Orders {
  Orders({
    required this.quantity,
    required this.orderNo,
  });
  late final String quantity;
  late final int orderNo;

  Orders.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    orderNo = json['orderNo'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['quantity'] = quantity;
    _data['orderNo'] = orderNo;
    return _data;
  }
}
