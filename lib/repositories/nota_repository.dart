// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';

import 'package:f290_dsm_pdm2_objectbox_database_ct/model/entities/nota_entity.dart';
import 'package:flutter/material.dart';

import '../objectbox.g.dart';

class NotaRepository extends ChangeNotifier {
  late final Store _store;

  NotaRepository(this._store);

  List<Nota> _notas = [];

  List<Nota> get notas => UnmodifiableListView(_notas);

  Future<Box<Nota>> getBox() async {
    return _store.box<Nota>();
  }

  salvar(Nota pNota) async {
    final box = await getBox();
    box.put(pNota);
    _notas.add(pNota);
    notifyListeners();
  }

  obterNotas() async {
    final boxNota = await getBox();
    _notas = boxNota.query().order(Nota_.descricao).build().find();
    notifyListeners();
  }
}
