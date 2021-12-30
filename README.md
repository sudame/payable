<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# Payable

支払いサービスに対応した店舗を取得するライブラリ

## Features

### 対応支払いサービス

- [x] PayPay
- [x] LINE Pay
- [ ] メルペイ
- [ ] 楽天Pay

## Getting started

### Installation

```shell
# flutter
flutter pub add payable --git-url https://github.com/sudame/payable.git

# dart
dart pub add payable --git-url https://github.com/sudame/payable.git
```

## Usage

```dart
import 'package:payable/payable.dart';

void main() async {
  final payable = Payable();
  final stores = await payable.getPayPayStores();

  for (var store in stores) {
    print(store.name);
  }
  // >>> will print >>>
  // セイコーマート
  // セブン‐イレブン
  // デイリーヤマザキ
  // ...
}
```

## Additional information

### Store Structure
```dart
class Store {
  final String name;
}
```
今後属性は必要に応じて追加予定
