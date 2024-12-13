// ignore_for_file: constant_identifier_names

enum SizeTypeEnum {
  paginas(0),
  centimetros(1),
  LxH(2),
  LxBxH(3);

  final int valor;

  const SizeTypeEnum(this.valor);

  static const Map<int, String> nome = {
    0: 'pag.',
    1: 'cm',
    2: 'LxH (cm)',
    3: 'LxBxH (cm)'
  };
}
