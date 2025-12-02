import "package:ctcl_manager/base/components/ctcl_textfield.component.dart";
import "package:ctcl_manager/base/uicolors.dart";
import "package:ctcl_manager/core/design/components/input_formatter/input_formatter.dart";
import "package:ctcl_manager/l10n/localizations_extension.dart";
import "package:ctcl_manager/src/viewmodels/create_student.viewmodel.dart";
import "package:flutter/material.dart";

class CreateStudentView extends StatelessWidget {
  final CreateStudentViewModel viewModel;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();

  CreateStudentView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.strings.create_student,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        backgroundColor: UIColors.primaryOrangeLighter,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    UIColors.primaryOrangeLighter,
                    UIColors.primaryYellowLighter,
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  CtclTextField.required(
                    controller: firstNameController,
                    labelText: "First Name",
                    hintText: "John",
                    validator: (value) {
                      final nameRegex = RegExp(r"^[\p{L}]+$", unicode: true);
                      return nameRegex.hasMatch(value)
                          ? null
                          : context.strings.invalid_name;
                    },
                  ),
                  SizedBox(height: 16),
                  CtclTextField.required(
                    controller: lastNameController,
                    labelText: "Last Name",
                    hintText: "Doe",
                    validator: (value) {
                      final nameRegex = RegExp(r"^[\p{L}]+$", unicode: true);
                      return nameRegex.hasMatch(value)
                          ? null
                          : context.strings.invalid_name;
                    },
                  ),
                  SizedBox(height: 16),
                  CtclTextField.required(
                    controller: phoneController,
                    labelText: "Phone number",
                    hintText: "(81) 98765-4321",
                    inputFormatter: InputFormatter.phone,
                    validator: (value) {
                      if (value.isEmpty || value.length < 11) {
                        return null;
                      }

                      final phoneRegex = RegExp(r"^\d{11}$");
                      return phoneRegex.hasMatch(value)
                          ? null
                          : "Invalid phone number";
                    },
                  ),
                  SizedBox(height: 16),
                  CtclTextField.optional(
                    controller: emailAddressController,
                    labelText: "Email address",
                    hintText: "email@example.com",
                    validator: (value) {
                      final emailRegex = RegExp(
                        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                      );
                      return emailRegex.hasMatch(value)
                          ? null
                          : context.strings.invalid_email;
                    },
                  ),
                  SizedBox(height: 16),
                  CtclTextField.optional(
                    controller: birthdayController,
                    labelText: "Birthday",
                    hintText: "13/01/1999",
                    inputFormatter: InputFormatter.date,
                    validator: (value) {
                      if (value.isEmpty || value.length < 8) {
                        return null;
                      }

                      final day = value.substring(0, 2);
                      final month = value.substring(2, 4);
                      final year = value.substring(4, 8);

                      if (int.tryParse(day) == null ||
                          int.tryParse(month) == null ||
                          int.tryParse(year) == null) {
                        return context.strings.invalid_date;
                      }

                      if (int.parse(day) > 31 ||
                          int.parse(month) > 12 ||
                          int.parse(year) > DateTime.now().year) {
                        return context.strings.invalid_date;
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  CtclTextField.optional(
                    controller: instagramController,
                    labelText: "Instagram",
                    validator: (value) {
                      if (value.isEmpty) {
                        return null;
                      }

                      final instagramRegex = RegExp(
                        r"^(?!.*\.\.)(?!.*\.$)[^\W][\w.]{0,29}$",
                      );
                      return instagramRegex.hasMatch(value)
                          ? null
                          : context.strings.invalid_instagram;
                    },
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: 300,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: UIColors.primaryOrange,
                        foregroundColor: UIColors.primaryWhite,
                        shape: StadiumBorder(),
                      ),
                      onPressed: () {
                        viewModel.createStudent(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          phone: phoneController.text,
                          emailAddress: emailAddressController.text,
                          birthday: birthdayController.text,
                          instagram: instagramController.text,
                        );
                      },
                      child: Text(context.strings.create_student),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
