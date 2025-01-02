abstract class Failure {
  final String? message;

  Failure([this.message]); // Mensaje opcional
}

// Fallo al comunicarse con el servidor
class ServerFailure extends Failure {
  ServerFailure([super.message]);
}

// Fallo relacionado con almacenamiento local (SQLite, SharedPreferences, etc.)
class LocalFailure extends Failure {
  LocalFailure([super.message]);
}

// Fallo de validación (por ejemplo, datos inválidos proporcionados por el usuario)
class ValidationFailure extends Failure {
  ValidationFailure([super.message]);
}

// Fallo relacionado con autenticación (login fallido, token expirado, etc.)
class AuthenticationFailure extends Failure {
  AuthenticationFailure([super.message]);
}
