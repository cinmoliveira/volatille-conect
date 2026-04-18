import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../controller/auth_controller.dart';

class RecuperarSenhaView extends StatefulWidget {
  const RecuperarSenhaView({super.key});

  @override
  State<RecuperarSenhaView> createState() => _RecuperarSenhaViewState();
}

class _RecuperarSenhaViewState extends State<RecuperarSenhaView> {
  final _emailController = TextEditingController();

  void _processarRecuperacao() {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      _exibirErro("Por favor, preencha o campo de e-mail.");
      return;
    }

    final bool emailValido =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
    if (!emailValido) {
      _exibirErro("E-mail inválido, insira seu e-mail ou cadastre-se.");
      return;
    }

    final authController = GetIt.I<AuthController>();
    final bool existeConta = authController.verificarEmailCadastrado(email);

    if (existeConta) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Instruções de redefinição enviadas para o seu e-mail!"),
          backgroundColor: Color(0xFF1B3D2F),
        ),
      );
      Navigator.pop(context);
    } else {
      _exibirErro("E-mail inválido, insira seu e-mail ou cadastre-se.");
    }
  }

  void _exibirErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: const Color(0xFFD32F2F),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recuperar Senha"),
        backgroundColor: const Color(0xFF1B3D2F),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Voltar',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.mail_outline,
                size: 100, color: Color(0xFF1B3D2F)),
            const SizedBox(height: 20),
            const Text(
              "Digite o e-mail associado à sua conta para recuperar o acesso.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "E-mail cadastrado",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _processarRecuperacao,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B3D2F),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Recuperar Senha",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}