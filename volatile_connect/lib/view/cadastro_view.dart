import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../controller/auth_controller.dart';

class CadastroView extends StatefulWidget {
  const CadastroView({super.key});

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();
  bool _isObscured = true;

  bool _emailTemFormatoValido(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _processarCadastro() async {
    final nome = _nomeController.text.trim();
    final email = _emailController.text.trim();
    final telefone = _telefoneController.text.trim();
    final senha = _senhaController.text.trim();
    final confirma = _confirmarSenhaController.text.trim();

    if (nome.isEmpty ||
        email.isEmpty ||
        telefone.isEmpty ||
        senha.isEmpty ||
        confirma.isEmpty) {
      _exibirErro("Por favor, preencha todos os campos obrigatórios.");
      return;
    }

    if (!_emailTemFormatoValido(email)) {
      _exibirErro("O formato do e-mail informado é inválido.");
      return;
    }

    if (senha != confirma) {
      _exibirErro("A confirmação de senha não confere com a senha digitada.");
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Criando conta..."),
        backgroundColor: Color(0xFF1B3D2F),
        behavior: SnackBarBehavior.floating,
      ),
    );

    final resultado = await GetIt.I<AuthController>().cadastrar(
      nome,
      email,
      telefone,
      senha,
    );

    if (resultado == "sucesso") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cadastro realizado com sucesso!"),
          backgroundColor: Color(0xFF1B3D2F),
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.pop(context);
    } else if (resultado == "email_ja_cadastrado") {
      _exibirErro("Este e-mail já está em uso.");
    } else if (resultado == "email_invalido") {
      _exibirErro("E-mail inválido.");
    } else if (resultado == "senha_fraca") {
      _exibirErro("A senha deve conter pelo menos 6 caracteres.");
    } else {
      _exibirErro("Não foi possível realizar o cadastro.");
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
        title: const Text("Novo Cadastro"),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const Icon(
                Icons.person_add_alt_1_outlined,
                size: 80,
                color: Color(0xFF1B3D2F),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: "Nome do usuário",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "E-mail",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _telefoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Número de telefone",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _senhaController,
                obscureText: _isObscured,
                decoration: InputDecoration(
                  labelText: "Senha",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscured ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => _isObscured = !_isObscured),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _confirmarSenhaController,
                obscureText: _isObscured,
                decoration: const InputDecoration(
                  labelText: "Confirmação de senha",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _processarCadastro,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B3D2F),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    "Cadastrar",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }
}