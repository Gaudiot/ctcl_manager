import "package:ctcl_manager/base/uicolors.dart";
import "package:flutter/material.dart";

final class UIDropdownItem {
  final String id;
  final String title;

  UIDropdownItem({required this.id, required this.title});
}

final class UIDropdown extends StatefulWidget {
  final List<UIDropdownItem> items;
  final String? placeholderText;
  final String errorMessage;
  final ValueChanged<String?>? onChanged;

  const UIDropdown({
    required this.items,
    super.key,
    this.onChanged,
    this.errorMessage = "",
    this.placeholderText,
  });

  @override
  State<UIDropdown> createState() => _UIDropdownState();
}

class _UIDropdownState extends State<UIDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: widget.errorMessage.isNotEmpty
                  ? UIColors.primaryRed
                  : UIColors.primaryGreyDarker,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: "",
              hint: widget.placeholderText != null
                  ? Text(widget.placeholderText!)
                  : null,
              items: widget.items
                  .map(
                    (item) => DropdownMenuItem(
                      value: item.id,
                      child: Text(item.title),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                widget.onChanged?.call(value);
                setState(() {});
              },
            ),
          ),
        ),
        if (widget.errorMessage.isNotEmpty)
          Text(widget.errorMessage, style: TextStyle(color: Colors.red)),
      ],
    );
  }
}
