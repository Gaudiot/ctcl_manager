import "package:ctcl_manager/base/uicolors.dart";
import "package:ctcl_manager/l10n/localizations_extension.dart";
import "package:flutter/material.dart";
import "package:mask_text_input_formatter/mask_text_input_formatter.dart";

class CtclTextField extends StatefulWidget {
  final bool isRequired;
  final String? Function(String)? validator;
  final TextEditingController? controller;

  final String? labelText;
  final String? hintText;

  final MaskTextInputFormatter? maskFormatter;

  const CtclTextField({
    this.isRequired = false,
    this.controller,
    this.labelText,
    this.hintText,
    this.validator,
    this.maskFormatter,
    super.key,
  });

  const CtclTextField.required({
    this.controller,
    this.labelText,
    this.hintText,
    this.validator,
    this.maskFormatter,
    super.key,
  }) : isRequired = true;

  const CtclTextField.optional({
    this.controller,
    this.labelText,
    this.hintText,
    this.validator,
    this.maskFormatter,
    super.key,
  }) : isRequired = false;

  @override
  State<CtclTextField> createState() => _CtclTextFieldState();
}

class _CtclTextFieldState extends State<CtclTextField> {
  String? errorMessage;

  void validateField(String value) {
    if (value.isEmpty) {
      errorMessage = widget.isRequired ? context.strings.field_required : null;
      setState(() {});
      return;
    }

    if (widget.maskFormatter != null) {
      value = widget.maskFormatter!.getUnmaskedText();
    }
    errorMessage = widget.validator?.call(value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      inputFormatters:
          widget.maskFormatter != null ? [widget.maskFormatter!] : [],
      onChanged: validateField,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: UIColors.primaryGreyLight),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: UIColors.primaryBlack,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: UIColors.primaryRed),
        ),
        errorText: errorMessage,
      ),
    );
  }
}
