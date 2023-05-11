import 'package:f290_dsm_pdm2_objectbox_database_ct/model/db/objectbox_database.dart';
import 'package:f290_dsm_pdm2_objectbox_database_ct/model/entities/nota_entity.dart';
import 'package:f290_dsm_pdm2_objectbox_database_ct/pages/nota_page_form.dart';
import 'package:f290_dsm_pdm2_objectbox_database_ct/repositories/nota_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'objectbox.g.dart';

late final Store store;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final objectBox = await ObjectBoxDatabase();
  store = await objectBox.getStore();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NotaRepository>(
          create: (context) => NotaRepository(store),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.amber,
          brightness: Brightness.light,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    context.read<NotaRepository>().obterNotas();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Consumer<NotaRepository>(
        builder: (context, repo, child) {
          List<Nota> notas = repo.notas;
          return ListView.builder(
            itemBuilder: (context, index) {
              final nota = notas[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(child: Text('${nota.id}')),
                  title: Text(nota.titulo),
                  subtitle: Text(nota.descricao),
                ),
              );
            },
            itemCount: notas.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotaPageForm(),
              ));

          //TODO: Ao clicar no FAB, abrir uma tela de cadastro
          // Na tela de cadastro utilizar o Provider e salvar
          // Após salvar, retornar para a tela principal
          // Ao selcionar um item da lista, abrir o formulario
          // preenchido com os dados selecionados.
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
