import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../controller/auth_controller.dart';
import '../controller/volatile_controller.dart';
import '../model/planta.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = GetIt.I<VolatileController>();
  bool _isListView = true;

  void _confirmarExclusao(String id, String nome) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar exclusão'),
          content: Text('Deseja realmente remover "$nome" do catálogo?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);

                await controller.removerPlanta(
                  context,
                  id,
                  nome,
                );
              },
              child: const Text(
                'Excluir',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _confirmarLogout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar saída'),
          content: const Text('Deseja realmente sair da aplicação?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);

                await GetIt.I<AuthController>().logout();

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  'login',
                  (route) => false,
                );
              },
              child: const Text(
                'Sair',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildActions(String id, String nome, Planta planta) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          constraints: const BoxConstraints(),
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
          onPressed: () => Navigator.pushNamed(
            context,
            'editar_planta',
            arguments: {
              'id': id,
              'planta': planta,
            },
          ),
        ),
        IconButton(
          constraints: const BoxConstraints(),
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.delete, color: Colors.red, size: 20),
          onPressed: () => _confirmarExclusao(id, nome),
        ),
      ],
    );
  }

  Widget _buildUsuarioLogado() {
    return FutureBuilder<String>(
      future: GetIt.I<AuthController>().usuarioLogado(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final nome = snapshot.data ?? '';

          return TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 4),
            ),
            onPressed: _confirmarLogout,
            icon: const Icon(Icons.exit_to_app, size: 16),
            label: Text(
              nome,
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _buildListView(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: docs.length,
      itemBuilder: (context, index) {
        final id = docs[index].id;
        final planta = Planta.fromJson(docs[index].data());

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
                errorBuilder: (_, __, ___) => const Icon(Icons.eco),
              ),
            ),
            title: Text(
              planta.nome,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(planta.nomeCientifico),
            onTap: () => Navigator.pushNamed(
              context,
              'detalhes',
              arguments: planta,
            ),
            trailing: _buildActions(id, planta.nome, planta),
          ),
        );
      },
    );
  }

  Widget _buildGridView(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemCount: docs.length,
      itemBuilder: (context, index) {
        final id = docs[index].id;
        final planta = Planta.fromJson(docs[index].data());

        return Card(
          elevation: 3,
          child: InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              'detalhes',
              arguments: planta,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(4)),
                    child: Image.asset(
                      planta.imagem,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.image_not_supported, size: 50),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        planta.nome,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      _buildActions(id, planta.nome, planta),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: controller.listarPlantas(),
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

        final docs = snapshot.data?.docs ?? [];

        if (docs.isEmpty) {
          return const Center(
            child: Text('Nenhuma planta cadastrada.'),
          );
        }

        return _isListView ? _buildListView(docs) : _buildGridView(docs);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF1B3D2F),
            iconTheme: const IconThemeData(color: Colors.white),
            title: Row(
              children: [
                const Expanded(
                  child: Text(
                    'VolatileConnect',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                _buildUsuarioLogado(),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                tooltip: 'Pesquisar',
                onPressed: () =>
                    Navigator.pushNamed(context, 'pesquisa'),
              ),
              IconButton(
                icon: Icon(
                  _isListView ? Icons.grid_view : Icons.view_list,
                ),
                onPressed: () {
                  setState(() {
                    _isListView = !_isListView;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: () => Navigator.pushNamed(
                  context,
                  'sobre',
                ),
              ),
            ],
          ),
          body: _buildBody(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFF1B3D2F),
            onPressed: () =>
                Navigator.pushNamed(context, 'cadastro_planta'),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        );
      },
    );
  }
}