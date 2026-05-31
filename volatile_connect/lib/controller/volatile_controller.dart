import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../model/planta.dart';
import 'auth_controller.dart';

class VolatileController extends ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> listarPlantas() {
    final uid = GetIt.I<AuthController>().idUsuario();

    return db
        .collection('plantas')
        .where('uid', isEqualTo: uid)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> pesquisarPlantas() {
    final uid = GetIt.I<AuthController>().idUsuario();

    return db
        .collection('plantas')
        .where('uid', isEqualTo: uid)
        .snapshots();
  }

  Future<bool> adicionarPlanta(BuildContext context, Planta planta) async {
    try {
      final uid = GetIt.I<AuthController>().idUsuario();

      if (uid == null) {
        _exibirErro(context, 'Usuário não autenticado.');
        return false;
      }

      final plantaFirestore = Planta(
        uid: uid,
        nome: planta.nome,
        nomeCientifico: planta.nomeCientifico,
        categoria: planta.categoria,
        imagem: planta.imagem,
        descricao: planta.descricao,
        compostos: planta.compostos,
        insetos: planta.insetos,
      );

      await db.collection('plantas').add(plantaFirestore.toJson());

      _exibirSucesso(context, 'Planta cadastrada com sucesso!');
      notifyListeners();
      return true;
    } catch (e) {
      _exibirErro(context, 'Erro ao cadastrar planta.');
      return false;
    }
  }

  Future<bool> editarPlanta(
    BuildContext context,
    String id,
    Planta plantaEditada,
  ) async {
    try {
      final uid = GetIt.I<AuthController>().idUsuario();

      if (uid == null) {
        _exibirErro(context, 'Usuário não autenticado.');
        return false;
      }

      final plantaFirestore = Planta(
        uid: uid,
        nome: plantaEditada.nome,
        nomeCientifico: plantaEditada.nomeCientifico,
        categoria: plantaEditada.categoria,
        imagem: plantaEditada.imagem,
        descricao: plantaEditada.descricao,
        compostos: plantaEditada.compostos,
        insetos: plantaEditada.insetos,
      );

      await db.collection('plantas').doc(id).update(plantaFirestore.toJson());

      _exibirSucesso(context, 'Planta atualizada com sucesso!');
      notifyListeners();
      return true;
    } catch (e) {
      _exibirErro(context, 'Erro ao atualizar planta.');
      return false;
    }
  }

  Future<bool> removerPlanta(
    BuildContext context,
    String id,
    String nome,
  ) async {
    try {
      await db.collection('plantas').doc(id).delete();

      _exibirSucesso(context, '$nome removido com sucesso!');
      notifyListeners();
      return true;
    } catch (e) {
      _exibirErro(context, 'Erro ao remover planta.');
      return false;
    }
  }

  void _exibirSucesso(BuildContext context, String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: const Color(0xFF1B3D2F),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _exibirErro(BuildContext context, String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: const Color(0xFFD32F2F),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}