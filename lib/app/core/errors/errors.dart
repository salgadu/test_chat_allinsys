abstract class Failure implements Exception {
  final String message;

  Failure(this.message);
}

class ParamtersEmptyError extends Failure {
  ParamtersEmptyError({required String message}) : super(message);
}

class ServerException extends Failure {
  ServerException({required String message}) : super(message);
}

class FileException extends Failure {
  FileException({required String message}) : super(message);
}
