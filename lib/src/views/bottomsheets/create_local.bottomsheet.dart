import "package:ctcl_manager/base/DAOs/local.dao.dart";
import "package:ctcl_manager/base/uicolors.dart";
import "package:flutter/material.dart";

class CreateLocalBottomSheet extends StatelessWidget {
  final Function(String) onCreateLocal;

  const CreateLocalBottomSheet({required this.onCreateLocal, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.cancel_outlined, size: 32),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Criar Local",
                  style:
                      Theme.of(context).appBarTheme.titleTextStyle ??
                      TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: UIColors.primaryBlack,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 36),
            ],
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: "Nome do local (*)",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          SizedBox(height: 64),
          Container(
            width: double.infinity,
            decoration: ShapeDecoration(
              color: UIColors.primaryOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: TextButton(
              onPressed: () {
                onCreateLocal("local");
                LocalDAO().addLocal("nome do local 3");
                Navigator.pop(context);
              },
              child: Text(
                "Criar Local",
                style: TextStyle(fontSize: 16, color: UIColors.primaryBlack),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
