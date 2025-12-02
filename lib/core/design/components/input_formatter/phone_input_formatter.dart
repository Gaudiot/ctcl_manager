part of "input_formatter.dart";

class _PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final maxSubstringLength = min(newValue.text.length, 15);
    final numbers = newValue.text
        .substring(0, maxSubstringLength)
        .replaceAll(RegExp("[^0-9]"), "")
        .split("");

    const mask = "(##) #####-####";
    final maskList = mask.split("");
    var newText = "";
    for (var i = 0; i < maskList.length && numbers.isNotEmpty; i++) {
      final char = maskList[i];
      if (char == "#") {
        newText += numbers.removeAt(0);
      } else {
        newText += char;
      }
    }
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
