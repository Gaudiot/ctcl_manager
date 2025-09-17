import "package:ctcl_manager/l10n/localizations_extension.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:intl/intl.dart";

// MARK: - Controller

final class MonetaryValueController extends ValueNotifier<int> {
  MonetaryValueController([super.value = 0]);

  set valueInHundred(String value) {
    super.value = int.parse(value.replaceAll(RegExp("[^0-9]"), ""));
  }
}

// MARK: - Component

final class MonetaryTextField extends StatefulWidget {
  final MonetaryValueController? controller;

  const MonetaryTextField({super.key, this.controller});

  @override
  State<MonetaryTextField> createState() => _MonetaryTextFieldState();
}

class _MonetaryTextFieldState extends State<MonetaryTextField> {
  final TextEditingController _textFieldController = TextEditingController();
  bool _updatedByUser = false;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_onMonetaryValueControllerChanged);
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    widget.controller?.removeListener(_onMonetaryValueControllerChanged);
    super.dispose();
  }

  void _onMonetaryValueControllerChanged() {
    if (_updatedByUser) {
      return;
    }
    final formattedValue = CurrencyInputFormatter().formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(text: widget.controller?.value.toString() ?? ""),
    );
    _textFieldController.text = formattedValue.text;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textFieldController,
      decoration: InputDecoration(
        hintText: "R\$ 0,00",
        labelText: context.strings.value_field_title,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.numberWithOptions(),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CurrencyInputFormatter(),
      ],
      onChanged: (value) {
        _updatedByUser = true;
        widget.controller?.valueInHundred = value;
        _updatedByUser = false;
      },
    );
  }
}

// MARK: - Formatter

final class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final value = double.parse(newValue.text);

    final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

    final newText = formatter.format(value / 100);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
