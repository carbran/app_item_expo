import 'package:get/utils.dart';
import 'package:item_expo/utils/helpers.dart';

int daysInMonth(int month, int year) {
  int days = 28 +
      (month + (month / 8).floor()) % 2 +
      2 % month +
      2 * (1 / month).floor();
  return (isLeapYear(year) && month == 2) ? 29 : days;
}

bool isLeapYear(int year) =>
    ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0);

String? Function(String?)? nameValidator = (String? name) {
  name ??= '';
  final regex = RegExp(r'[A-Za-zÀ-ÖØ-öø-ÿ\s]+');
  if (name.isEmpty ||
      name.trim().split(' ').length <= 1 ||
      name.length < 4 ||
      !regex.hasMatch(name)) {
    return 'Insira um nome válido';
  }
  return null;
};

String? Function(String?)? birthdateValidator = (String? date) {
  date ??= '';
  if (date.isEmpty) {
    return null;
  }

  List<String> inputs = date.split('/');

  int day = int.tryParse(inputs[0]) ?? 0;
  int month = int.tryParse(inputs[1]) ?? 0;
  int year = int.tryParse(inputs[2]) ?? 0;

  var now = DateTime.now();

  if (month > 12 ||
      month < 1 ||
      day < 1 ||
      day > daysInMonth(month, year) ||
      year > now.year ||
      (year >= now.year && month > now.month) ||
      (year >= now.year && month >= now.month && day > now.day)) {
    return 'Insira uma data de nascimento válida';
  }

  return null;
};

String? Function(String?)? cpfValidator = (String? cpf) {
  cpf ??= '';
  if (!GetUtils.isCpf(cpf)) {
    return 'Insira um CPF válido';
  }
  return null;
};

String? Function(String?)? cnpjValidator = (String? cnpj) {
  cnpj ??= '';
  if (!GetUtils.isCnpj(cnpj)) {
    return 'Insira um CNPJ válido';
  }
  return null;
};

String? Function(String?)? cpfCnpjValidator = (String? cpfCpnj) {
  String? cpfCpnjFormatted = Helpers.onlyNumbers(cpfCpnj ?? '');

  if (cpfCpnjFormatted.length != 11 && cpfCpnjFormatted.length != 14) {
    return 'Insira um CPF ou CNPJ válido';
  } else if (cpfCpnjFormatted.length == 11) {
    return cpfValidator!(cpfCpnjFormatted);
  } else if (cpfCpnjFormatted.length == 14) {
    return cnpjValidator!(cpfCpnjFormatted);
  }
  return null;
};

String? Function(String?)? emailValidator = (String? email) {
  if (!GetUtils.isEmail(email ?? '')) {
    return 'Insira um endereço de e-mail válido';
  }
  return null;
};

String? Function(String?)? telValidator = (String? tel) {
  tel ??= '';
  if (!GetUtils.isPhoneNumber(tel)) {
    return 'Insira um telefone válido';
  }
  return null;
};

String? Function(String?)? passwordValidator = (String? password) {
  password ??= '';
  bool minUpperChar = RegExp(r'[A-Z]').hasMatch(password);
  bool minLowerChar = RegExp(r'[a-z]').hasMatch(password);
  bool hasNumber = RegExp(r'\d').hasMatch(password);

  if (password.isEmpty ||
      password.length < 8 ||
      !minUpperChar ||
      !minLowerChar ||
      !hasNumber) {
    return '- No mínimo 8 caracteres\n- Ao menos uma letra maiúscula\n- Ao menos uma letra minúscula\n- Ao menos um número';
  }
  return null;
};

String? Function(String?)? cepValidator = (String? cep) {
  cep ??= '';
  final cepReplace =
      cep.replaceAll(RegExp('-'), '').replaceAll(RegExp('_'), '');
  if (!GetUtils.isNum(cepReplace) || cepReplace.length < 8) {
    return 'Insira um CEP válido';
  }
  return null;
};

String? Function(String?)? genderValidator = (String? gender) {
  return gender == null ? 'Selecione um gênero' : null;
};

String? normalTextValidator(String? text, String message) {
  if (text == null || text.trim().isEmpty || text.length < 3) {
    return message;
  }
  return null;
}
