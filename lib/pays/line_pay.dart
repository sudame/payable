import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:payable/payable.dart';

extension LINEPay on Payable {
  static Iterable<Store>? _linePayStores;

  Future<Iterable<Store>> getLINEPayStores() async {
    if (_linePayStores != null) {
      return _linePayStores!;
    }
    final uri = Uri.parse(
        'https://pay.line.me/portal/ajax/merchant/list?page=0&size=8&countryCode=JP&merchantCategory=OFFLINE');
    final response = await http.get(uri);
    final totalPages = jsonDecode(response.body)['data']['totalPages'];
    final futureResponses = List.generate(
            totalPages,
            (i) =>
                'https://pay.line.me/portal/ajax/merchant/list?page=$i&size=8&countryCode=JP&merchantCategory=OFFLINE')
        .map((url) => http.get(Uri.parse(url)));
    final responses = await Future.wait(futureResponses);
    final stores = responses
        .map((response) =>
            LINEPayStore.getStoresFromJson(jsonDecode(response.body)))
        .expand((element) => element);
    _linePayStores = stores;
    return stores;
  }
}

class LINEPayStore extends Store {
  LINEPayStore({required String name}) : super(name: name);

  static Iterable<LINEPayStore> getStoresFromJson(Map<String, dynamic> json) {
    final List<dynamic> rawStores = json['data']['merchantList'];

    return rawStores.map((e) => LINEPayStore(name: e['merchantName']));
  }
}
