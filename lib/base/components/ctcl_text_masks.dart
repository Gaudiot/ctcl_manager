import "package:mask_text_input_formatter/mask_text_input_formatter.dart";

final class CtclTextMasks {
  const CtclTextMasks._();

  static MaskTextInputFormatter get phoneMask {
    return MaskTextInputFormatter(
      mask: "(##) #####-####",
      filter: {
        "#": RegExp("[0-9]"),
      },
    );
  }

  static MaskTextInputFormatter get dateMask {
    return MaskTextInputFormatter(
      mask: "##/##/####",
      filter: {
        "#": RegExp("[0-9]"),
      },
    );
  }
}
