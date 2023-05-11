import 'package:f290_dsm_pdm2_objectbox_database_ct/model/entities/nota_entity.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Categoria {
  @Id()
  int id = 0;

  String descricao = '';

  final nota = ToOne<Nota>();

  Categoria({
    required this.descricao,
  });
}
