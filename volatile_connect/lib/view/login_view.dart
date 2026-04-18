import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../controller/auth_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _isObscured = true;

  bool _emailTemFormatoValido(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _processarLogin() {
    final email = _emailController.text.trim();
    final senha = _senhaController.text.trim();

    if (email.isEmpty || senha.isEmpty) {
      _exibirMensagem("Por favor, preencha todos os campos obrigatórios.");
      return;
    }

    if (!_emailTemFormatoValido(email)) {
      _exibirMensagem("O e-mail informado não possui um formato válido.");
      return;
    }

    final authController = GetIt.I<AuthController>();
    final resultado = authController.validarLogin(email, senha);

    if (resultado == "sucesso") {
      Navigator.pushReplacementNamed(context, 'home');
    } 
    else if (resultado == "usuario_inexistente") {
      _exibirMensagem("Credenciais desconhecidas. Cadastre-se para acessar.");
    } 
    else if (resultado == "senha_incorreta") {
      _exibirMensagem("Senha incorreta. Verifique e tente novamente.");
    }
  }

  void _exibirMensagem(String mensagem) {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 80),
              const Icon(Icons.biotech, size: 80, color: Color(0xFF1B3D2F)),
              const Text(
                'VolatileConnect',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1B3D2F)),
              ),
              const SizedBox(height: 50),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'E-mail', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _senhaController,
                obscureText: _isObscured,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _isObscured = !_isObscured),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, 'recuperar_senha'),
                  child: const Text('Esqueceu a senha?'),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _processarLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B3D2F),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Entrar', style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Não possui conta?"),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, 'cadastro'),
                    child: const Text('Cadastre-se', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }
}