import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../controller/volatile_controller.dart';
import '../model/planta.dart';

class EditarPlantaView extends StatefulWidget {
  const EditarPlantaView({super.key});

  @override
  State<EditarPlantaView> createState() => _EditarPlantaViewState();
}

class _EditarPlantaViewState extends State<EditarPlantaView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeController;
  late TextEditingController _cientificoController;
  late TextEditingController _categoriaController;
  late TextEditingController _descricaoController;
  late TextEditingController _compostosController;
  late TextEditingController _insetosController;

  bool _carregado = false;
  String _id = '';
  Planta? _plantaAtual;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_carregado) {
      final args = ModalRoute.of(context)!.settings.arguments;

      if (args is Map<String, dynamic>) {
        _id = args['id'];
        _plantaAtual = args['planta'];
      }

      final planta = _plantaAtual;

      _nomeController = TextEditingController(text: planta?.nome ?? '');
      _cientificoController =
          TextEditingController(text: planta?.nomeCientifico ?? '');
      _categoriaController = TextEditingController(text: planta?.categoria ?? '');
      _descricaoController = TextEditingController(text: planta?.descricao ?? '');
      _compostosController =
          TextEditingController(text: planta?.compostos.join(', ') ?? '');
      _insetosController =
          TextEditingController(text: planta?.insetos.join(', ') ?? '');

      _carregado = true;
    }
  }

  void _atualizar() async {
    if (_formKey.currentState!.validate()) {
      if (_id.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro: documento não encontrado.'),
            backgroundColor: Color(0xFFD32F2F),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      final plantaEditada = Planta(
        uid: _plantaAtual?.uid ?? '',
        nome: _nomeController.text.trim(),
        nomeCientifico: _cientificoController.text.trim(),
        categoria: _categoriaController.text.trim(),
        imagem: _plantaAtual?.imagem ?? '',
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

      final sucesso = await GetIt.I<VolatileController>().editarPlanta(
        context,
        _id,
        plantaEditada,
      );

      if (sucesso) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_carregado) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Planta"),
        backgroundColor: const Color(0xFF1B3D2F),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: "Nome",
                  border: OutlineInputBorder(),
                ),
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
                  onPressed: _atualizar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B3D2F),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("SALVAR ALTERAÇÕES"),
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