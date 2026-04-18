import 'package:flutter/material.dart';

class SobreView extends StatelessWidget {
  const SobreView({super.key});

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sobre o Projeto',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1B3D2F),
        iconTheme: const IconThemeData(color: Colors.white),

        // 🔥 BOTÃO VOLTAR EM PT-BR
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

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              const Icon(Icons.info_outline,
                  size: 80, color: Color(0xFF1B3D2F)),
              const SizedBox(height: 30),

              const Text(
                'Cintia Oliveira',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Discente da Fatec Ribeirão Preto',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 15),
              const Text(
                'Disciplina: Programação de Dispositivos Móveis',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const Text('Docente: Rodrigo Plotze'),

              const Divider(height: 50),

              const Text(
                'Objetivo do Projeto',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Desenvolver um aplicativo com a linguagem Dart e o framework Flutter, utilizando como base todos os conhecimentos aplicados durante a disciplina.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              const Text(
                'Sobre o Projeto',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Projeto de Ecologia Química sobre plantas e os compostos voláteis emitidos pelas mesmas, que atraem diferentes tipos de insetos.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              const Center(
                child: Text(
                  "Versão 1.0",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 70),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.menu_book,
                      color: Color(0xFF1B3D2F),
                      size: 35,
                    ),
                    onPressed: () =>
                        Navigator.pushNamed(context, 'referencias'),
                    tooltip: 'Referências',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}