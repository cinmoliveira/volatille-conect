class Planta {
  String nome;
  String nomeCientifico;
  String categoria;
  String imagem;
  String descricao;
  List<String> compostos;
  List<String> insetos;

  Planta({
    required this.nome,
    required this.nomeCientifico,
    required this.categoria,
    required this.imagem,
    required this.descricao,
    required this.compostos,
    required this.insetos,
  });
}