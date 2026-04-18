import 'package:flutter/material.dart';
import '../model/planta.dart';

class VolatileController extends ChangeNotifier {
  // Lista com as imagens da rota assets\images
  final List<Planta> _plantas = [
    Planta(
      nome: 'Tomateiro',
      nomeCientifico: 'Solanum lycopersicum',
      categoria: 'Olerícola',
      imagem: 'assets/images/tomate.jpg',
      descricao: 'Planta modelo para estudos de defesa indireta e emissão de voláteis induzidos por herbivoria.',
      compostos: ['(Z)-3-hexenil acetato', 'Terpenoides', 'Metil salicilato'],
      insetos: ['Manduca sexta', 'Encarsia formosa'],
    ),
    Planta(
      nome: 'Macieira',
      nomeCientifico: 'Malus domestica',
      categoria: 'Frutífera',
      imagem: 'assets/images/macieira.jpg',
      descricao: 'Emite voláteis que atraem predadores naturais de ácaros e lagartas fitófagas.',
      compostos: ['E-beta-farneseno', 'Linalool'],
      insetos: ['Cydia pomonella', 'Apis mellifera'],
    ),
    Planta(
      nome: 'Milho',
      nomeCientifico: 'Zea mays',
      categoria: 'Cereal',
      imagem: 'assets/images/milho.jpg',
      descricao: 'Famoso pela emissão de voláteis das raízes e folhas para atrair nematoides predadores e vespas parasitoides.',
      compostos: ['Cariofileno', 'Indol', 'Homoterpenos'],
      insetos: ['Spodoptera frugiperda', 'Cotesia marginiventris'],
    ),
    Planta(
      nome: 'Soja',
      nomeCientifico: 'Glycine max',
      categoria: 'Oleaginosa',
      imagem: 'assets/images/soja.jpg',
      descricao: 'Planta de grande importância econômica com respostas complexas a percevejos fitófagos.',
      compostos: ['(E)-2-hexenal', '1-octen-3-ol'],
      insetos: ['Euschistus heros', 'Telenomus podisi'],
    ),
  ];

  List<Planta> get plantas => _plantas;

  void adicionarPlanta(Planta planta) {
    _plantas.add(planta);
    notifyListeners();
  }

  void removerPlanta(int index) {
    _plantas.removeAt(index);
    notifyListeners();
  }

  void editarPlanta(int index, Planta plantaEditada) {
    _plantas[index] = plantaEditada;
    notifyListeners();
  }
}