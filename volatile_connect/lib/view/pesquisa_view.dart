import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../controller/volatile_controller.dart';
import '../model/planta.dart';

class PesquisaView extends StatefulWidget {
  const PesquisaView({super.key});

  @override
  State<PesquisaView> createState() => _PesquisaViewState();
}

class _PesquisaViewState extends State<PesquisaView> {
  final _pesquisaController = TextEditingController();

  String _termoPesquisa = '';
  String _ordenacao = 'nome';

  List<Planta> _filtrarEOrdenar(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) {
    final termo = _termoPesquisa.trim().toLowerCase();

    if (termo.isEmpty) {
      return [];
    }

    final plantas = docs.map((doc) {
      return Planta.fromJson(doc.data());
    }).where((planta) {
      final nome = planta.nome.toLowerCase();
      final nomeCientifico = planta.nomeCientifico.toLowerCase();
      final categoria = planta.categoria.toLowerCase();
      final compostos = planta.compostos.join(', ').toLowerCase();
      final insetos = planta.insetos.join(', ').toLowerCase();

      return nome.contains(termo) ||
          nomeCientifico.contains(termo) ||
          categoria.contains(termo) ||
          compostos.contains(termo) ||
          insetos.contains(termo);
    }).toList();

    if (_ordenacao == 'nome') {
      plantas.sort(
        (a, b) => a.nome.toLowerCase().compareTo(b.nome.toLowerCase()),
      );
    } else if (_ordenacao == 'nomeCientifico') {
      plantas.sort(
        (a, b) => a.nomeCientifico
            .toLowerCase()
            .compareTo(b.nomeCientifico.toLowerCase()),
      );
    } else if (_ordenacao == 'categoria') {
      plantas.sort(
        (a, b) =>
            a.categoria.toLowerCase().compareTo(b.categoria.toLowerCase()),
      );
    }

    return plantas;
  }

  @override
  Widget build(BuildContext context) {
    final controller = GetIt.I<VolatileController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisar Plantas'),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _pesquisaController,
                  decoration: const InputDecoration(
                    labelText:
                        'Pesquisar por planta, categoria, composto ou inseto',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (valor) {
                    setState(() {
                      _termoPesquisa = valor;
                    });
                  },
                ),
                const SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  value: _ordenacao,
                  decoration: const InputDecoration(
                    labelText: 'Ordenar por',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.sort),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'nome',
                      child: Text('Nome comum'),
                    ),
                    DropdownMenuItem(
                      value: 'nomeCientifico',
                      child: Text('Nome científico'),
                    ),
                    DropdownMenuItem(
                      value: 'categoria',
                      child: Text('Categoria'),
                    ),
                  ],
                  onChanged: (valor) {
                    setState(() {
                      _ordenacao = valor!;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: controller.pesquisarPlantas(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Erro ao recuperar os dados.'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF1B3D2F),
                    ),
                  );
                }

                if (_termoPesquisa.trim().isEmpty) {
                  return const Center(
                    child: Text('Digite algo para pesquisar.'),
                  );
                }

                final docs = snapshot.data?.docs ?? [];
                final plantas = _filtrarEOrdenar(docs);

                if (plantas.isEmpty) {
                  return const Center(
                    child: Text('Nenhum resultado encontrado.'),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: plantas.length,
                  itemBuilder: (context, index) {
                    final planta = plantas[index];

                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            planta.imagem,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.eco,
                              color: Color(0xFF1B3D2F),
                            ),
                          ),
                        ),
                        title: Text(
                          planta.nome,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(planta.nomeCientifico),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            'detalhes',
                            arguments: planta,
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pesquisaController.dispose();
    super.dispose();
  }
}