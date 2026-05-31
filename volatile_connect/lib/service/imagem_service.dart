import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/imagem_planta.dart';

class ImagemService {

// necessário inserir a própria chave API em: https://www.pexels.com/api/
  static const String _apiKey =
      'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';

  Future<ImagemPlanta?> buscarImagem(
    String nomeCientifico,
  ) async {

    final resposta = await http.get(
      Uri.parse(
        'https://api.pexels.com/v1/search?query=$nomeCientifico&per_page=1',
      ),
      headers: {
        'Authorization': _apiKey,
      },
    );

    if (resposta.statusCode == 200) {

      final dados = jsonDecode(resposta.body);

      if (dados['photos'] != null &&
          dados['photos'].isNotEmpty) {

        return ImagemPlanta.fromJson(
          dados['photos'][0],
        );
      }
    }

    return null;
  }
}