import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/app/providers/provider.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Expanded(
      child: TextField(
        controller: _controller, // Asignamos el controlador
        decoration: InputDecoration(
          hintText: 'Buscar...',
          hintStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.white12,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 10,
          ),
          suffixIcon: const Icon(
            Icons.search,
            color: Colors.blueGrey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(color: Colors.white),
        // Escuchamos lo que el usuario escribe
        onChanged: (query) {
          // Filtramos productos en función de lo que escribe el usuario
          Provider.of<ProductProvider>(context, listen: false)
              .filterProducts(query);
        },
      ),
    );
  }
}
