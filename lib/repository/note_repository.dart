import 'dart:collection';

import 'package:f290_dsm_pdm2_objectbox_database_ct/model/db/objectbox_database.dart';
import 'package:f290_dsm_pdm2_objectbox_database_ct/model/entities/nota_entity.dart';
import 'package:flutter/material.dart';

import '../objectbox.g.dart';

class NoteRepository extends ChangeNotifier {
  final ObjectBoxDatabase _objectBox;

  NoteRepository(this._objectBox);

  List<Nota> _notas = [];

  UnmodifiableListView<Nota> get notas => UnmodifiableListView(_notas);

  Future<Box> getStore() async {
    final store = await _objectBox.getStore();
    return store.box<Nota>();
  }

  salvar(Nota nota) async {
    final box = await getStore();
    box.put(nota);
    _notas.add(nota);
    notifyListeners();
  }

  getAll() async {
    final box = await getStore();
    _notas = box.getAll() as List<Nota>;
    notifyListeners();
  }
}
