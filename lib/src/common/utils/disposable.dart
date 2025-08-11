import 'dart:async';

/// A contract for classes that manage resources requiring a cleanup or closure action.
///
/// Implementing classes must define the [dispose] method, which returns a [Future]
/// to handle any asynchronous operations needed for safely closing the resource.
abstract interface class Disposable {
  /// Disposes of the resource.
  ///
  /// This method should be called to release any resources held by the object.
  FutureOr<void> dispose();
}
