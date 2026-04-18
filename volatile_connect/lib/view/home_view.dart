import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../controller/volatile_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = GetIt.I<VolatileController>();
  bool _isListView = true;

  void _confirmarExclusao(int index, String nome) {
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
              onPressed: () {
                controller.removerPlanta(index);
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$nome removido com sucesso!'),
                    backgroundColor: const Color(0xFF1B3D2F),
                  ),
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

  Widget _buildActions(int index, String nome) {
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
            arguments: index,
          ),
        ),
        IconButton(
          constraints: const BoxConstraints(),
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.delete, color: Colors.red, size: 20),
          onPressed: () => _confirmarExclusao(index, nome),
        ),
      ],
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: controller.plantas.length,
      itemBuilder: (context, index) {
        final planta = controller.plantas[index];
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
            trailing: _buildActions(index, planta.nome),
          ),
        );
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemCount: controller.plantas.length,
      itemBuilder: (context, index) {
        final planta = controller.plantas[index];
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
                      _buildActions(index, planta.nome),
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

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'VolatileConnect',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color(0xFF1B3D2F),
            iconTheme: const IconThemeData(color: Colors.white),
            leading: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  'login',
                  (route) => false,
                );
              },
            ),
            actions: [
              IconButton(
                icon: Icon(_isListView ? Icons.grid_view : Icons.view_list),
                onPressed: () {
                  setState(() {
                    _isListView = !_isListView;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: () => Navigator.pushNamed(context, 'sobre'),
              ),
            ],
          ),
          body: _isListView ? _buildListView() : _buildGridView(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFF1B3D2F),
            onPressed: () => Navigator.pushNamed(context, 'cadastro_planta'),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        );
      },
    );
  }
}