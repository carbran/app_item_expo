class Helpers {
  static String onlyNumbers(String value) {
    // RegExp exp = RegExp(r'[./-]');
    RegExp exp = RegExp(r'[^\d]+');

    return value.replaceAll(exp, '');
  }

  static String formattedDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().
    padLeft(2, '0')}/${date.year.toString()}";
  }

  static String? formattedCpfCnpj(String? cpfCnpj) {
    if (cpfCnpj == null) {
      return '';
    } else if (cpfCnpj.length < 11) {
      return cpfCnpj.padLeft(11, '0');
    } else if (cpfCnpj.length > 11 && cpfCnpj.length < 14) {
      return cpfCnpj.padLeft(14, '0');
    } else {
      return cpfCnpj;
    }
  }
}