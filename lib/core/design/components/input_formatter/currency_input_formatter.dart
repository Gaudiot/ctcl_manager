part of "input_formatter.dart";

class _CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var numbers = newValue.text.replaceAll(RegExp("[^0-9]"), "");

    if (numbers.isEmpty) {
      numbers = "0";
    }

    final value = double.parse(numbers) / 100.0;

    final formatter = NumberFormat.currency(locale: "pt_BR", symbol: "R\$");
    final newText = formatter.format(value);

    // Atualiza a seleção para o final do texto
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
