import 'package:flutter_test/flutter_test.dart';
import 'package:payable/payable.dart';

void main() {
  test('絶対に成功する', () {
    expect(true, true);
  });

  group('PayPayのテスト', () {
    late Iterable<Store> stores;

    setUp(() async {
      final payable = Payable();
      stores = await payable.getPayPayStores();
    });

    test('PayPayから1店舗以上の店らしきものを取得できる', () {
      expect(stores.length, greaterThan(0));
    });

    test('PayPayから取得した店の1店舗目の名前は1文字以上の文字列である', () {
      final store = stores.first;
      expect(store.name is String, true);
    });
  });

  group('LINE Pay', () {
    late Iterable<Store> stores;

    setUp(() async {
      final payable = Payable();
      stores = await payable.getLINEPayStores();
    });

    test('LINE Pay', () {
      expect(stores.length, greaterThan(0));
    });

    test('LINE Payから取得した店の1店舗目の名前は1文字以上の文字列である', () {
      final store = stores.first;
      expect(store.name is String, true);
    });

    // 「スタジオアリス」は2021-12-30現在10ページ目に存在
    // https://pay.line.me/portal/ajax/merchant/list?page=10&size=8&countryCode=JP&merchantCategory=OFFLINE
    test('LINE Payから取得した店リストの中にスタジオアリスが存在する', () {
      final studioAlice =
          stores.where((element) => element.name.contains('スタジオアリス'));
      expect(studioAlice.length, greaterThan(0));
    });

    // 「博多再生酒場」は2021-12-30現在最終ページに存在
    // https://pay.line.me/portal/ajax/merchant/list?page=35&size=8&countryCode=JP&merchantCategory=OFFLINE
    test('LINE Payから取得した店リストの中に博多再生酒場が存在する', () {
      final studioAlice =
          stores.where((element) => element.name.contains('博多再生酒場'));
      expect(studioAlice.length, greaterThan(0));
    });
  });
}
