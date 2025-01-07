/// An interface representing a closable resource.
///
/// [Closable] defines a contract for classes that manage resources requiring
/// a cleanup or closure action. Implementing classes must define the [close]
/// method, which returns a [Future] to handle any asynchronous operations
/// needed for safely closing the resource.
abstract interface class Closable {
  Future<void> close();
}
