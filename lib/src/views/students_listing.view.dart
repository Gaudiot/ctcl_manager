import "package:ctcl_manager/base/uicolors.dart";
import "package:ctcl_manager/core/design/components/debounce_text_field.dart";
import "package:ctcl_manager/l10n/localizations_extension.dart";
import "package:flutter/material.dart";

class StudentsListing extends StatefulWidget {
  const StudentsListing({super.key});

  @override
  State<StudentsListing> createState() => _StudentsListingState();
}

class _StudentsListingState extends State<StudentsListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.strings.students,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        backgroundColor: UIColors.primaryOrangeLighter,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: UIColors.primaryOrangeLighter,
                  padding: const EdgeInsets.all(16),
                  child: DebounceTextField(
                    debouceTimeInMilliseconds: 300,
                    onDebounce: (_) {},
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
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
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: UIColors.primaryOrange,
                      foregroundColor: UIColors.primaryWhite,
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {},
                    child: Text(context.strings.new_student),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: 6,
                itemBuilder: (_, __) => _StudentCard(
                  firstName: "Victor",
                  lastName: "Gaudiot",
                  checkInQuantity: 10,
                  className: "BV sábado",
                  isSub21: true,
                ),
                separatorBuilder: (_, __) => SizedBox(height: 8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// MARK: - Components

final class _StudentCard extends StatelessWidget {
  final String firstName;
  final String lastName;
  final bool isSub21;
  final int checkInQuantity;
  final String? className;

  const _StudentCard({
    required this.firstName,
    required this.lastName,
    required this.checkInQuantity,
    this.isSub21 = false,
    this.className,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "$firstName $lastName",
                      style: TextStyle(fontSize: 24),
                    ),
                    if (isSub21) ...[
                      SizedBox(width: 8),
                      Icon(Icons.keyboard_double_arrow_down_rounded),
                    ]
                  ],
                ),
                SizedBox(height: 8),
                Text(className ?? "Not enrolled"),
              ],
            ),
            Spacer(),
            Icon(Icons.check_circle_outline, size: 16),
            SizedBox(width: 4),
            Text("$checkInQuantity", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
