import 'package:f290_dsm_pdm2_objectbox_database_ct/model/entities/categoria_entity.dart';
import 'package:f290_dsm_pdm2_objectbox_database_ct/model/entities/nota_entity.dart';
import 'package:f290_dsm_pdm2_objectbox_database_ct/repositories/categoria_repository.dart';
import 'package:f290_dsm_pdm2_objectbox_database_ct/repositories/nota_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'shared/text_input_widget.dart';

class NotaPageForm extends StatelessWidget {
  const NotaPageForm({super.key});

  @override
  Widget build(BuildContext context) {
    final tituloController = TextEditingController();
    final descricaoController = TextEditingController();

    Provider.of<CategoriaRepository>(context, listen: false).getAll();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Nota'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InputTexto(
              controller: tituloController,
              campo: 'Título',
              icon: Icons.text_fields),
          InputTexto(
            controller: descricaoController,
            campo: 'Descrição',
            icon: Icons.text_fields,
            multiLinhas: 2,
            limite: 500,
          ),
          Consumer<CategoriaRepository>(
            builder: (context, repo, child) {
              return Wrap(
                  spacing: 8,
                  children: repo.categorias
                      .map(
                        (categoria) => ChoiceChip(
                          label: Text(categoria.descricao),
                          selected: repo.categoria == categoria,
                          onSelected: (value) =>
                              repo.categoria = value ? categoria : null,
                        ),
                      )
                      .toList());
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          var nota = Nota(
            titulo: tituloController.text,
            descricao: descricaoController.text,
          );

          Categoria? categoria =
              Provider.of<CategoriaRepository>(context, listen: false)
                  .categoria;

          // nota.categorias.add(categoria!);
          nota.categoria.target = categoria;

          Provider.of<NotaRepository>(context, listen: false).salvar(nota);

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
