// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:f290_dsm_pdm2_objectbox_database_ct/model/entities/nota_entity.dart';
import 'package:f290_dsm_pdm2_objectbox_database_ct/repository/note_repository.dart';

class NotaFormWidget extends StatelessWidget {
  const NotaFormWidget({
    Key? key,
    this.nota,
  }) : super(key: key);

  final Nota? nota;

  @override
  Widget build(BuildContext context) {
    final tituloController = TextEditingController();
    final descricaoController = TextEditingController();
    tituloController.text = nota == null ? '' : nota!.titulo;
    descricaoController.text = nota == null ? '' : nota!.descricao;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro Nota'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: tituloController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Título',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              maxLines: 3,
              minLines: 1,
              controller: descricaoController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Descrição',
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          var repository = context.read<NoteRepository>();
          if (nota == null) {
            final novaNota = Nota(
              titulo: tituloController.text,
              descricao: descricaoController.text,
            );

            repository.salvar(novaNota);
          } else {
            nota?.titulo = tituloController.text;
            nota?.descricao = descricaoController.text;
            repository.salvar(nota!);
          }

          Navigator.pop(context);
        },
        label: const Text('SALVAR'),
      ),
    );
  }
}
