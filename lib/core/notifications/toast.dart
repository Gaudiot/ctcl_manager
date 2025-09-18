import "package:ctcl_manager/base/uicolors.dart";
import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";

final class ToastNotifications {
  final BuildContext context;
  final FToast fToast;

  ToastNotifications({required this.context}) : fToast = FToast() {
    fToast.init(context);
  }

  void showError({required String title, String? description}) {
    fToast
      ..removeCustomToast()
      ..showToast(
        toastDuration: Duration(seconds: 5),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: UIColors.primaryRedLightest,
            border: Border.all(color: UIColors.primaryRed, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.error, color: UIColors.primaryRed),
              SizedBox(width: 8),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 24)),
                    if (description != null)
                      Text(description, style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}
