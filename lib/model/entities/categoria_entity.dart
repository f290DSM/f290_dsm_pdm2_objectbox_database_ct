// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

import 'package:f290_dsm_pdm2_objectbox_database_ct/model/entities/nota_entity.dart';

@Entity()
class Categoria {
  @Id()
  int id = 0;

  String descricao = '';

  @Backlink()
  final notas = ToMany<Nota>();

  Categoria({
    required this.descricao,
  });

  @override
  String toString() => 'Categoria(id: $id, descricao: $descricao)';
}
