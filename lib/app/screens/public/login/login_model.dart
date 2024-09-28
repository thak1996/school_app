enum FieldType {
  email,
  password,
}

class LoginModel {
  String? _email;
  String? _password;
  final Map<FieldType, String> _errorMessages = {};

  set setEmail(String value) {
    _email = value;
  }

  String? get email => _email;

  set setPassword(String value) {
    _password = value;
  }

  String? get password => _password;

  void setError(FieldType field, String message) {
    _errorMessages[field] = message;
  }

  String? getError(FieldType field) {
    return _errorMessages[field];
  }

  String? validateEmail() {
    if (_email == null || _email!.isEmpty) {
      setError(FieldType.email, "E-mail não pode estar vazio");
      return getError(FieldType.email);
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(_email!)) {
      setError(FieldType.email, "E-mail inválido");
      return getError(FieldType.email);
    }
    return null;
  }

  String? validatePassword() {
    if (_password == null || _password!.isEmpty) {
      setError(FieldType.password, "Senha não pode estar vazia");
      return getError(FieldType.password);
    }
    // final passwordRegex = RegExp(
    //   r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%^&*])[A-Za-z\d!@#\$%^&*]{8,}$',
    // );
    // if (!passwordRegex.hasMatch(_password!)) {
    //   setError(FieldType.password,
    //       "A senha deve conter pelo menos uma letra maiúscula, uma letra minúscula, um número e um caractere especial");
    //   return getError(FieldType.password);
    // }
    if (_password!.length < 6) {
      setError(FieldType.password, "A senha deve ter pelo menos 6 caracteres");
      return getError(FieldType.password);
    }
    return null;
  }

  List<String> validateAll() {
    _errorMessages.clear();
    validateEmail();
    validatePassword();
    return _errorMessages.values.toList();
  }
}
