import 'package:flutter/material.dart';
import '../model/planta.dart';

class DetalhesView extends StatelessWidget {
  const DetalhesView({super.key});

  @override
  Widget build(BuildContext context) {
    //pegar os argumentos de forma segura
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args == null || args is! Planta) {
      return Scaffold(
        appBar: AppBar(backgroundColor: const Color(0xFF1B3D2F)),
        body: const Center(
          child: Text("Erro: Dados da planta não encontrados ou inválidos."),
        ),
      );
    }

    final Planta planta = args;

    return Scaffold(
      appBar: AppBar(
        title: Text(planta.nome),
        backgroundColor: const Color(0xFF1B3D2F),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // tratar a imagem para não falhar no layout
            Image.asset(
              planta.imagem, 
              width: double.infinity, 
              height: 250, 
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 250,
                  color: Colors.grey[300],
                  child: const Icon(Icons.eco, size: 80, color: Color(0xFF1B3D2F)),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    planta.nomeCientifico, 
                    style: const TextStyle(
                      fontSize: 22, 
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B3D2F)
                    )
                  ),
                  const SizedBox(height: 10),
                  Text(
                    planta.descricao,
                    style: const TextStyle(fontSize: 16, height: 1.4),
                  ),
                  const Divider(height: 30),
                  const Text(
                    'Compostos Orgânicos Voláteis:', 
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                  ),
                  Text(planta.compostos.join(', '), style: const TextStyle(fontSize: 15)),
                  const SizedBox(height: 15),
                  const Text(
                    'Insetos Relacionados:', 
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                  ),
                  Text(planta.insetos.join(', '), style: const TextStyle(fontSize: 15)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}