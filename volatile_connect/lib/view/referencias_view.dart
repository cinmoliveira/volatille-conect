import 'package:flutter/material.dart';

class ReferenciasView extends StatelessWidget {
  const ReferenciasView({super.key});

  void _confirmarSaida(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar saída'),
          content: const Text('Deseja realmente sair para a tela de login?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> fontes = [
      {
        'titulo':
            'The evolutionary context for interactions between herbivore-induced plant volatiles and arthropods.',
        'detalhes':
            'Dicke, M., & Baldwin, I. T. (2010). Ecology Letters.',
      },
      {
        'titulo': 'Plant Volatiles as a Defense against Insect Herbivores.',
        'detalhes':
            'Paré, P. W., & Tumlinson, J. H. (1999). Plant Physiology.',
      },
      {
        'titulo':
            'Tritrophic Interactions Mediated by Herbivore-Induced Plant Volatiles.',
        'detalhes':
            'Turlings, T. C., & Erb, M. (2018). Annual Review of Entomology.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Referências'),
        backgroundColor: const Color(0xFF1B3D2F),
        foregroundColor: Colors.white,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Voltar',
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: () => _confirmarSaida(context),
          ),
        ],
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: fontes.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.bookmark, color: Color(0xFF1B3D2F)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText(
                          fontes[index]['titulo']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SelectableText(
                          fontes[index]['detalhes']!,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              'home',
              (route) => false,
            );
          },
          icon: const Icon(Icons.home),
          label: const Text('Home'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1B3D2F),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }
}