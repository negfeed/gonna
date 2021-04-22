abstract class UserVisibleError implements Exception {

  Exception _cause;

  UserVisibleError(this._cause);

  String get shortMessage;
  String get longMessage;
  Exception get cause {
    return _cause;
  }
}

// This error class is meant to replace all non-UserVisibleErrors that are thrown
// from services back to widgets. This way the widgets can consistently handle
// errors thrown on service function calls.
class CatchAllError extends UserVisibleError {
  CatchAllError(Exception cause) : super(cause);

  @override
  String get longMessage => 'Oops, something went wrong. Please try again later.';

  @override
  String get shortMessage => 'Please try again later.';
}