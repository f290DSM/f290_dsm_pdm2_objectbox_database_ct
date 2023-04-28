// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class Nota {
  @Id()
  int id = 0;
  String titulo;
  String descricao;

  Nota({
    required this.titulo,
    required this.descricao,
  });

  @override
  String toString() => 'Nota(id: $id, titulo: $titulo, descricao: $descricao)';
}

//flutter pub run build_runner build
