class Planta {
  String uid;
  String nome;
  String nomeBusca;
  String nomeCientifico;
  String categoria;
  String imagem;
  String descricao;
  List<String> compostos;
  List<String> insetos;

  Planta({
    this.uid = '',
    required this.nome,
    String? nomeBusca,
    required this.nomeCientifico,
    required this.categoria,
    required this.imagem,
    required this.descricao,
    required this.compostos,
    required this.insetos,
  }) : nomeBusca = nomeBusca ?? nome.toLowerCase();

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'nome': nome,
      'nomeBusca': nome.toLowerCase(),
      'nomeCientifico': nomeCientifico,
      'categoria': categoria,
      'imagem': imagem,
      'descricao': descricao,
      'compostos': compostos,
      'insetos': insetos,
    };
  }

  factory Planta.fromJson(Map<String, dynamic> json) {
    return Planta(
      uid: json['uid'] ?? '',
      nome: json['nome'] ?? '',
      nomeBusca: json['nomeBusca'] ?? '',
      nomeCientifico: json['nomeCientifico'] ?? '',
      categoria: json['categoria'] ?? '',
      imagem: json['imagem'] ?? '',
      descricao: json['descricao'] ?? '',
      compostos: List<String>.from(json['compostos'] ?? []),
      insetos: List<String>.from(json['insetos'] ?? []),
    );
  }
}