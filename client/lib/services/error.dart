abstract class UserVisibleError implements Exception {

  Exception _cause;

  UserVisibleError(this._cause);

  String get shortMessage;
  String get longMessage;
  Exception get cause {
    return _cause;
  }
}
