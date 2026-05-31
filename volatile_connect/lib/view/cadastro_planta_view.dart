import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../controller/volatile_controller.dart';
import '../model/planta.dart';

class CadastroPlantaView extends StatefulWidget {
  const CadastroPlantaView({super.key});

  @override
  State<CadastroPlantaView> createState() => _CadastroPlantaViewState();
}

class _CadastroPlantaViewState extends State<CadastroPlantaView> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cientificoController = TextEditingController();
  final _categoriaController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _compostosController = TextEditingController();
  final _insetosController = TextEditingController();

  void _salvar() async {
    if (_formKey.currentState!.validate()) {
      final novaPlanta = Planta(
        nome: _nomeController.text.trim(),
        nomeCientifico: _cientificoController.text.trim(),
        categoria: _categoriaController.text.trim(),
        imagem: '',
        descricao: _descricaoController.text.trim(),
        compostos: _compostosController.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
        insetos: _insetosController.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
      );

      final sucesso = await GetIt.I<VolatileController>().adicionarPlanta(
        context,
        novaPlanta,
      );

      if (sucesso) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Registro"),
        backgroundColor: const Color(0xFF1B3D2F),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: "Nome Comum",
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? "Obrigatório" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _cientificoController,
                decoration: const InputDecoration(
                  labelText: "Nome Científico",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _categoriaController,
                decoration: const InputDecoration(
                  labelText: "Categoria",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _descricaoController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Descrição",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _compostosController,
                decoration: const InputDecoration(
                  labelText: "Compostos (sep. por vírgula)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _insetosController,
                decoration: const InputDecoration(
                  labelText: "Insetos (sep. por vírgula)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _salvar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B3D2F),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("SALVAR PLANTA"),
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
    _cientificoController.dispose();
    _categoriaController.dispose();
    _descricaoController.dispose();
    _compostosController.dispose();
    _insetosController.dispose();
    super.dispose();
  }
}