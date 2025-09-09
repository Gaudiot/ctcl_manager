import "dart:async";

import "package:ctcl_manager/base/uicolors.dart";
import "package:flutter/material.dart";

final class DebounceTextField extends StatefulWidget {
  final int debouceTimeInMilliseconds;
  final ValueChanged<String> onDebounce;

  const DebounceTextField({
    required this.debouceTimeInMilliseconds,
    required this.onDebounce,
    super.key,
  });

  @override
  State<DebounceTextField> createState() => _DebounceTextFieldState();
}

class _DebounceTextFieldState extends State<DebounceTextField> {
  Timer? _debounceTimer;

  void _onDebounce(String value) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    _debounceTimer = Timer(
      Duration(milliseconds: widget.debouceTimeInMilliseconds),
      () => widget.onDebounce(value),
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: _onDebounce,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        labelText: "Pesquisar",
        fillColor: UIColors.primaryWhite,
        filled: true,
      ),
    );
  }
}
