import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/usuario.dart';

class AuthController extends ChangeNotifier {
  final List<Usuario> _usuarios = [];

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> cadastrar(
    String nome,
    String email,
    String telefone,
    String senha,
  ) async {
    try {
      final resultado = await auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      await resultado.user?.updateDisplayName(nome);

      await db.collection('usuarios').add({
        'uid': resultado.user!.uid,
        'nome': nome,
        'email': email,
        'telefone': telefone,
      });

      _usuarios.add(
        Usuario(
          nome: nome,
          email: email,
          telefone: telefone,
          senha: senha,
        ),
      );

      notifyListeners();
      return "sucesso";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return "email_ja_cadastrado";
        case 'invalid-email':
          return "email_invalido";
        case 'weak-password':
          return "senha_fraca";
        default:
          return "erro_cadastro";
      }
    } catch (e) {
      return "erro_cadastro";
    }
  }

  Future<String> validarLogin(String email, String senha) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );

      notifyListeners();
      return "sucesso";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return "email_invalido";
        case 'user-not-found':
          return "usuario_inexistente";
        case 'wrong-password':
          return "senha_incorreta";
        case 'invalid-credential':
          return "credenciais_invalidas";
        case 'user-disabled':
          return "usuario_desativado";
        default:
          return "erro_login";
      }
    } catch (e) {
      return "erro_login";
    }
  }

  Future<String> recuperarSenha(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return "sucesso";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return "email_invalido";
        case 'user-not-found':
          return "usuario_inexistente";
        default:
          return "erro_recuperacao";
      }
    } catch (e) {
      return "erro_recuperacao";
    }
  }

  Future<void> logout() async {
    await auth.signOut();
    notifyListeners();
  }

  String? idUsuario() {
    return auth.currentUser?.uid;
  }

  String? nomeUsuario() {
    return auth.currentUser?.displayName;
  }

  String? emailUsuario() {
    return auth.currentUser?.email;
  }

  Future<String> usuarioLogado() async {
    final uid = idUsuario();

    if (uid == null) {
      return "";
    }

    final resultado = await db
        .collection('usuarios')
        .where('uid', isEqualTo: uid)
        .get();

    if (resultado.docs.isNotEmpty) {
      return resultado.docs[0].data()['nome'] ?? '';
    }

    return auth.currentUser?.email ?? '';
  }

  bool verificarEmailCadastrado(String email) {
    final usuarioLocal = _usuarios.any((u) => u.email == email);
    final usuarioFirebase = auth.currentUser?.email == email;

    return usuarioLocal || usuarioFirebase;
  }

  bool atualizarSenha(String email, String novaSenha) {
    int index = _usuarios.indexWhere((u) => u.email == email);

    if (index != -1) {
      _usuarios[index] = Usuario(
        nome: _usuarios[index].nome,
        email: _usuarios[index].email,
        telefone: _usuarios[index].telefone,
        senha: novaSenha,
      );

      notifyListeners();
      return true;
    }

    return false;
  }
}