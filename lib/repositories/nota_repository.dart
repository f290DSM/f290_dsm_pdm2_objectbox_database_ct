// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';

import 'package:f290_dsm_pdm2_objectbox_database_ct/model/entities/nota_entity.dart';
import 'package:flutter/material.dart';

import 'package:f290_dsm_pdm2_objectbox_database_ct/model/db/objectbox_database.dart';

import '../objectbox.g.dart';

class NotaRepository extends ChangeNotifier {
  late final ObjectBoxDatabase _objectBoxDatabase;

  NotaRepository(this._objectBoxDatabase);

  List<Nota> _notas = [];

  List<Nota> get notas => UnmodifiableListView(_notas);

  Future<Box> getBox() async {
    final store = await _objectBoxDatabase.getStore();
    return store.box<Nota>();
  }

  salvar(Nota pNota) async {
    final boxNota = await getBox();
    boxNota.put(pNota);
    _notas.add(pNota);
    notifyListeners();
  }

  obterNotas() async {
    final boxNota = await getBox();
    _notas = boxNota.getAll() as List<Nota>;
    notifyListeners();
  }
}
