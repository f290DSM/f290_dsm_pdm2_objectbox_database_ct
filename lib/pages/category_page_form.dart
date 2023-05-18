import 'package:f290_dsm_pdm2_objectbox_database_ct/model/entities/categoria_entity.dart';
import 'package:f290_dsm_pdm2_objectbox_database_ct/repositories/categoria_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'shared/text_input_widget.dart';

class CategoryPageForm extends StatelessWidget {
  const CategoryPageForm({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriaController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Categoria'),
      ),
      body: InputTexto(
          controller: categoriaController,
          campo: 'Categoria',
          icon: Icons.category_outlined),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final categoria = Categoria(descricao: categoriaController.text);
          Provider.of<CategoriaRepository>(context, listen: false)
              .salvar(categoria);
          Navigator.pop(context);
        },
        label: const Text('Salvar'),
        icon: const Icon(
          Icons.save_alt,
        ),
      ),
    );
  }
}
