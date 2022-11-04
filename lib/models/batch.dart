class Batch {
  Batch({
    required this.id,
    required this.name,
    required this.items,
    required this.isComplete,
  });
  late final int id;
  late final String name;
  late final List<Items> items;
  late bool isComplete;

  Batch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isComplete = json['isComplete'];
    items = List.from(json['items']).map((e) => Items.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['isComplete'] = isComplete;
    _data['items'] = items.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Items {
  Items({
    required this.name,
    required this.isPicked,
    required this.binNo,
    required this.orders,
    required this.notes,
    required this.img,
  });
  late final String name, img;
  late String notes, binNo;
  late bool isPicked;
  late final List<Orders> orders;

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    binNo = json['binNo'];
    img = json['img'];
    notes = json['notes'];
    isPicked = json['isPicked'];
    orders = List.from(json['orders']).map((e) => Orders.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['binNo'] = binNo;
    _data['img'] = img;
    _data['notes'] = notes;
    _data['isPicked'] = isPicked;
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
