// 直接パスを書かなくていいように、パスを定数として定義しておきます。
class RouterPath {
  // トップレベルのパスは、 / を付けます。
  static const String feed = '/feed';
  static const String shope = '/shope';
  static const String profile = '/profile';
  static const String details = 'details';// ネストしたパスは / を付けない
  static const String feedDetails = '/feed/details';// context.goで使うパス
}