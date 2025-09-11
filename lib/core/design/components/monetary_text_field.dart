import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:intl/intl.dart";

final class MonetaryValueObserver {
  int _valueInHundred = 0;

  set valueInHundred(String value) {
    _valueInHundred = int.parse(value.replaceAll(RegExp("[^0-9]"), ""));
  }

  /// Returns the value in hundred (e.g R$ 1.378,09 -> 137809)
  int get value => _valueInHundred;
}

final class MonetaryTextField extends StatelessWidget {
  final MonetaryValueObserver? valueObserver;

  const MonetaryTextField({super.key, this.valueObserver});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "R\$ 0,00",
        labelText: "Valor",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.numberWithOptions(),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CurrencyInputFormatter(),
      ],
      onChanged: (value) {
        valueObserver?.valueInHundred = value;
      },
    );
  }
}

final class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    final value = double.parse(newValue.text);

    final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

    final newText = formatter.format(value / 100);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
