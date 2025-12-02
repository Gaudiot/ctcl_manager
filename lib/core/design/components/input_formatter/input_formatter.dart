import "dart:math";

import "package:flutter/services.dart";
import "package:intl/intl.dart";

part "cpf_input_formatter.dart";
part "currency_input_formatter.dart";
part "date_input_formatter.dart";
part "phone_input_formatter.dart";

final class InputFormatter {
  const InputFormatter._();

  static TextInputFormatter get currency => _CurrencyInputFormatter();
  static TextInputFormatter get cpf => _CpfInputFormatter();
  static TextInputFormatter get phone => _PhoneInputFormatter();
  static TextInputFormatter get date => _DateInputFormatter();
}
