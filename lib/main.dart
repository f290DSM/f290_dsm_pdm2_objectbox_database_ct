import 'package:f290_dsm_pdm2_objectbox_database_ct/model/db/objectbox_database.dart';
import 'package:f290_dsm_pdm2_objectbox_database_ct/model/entities/nota_entity.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'objectbox.g.dart';

late final Store store;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = ObjectBoxDatabase();
  store = await database.getStore();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
    notas = store.box<Nota>().getAll();
    print(notas);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.separated(
            itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(child: Text('${notas[index].id}')),
                  title: Text(notas[index].titulo),
                  subtitle: Text(notas[index].descricao),
                ),
            separatorBuilder: (context, index) => const Divider(indent: 2),
            itemCount: notas.length),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            final nota = Nota(
              titulo: faker.conference.name(),
              descricao: faker.lorem.sentence(),
            );

            store.box<Nota>().put(nota);
            notas = store.box<Nota>().getAll();
            print(notas);
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
