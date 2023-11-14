import 'package:flutter/material.dart';
import 'package:quicket_ui_sample/citations/local/sections/animal.dart';
import 'package:quicket_ui_sample/widgets/citation_stepper.dart';

class LocalCitation extends StatefulWidget {
  const LocalCitation({Key? key}) : super(key: key);

  @override
  State<LocalCitation> createState() => _LocalCitationState();
}

class _LocalCitationState extends State<LocalCitation> {

  @override
  Widget build(BuildContext context) {
    List<CitationStep> steps = [
      CitationStep(
          label: const Text("Defendant"),
          content: const Center(
            child: Text("Defendant"),
          ),
      ),
      CitationStep(
        label: const Text("Vehicle Data"),
        content: const Center(
          child: Text("Vehicle Data"),
        ),
      ),
      CitationStep(
        label: const Text("Animal"),
        content: const Animal()
      ),
      CitationStep(
        label: const Text("Violation Data"),
        content: const Center(
          child: Text("Violation Data"),
        ),
      ),
      CitationStep(
        label: const Text("Court"),
        content: const Center(
          child: Text("Court"),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Local Citation"),
      ),
      body: CitationStepper(steps: steps, labelPosition: LabelPosition.below)
    );
  }
}
