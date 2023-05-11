import 'dart:collection';
import 'package:flutter/material.dart';

import '../model/entities/categoria_entity.dart';
import '../objectbox.g.dart';

class CategoriaRepository extends ChangeNotifier {
  final Store _store;
  List<Categoria> _categorias = [];
  Categoria? _categoria;

  List<Categoria> get categorias => UnmodifiableListView(_categorias);

  CategoriaRepository(this._store) {
    // _objectBox.box<Categoria>().removeAll();
  }

  Future<Box<Categoria>> getBox() async {
    return _store.box<Categoria>();
  }

  salvar(Categoria pCategoria) async {
    final box = await getBox();
    box.put(pCategoria);
    getAll();
  }

  getAll() async {
    final box = await getBox();
    _categorias = box.query().order(Categoria_.descricao).build().find();
    notifyListeners();
  }

  set categoria(Categoria? value) {
    _categoria = value;
    notifyListeners();
  }

  Categoria? get categoria => _categoria;
}
