abstract class Failure implements Exception {
  const Failure();

  String get message;

  @override
  String toString() {
    return '$runtimeType Exception';
  }
}

class GeneralException extends Failure {
  const GeneralException();

  @override
  String get message => 'An error has occurred. Please try again later.';
}

//API Exceptions
class APIException extends Failure {
  const APIException({
    required this.code,
    this.textCode,
  });

  final int code;
  final String? textCode;

  @override
  String get message {
    if (textCode != null) {
      switch (textCode) {
        case 'invalid-headers':
        case 'validation-failed':
          return 'Bad request. Check you request and try again.';
        default:
          return 'An internal error ocurred. Please try again later.';
      }
    }
    switch (code) {
      case 400:
        return 'Bad request. Check you request and try again.';
      case 401:
        return 'User not authorized to access this resource at this time. Please reauthenticate';
      case 404:
        return 'It was not possible to finish this operation. Please try again later';
      case 503:
        return 'Service unavailable at this time. Please try again later.';
      default:
        return 'An internal error ocurred. Please try again later.';
    }
  }
}

//Services Exceptions
class AuthException extends Failure {
  const AuthException({
    required this.code,
  });

  final String code;

  @override
  String get message {
    switch (code) {
      case 'session-expired':
      case 'invalid-jwt':
      case 'invalid-headers':
      case 'user-not-authenticated':
        return 'Sua sessão expirou. Por favor, faça login novamente.';
      case 'email-already-exists':
        return 'O e-mail fornecido já está em uso. Por favor, verifique suas informações ou crie uma nova conta.';
      case 'user-not-found':
        return 'O e-mail fornecido não foi encontrado. Por favor, verifique suas informações.';
      case 'wrong-password':
        return 'A senha está incorreta. Por favor, verifique suas informações.';
      case 'reset-code-exists':
        return 'Você já solicitou um código de redefinição. Utilize o código anterior ou aguarde o tempo de expiração.';
      case 'network-request-failed':
        return 'Não foi possível conectar ao servidor remoto. Por favor, verifique sua conexão e tente novamente.';
      case 'too-many-requests':
        return 'Devido a tentativas consecutivas falhas. Por favor aguarde um pouco e tente novamente em alguns momentos.';
      case 'internal':
        return 'Não foi possível criar sua conta neste momento. Por favor, verifique suas informações e tente novamente.';
      case 'code-sent':
        return 'O código de redefinição foi enviado com sucesso.';
      case 'wait-to-resend':
        return 'Por favor, aguarde 30 segundos para enviar um novo código.';
      default:
        return 'Ocorreu um erro interno. Por favor, tente novamente mais tarde.';
    }
  }
}

class SecureStorageException extends Failure {
  const SecureStorageException();

  @override
  String get message => 'An error has occurred while fetching Secure Storage.';
}

class CacheException extends Failure {
  const CacheException({required this.code});

  final String code;

  @override
  String get message {
    switch (code) {
      case 'write':
        return 'An error has occurred while writing data into local cache.';
      case 'read':
        return 'An error has occurred while reading data into local cache.';
      case 'delete':
        return 'An error has occurred while delete data from local cache.';
      case 'update':
        return 'An error has occurred while updating data from local cache.';
      default:
        return 'An error has occurred while accessing local cache.';
    }
  }
}

class UserException extends Failure {
  const UserException({required this.code});

  final String code;

  @override
  String get message {
    switch (code) {
      case 'user-not-found':
        return 'Usuário não encontrado';
      default:
        return 'Erro interno do servidor, por favor tente novamente mais tarde.';
    }
  }
}

// class UserDataException extends Failure {
//   const UserDataException({required this.code});

//   final String code;

//   @override
//   String get message {
//     switch (code) {
//       case 'error':
//         return 'An error has occurred while fetching user data.';
//       case 'update-username':
//         return 'An error has occurred while updating user name. Please try again later.';
//       case 'update-password':
//         return 'An error has occurred while updating user password. Please try again later.';
//       case 'delete-account':
//         return 'An error has occurred while deleting user account. Please try again later.';
//       case 'not-found':
//         return 'User data not found. Please login again.';
//       case 'requires-recent-login':
//         return 'Due to security reasons, you need to login again to perform this action.';
//       case 'unavailable':
//         return 'It was not possible to update user data at this time. Please try again later.';
//       default:
//         return 'An internal error has ocurred while update user data. Please try again later.';
//     }
//   }
// }

//System Exceptions
class ConnectionException extends Failure {
  const ConnectionException({
    required this.code,
  });

  final String code;

  @override
  String get message {
    switch (code) {
      case 'connection-error':
        return 'It was not possible to connect to the remote server. Please check you connection and try again.';
      default:
        return 'An internal error ocurred. Please try again later.';
    }
  }
}

class SyncException extends Failure {
  const SyncException({required this.code});

  final String code;
  @override
  String get message {
    switch (code) {
      case 'error':
        return 'Error while syncing. Please restart the app or relogin.';
      default:
        return 'unkown error';
    }
  }
}
