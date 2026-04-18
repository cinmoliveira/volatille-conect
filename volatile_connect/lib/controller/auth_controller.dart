import 'package:flutter/material.dart';
import '../model/usuario.dart';

class AuthController extends ChangeNotifier {
  final List<Usuario> _usuarios = [];

  void cadastrar(String nome, String email, String telefone, String senha) {
    _usuarios.add(Usuario(
      nome: nome,
      email: email,
      telefone: telefone,
      senha: senha,
    ));
    notifyListeners();
  }

  String validarLogin(String email, String senha) {
    final existeUsuario = _usuarios.any((u) => u.email == email);
    if (!existeUsuario) return "usuario_inexistente";

    final senhaCorreta = _usuarios.any((u) => u.email == email && u.senha == senha);
    if (!senhaCorreta) return "senha_incorreta";

    return "sucesso";
  }

  //para valida se a conta existe
  bool verificarEmailCadastrado(String email) {
    return _usuarios.any((u) => u.email == email);
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