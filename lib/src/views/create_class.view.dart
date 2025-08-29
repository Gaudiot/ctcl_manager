import "package:ctcl_manager/base/uicolors.dart";
import "package:ctcl_manager/src/views/bottomsheets/create_local.bottomsheet.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:intl/intl.dart";

class CreateClassView extends StatefulWidget {
  const CreateClassView({super.key});

  @override
  State<CreateClassView> createState() => _CreateClassViewState();
}

class _CreateClassViewState extends State<CreateClassView> {
  String? _localId;
  final List<DropdownMenuItem> _locals = [
    DropdownMenuItem(value: "local1", child: Text("Local 1")),
    DropdownMenuItem(value: "local2", child: Text("Local 2")),
    DropdownMenuItem(value: "create", child: Text("Novo local")),
  ];

  void _setLocalId(String? id) {
    setState(() {
      _localId = id;
    });
  }

  void _addLocal(String name) {
    setState(() {
      final newId = "${name}_${_locals.length + 1}";
      _locals.add(
        DropdownMenuItem(
          value: newId,
          child: Text("$name ${_locals.length + 1}"),
        ),
      );

      _setLocalId(newId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CreateClassViewHeader(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    labelText: "Nome da turma (*)",
                    fillColor: UIColors.primaryWhiteDarker,
                    filled: true,
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    labelText: "Descrição",
                    alignLabelWithHint: true,
                    hintText: "Descrição da turma",
                    fillColor: UIColors.primaryWhiteDarker,
                    filled: true,
                  ),
                  minLines: 3,
                  maxLines: 3,
                ),
                SizedBox(height: 16),
                ValueTextField(),
                SizedBox(height: 16),
                DropdownButtonHideUnderline(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: UIColors.primaryWhiteDarker,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownButton(
                      hint: Text(
                        "Selecione um local (*)",
                        style: TextStyle(color: UIColors.primaryGreyLight),
                      ),
                      isExpanded: true,
                      items: _locals,
                      value: _localId,
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }

                        if (value == "create") {
                          _setLocalId(null);
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => CreateLocalBottomSheet(
                              onCreateLocal: (name) {
                                _addLocal(name);
                              },
                            ),
                          );
                          return;
                        }
                        _setLocalId(value);
                      },
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
                      showModalBottomSheet(
                        backgroundColor: UIColors.primaryWhite,
                        context: context,
                        builder: (context) => CreateLocalBottomSheet(
                          onCreateLocal: (name) {
                            _addLocal(name);
                            _setLocalId(name);
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Criar Turma",
                      style: TextStyle(
                        fontSize: 16,
                        color: UIColors.primaryBlack,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    color: UIColors.primaryWhiteDarkest,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Descartar",
                      style: TextStyle(
                        fontSize: 16,
                        color: UIColors.primaryBlack,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ValueTextField extends StatefulWidget {
  const ValueTextField({super.key});

  @override
  State<ValueTextField> createState() => _ValueTextFieldState();
}

class _ValueTextFieldState extends State<ValueTextField> {
  late final TextEditingController _controller;
  final NumberFormat ptBrCurrencyFormatter = NumberFormat.currency(
    locale: "pt_BR",
    symbol: "R\$",
    decimalDigits: 2,
  );

  int valueInHundred = 0;

  @override
  void initState() {
    super.initState();
    valueInHundred = 0;
    _controller = TextEditingController(text: _formatCurrency(valueInHundred));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatCurrency(int valueInHundred) {
    final value = valueInHundred / 100.0;
    return ptBrCurrencyFormatter.format(value);
  }

  void _onChanged(String value) {
    final digitsOnly = value.replaceAll(RegExp("[^0-9]"), "");
    if (digitsOnly.isEmpty) {
      valueInHundred = 0;
      final formatted = _formatCurrency(valueInHundred);
      _controller.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
      setState(() {});
      return;
    }

    valueInHundred = int.parse(digitsOnly);
    final formatted = _formatCurrency(valueInHundred);
    _controller.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        labelText: "Valor (*)",
        fillColor: UIColors.primaryWhiteDarker,
        filled: true,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: _onChanged,
    );
  }
}

class CreateClassViewHeader extends StatelessWidget {
  const CreateClassViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            UIColors.primaryOrangeLighter,
            UIColors.primaryYellowLighter,
          ],
        ),
      ),
      child: Text(
        "Criar Turma",
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
    );
  }
}
