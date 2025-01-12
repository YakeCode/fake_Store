import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/app/providers/provider.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({super.key});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _removeFocus() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Focus(
        onFocusChange: (hasFocus) {
          if (!hasFocus) {
            _removeFocus();
          }
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_focusNode),
          behavior: HitTestBehavior.translucent,
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: 'Search...',
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
            onChanged: (query) {
              Provider.of<ProductProvider>(context, listen: false)
                  .filterProducts(query);
            },
            onTapOutside: (event) {
              _removeFocus();
            },
          ),
        ),
      ),
    );
  }
}
