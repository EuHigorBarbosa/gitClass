abstract class PostException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  PostException(this.message, [this.stackTrace]);
}

class InvalidPostParams extends PostException{
  InvalidPostParams(String message) : super(message);
}