// ignore_for_file: constant_identifier_names

enum ConditionEnum {
  Terrivel(0),
  Ruim(1),
  Justo(2),
  Bom(3),
  Excelente(4);

  final int valor;

  const ConditionEnum(this.valor);

  static const Map<int, String> nome = {
    0: 'terrivel',
    1: 'ruim',
    2: 'justo',
    3: 'bom',
    4: 'excelente',
  };
}
