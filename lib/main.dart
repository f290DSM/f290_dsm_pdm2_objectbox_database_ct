import 'package:f290_dsm_pdm2_objectbox_database_ct/model/db/objectbox_database.dart';
import 'package:f290_dsm_pdm2_objectbox_database_ct/model/entities/nota_entity.dart';
import 'package:f290_dsm_pdm2_objectbox_database_ct/repositories/nota_repository.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'objectbox.g.dart';

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
          primarySwatch: Colors.orange,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final faker = Faker();
  List<Nota> notas = [];

  @override
  void initState() {
    super.initState();
    context.read<NotaRepository>().obterNotas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Consumer<NotaRepository>(
        builder: (context, repo, child) {
          notas = repo.notas;
          return ListView.separated(
            itemBuilder: (context, index) => ListTile(
              leading: CircleAvatar(child: Text('${notas[index].id}')),
              title: Text(notas[index].titulo),
              subtitle: Text(notas[index].descricao),
            ),
            separatorBuilder: (context, index) => const Divider(indent: 2),
            itemCount: notas.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            final nota = Nota(
              titulo: faker.conference.name(),
              descricao: faker.lorem.sentence(),
            );

            Provider.of<NotaRepository>(context, listen: false).salvar(nota);
            print(notas);
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
