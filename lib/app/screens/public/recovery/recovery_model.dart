class RecoveryModel {
  String? _email;
  String? _code;
  final Map<String, String> _errorMessages = {};

  set setEmail(String value) {
    _email = value;
  }

  String? get email => _email;

  set setCode(String value) {
    _code = value;
  }

  String? get code => _code;

  void setError(String field, String message) {
    _errorMessages[field] = message;
  }

  String? getError(String field) {
    return _errorMessages[field];
  }

  void clearErrors() {
    _errorMessages.clear();
  }

  String? validateEmail() {
    clearErrors();
    if (_email == null || _email!.isEmpty) {
      setError('email', "E-mail não pode estar vazio");
      return getError('email');
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(_email!)) {
      setError('email', "E-mail inválido");
      return getError('email');
    }
    return null;
  }

  String? validateCode() {
    clearErrors();
    if (_code == null || _code!.isEmpty) {
      setError('code', "Código não pode estar vazio");
      return getError('code');
    }
    return null;
  }

  List<String> validateAll() {
    clearErrors();
    validateEmail();
    validateCode();
    return _errorMessages.values.toList();
  }
}
