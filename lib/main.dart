import 'package:f290_dsm_pdm2_objectbox_database_ct/model/db/objectbox_database.dart';
import 'package:f290_dsm_pdm2_objectbox_database_ct/model/entities/nota_entity.dart';
import 'package:f290_dsm_pdm2_objectbox_database_ct/repositories/nota_repository.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ObjectBoxDatabase>(
          create: (context) => ObjectBoxDatabase(),
        ),
        ChangeNotifierProvider<NotaRepository>(
          create: (context) => NotaRepository(context.read()),
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
          final nota = Nota(
            titulo: faker.conference.name(),
            descricao: faker.lorem.sentence(),
          );

          showModalBottomSheet(
            context: context,
            builder: (context) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height * .3,
                  child: Column(
                    children: [
                      TextField(),
                      TextField(),
                      ButtonBar(
                        children: [
                          FilledButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('SALVAR'),
                          ),
                        ],
                      ),
                    ],
                  ));
            },
          );

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
