library payable;

export 'package:payable/pays/line_pay.dart';
export 'package:payable/pays/paypay.dart';

typedef GetStore = Future<Iterable<Store>> Function();

class Payable {}

class Store {
  Store({required this.name});

  final String name;
}
