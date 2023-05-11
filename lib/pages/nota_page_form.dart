import 'package:flutter/material.dart';

class NotaPageForm extends StatelessWidget {
  const NotaPageForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro Nota')),
      body: Column(
        children: [
          TextField(),
          TextField(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Salvar'),
        icon: const Icon(Icons.save_alt_outlined),
      ),
    );
  }
}
