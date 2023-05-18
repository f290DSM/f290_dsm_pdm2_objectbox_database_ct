import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repositories/categoria_repository.dart';
import 'category_page_form.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CategoriaRepository>().getAll();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
      ),
      body: Consumer<CategoriaRepository>(
        builder: (context, repo, child) {
          return ListView.builder(
            itemCount: repo.categorias.length,
            itemBuilder: (context, index) {
              final categoria = repo.categorias[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text('${categoria.id}'),
                ),
                title: Text(categoria.descricao),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CategoryPageForm(),
              ));
        },
        label: const Text('Criar'),
        icon: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
