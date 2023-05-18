import 'package:flutter/material.dart';

class InputTexto extends StatelessWidget {
  const InputTexto(
      {super.key,
      required this.campo,
      required this.icon,
      this.limite = 50,
      this.multiLinhas,
      this.textoAjuda = '',
      required this.controller});

  final String campo;
  final IconData icon;
  final int? limite;
  final int? multiLinhas;
  final String textoAjuda;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: TextFormField(
        controller: controller,
        maxLines: multiLinhas,
        autovalidateMode: AutovalidateMode.always,
        decoration: InputDecoration(
          labelText: campo,
          prefixIcon: Icon(icon),
          helperText: textoAjuda,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$campo é obrigatório(a).';
          } else if (value.length > limite!) {
            return '$campo excede o tamanho máximo de $limite caracteres.';
          } else {
            return null;
          }
        },
      ),
    );
  }
}
