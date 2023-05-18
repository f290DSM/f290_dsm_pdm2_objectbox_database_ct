// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:f290_dsm_pdm2_objectbox_database_ct/model/entities/categoria_entity.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Nota {
  @Id()
  int id = 0;
  String titulo;
  String descricao;

  final categoria = ToOne<Categoria>();

  Nota({
    required this.titulo,
    required this.descricao,
  });

  @override
  String toString() =>
      'Nota(id: $id, titulo: $titulo, descricao: $descricao,  categoria: $categoria)';
}

//flutter pub run build_runner build
