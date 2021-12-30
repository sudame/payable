import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:payable/payable.dart';

extension PayPay on Payable {
  static Iterable<Store>? _paypayStores;

  Future<Iterable<Store>> getPayPayStores() async {
    if (_paypayStores != null) {
      return _paypayStores!;
    }
    final uri = Uri.parse('https://paypay.ne.jp/shop/');
    final response = await http.get(uri);
    final doc = parse(response.body);
    final stores = doc
        .querySelectorAll('.storeList__caption')
        .map((element) => Store(name: element.text));
    _paypayStores = stores;
    return stores;
  }
}
