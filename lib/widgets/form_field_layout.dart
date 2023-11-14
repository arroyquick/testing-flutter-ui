import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:responsive_framework/responsive_row_column.dart';

///
class FormFieldLayout extends StatelessWidget {
  const FormFieldLayout({super.key, required this.fields, this.rowSpacing, this.columnSpacing});

  final List<Widget> fields;
  final double? rowSpacing;
  final double? columnSpacing;

  @override
  Widget build(BuildContext context) {
    return ResponsiveRowColumn(
      layout: ResponsiveBreakpoints.of(context).largerThan(MOBILE)
          ? ResponsiveRowColumnType.ROW
          : ResponsiveRowColumnType.COLUMN,
      rowCrossAxisAlignment: CrossAxisAlignment.start,
      rowSpacing: rowSpacing,
      columnSpacing: columnSpacing,
      children: fields
          .map(
            (field) => ResponsiveRowColumnItem(
              rowFlex: 1,
              child: field,
            ),
          )
          .toList(),
    );
  }
}
