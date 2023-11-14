import 'package:flutter/material.dart';
import 'package:responsive_framework/max_width_box.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class CitationStep {
  final Widget label;
  final Widget content;

  CitationStep({required this.label, required this.content});
}

enum LabelPosition { beside, below }

class CitationStepper extends StatefulWidget {
  const CitationStepper(
      {super.key,
      this.orientation = StepperType.horizontal,
      this.labelPosition = LabelPosition.beside,
      required this.steps});

  final List<CitationStep> steps;
  final StepperType orientation;
  final LabelPosition labelPosition;

  @override
  State<CitationStepper> createState() => _CitationStepperState();
}

class _CitationStepperState extends State<CitationStepper> {
  int _activeStep = 0;
  late List<GlobalKey<FormState>> _formKeys;
  late List<bool> stepValidationStatus;

  @override
  void initState() {
    super.initState();
    _formKeys =
        List.generate(widget.steps.length, (_) => GlobalKey<FormState>());
    stepValidationStatus = List.generate(widget.steps.length, (_) => true);
  }

  validate() {
    for (int i = 0; i < widget.steps.length; i++) {
      final FormState? formState = _formKeys[i].currentState;
      if (formState!.validate()) {
        setState(() {
          stepValidationStatus[i] = true;
        });
      } else {
        setState(() {
          stepValidationStatus[i] = false;
        });
      }
    }
    if (stepValidationStatus.contains(false)) {
      setState(() {
        _activeStep = stepValidationStatus.indexOf(false);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid"),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Valid"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  validateStep() {
    final FormState? formState = _formKeys[_activeStep].currentState;
    if (formState!.validate()) {
      setState(() {
        stepValidationStatus[_activeStep] = true;
      });
    } else {
      setState(() {
        stepValidationStatus[_activeStep] = false;
      });
    }
  }

  onStepTapped(int step) {
    validateStep();
    setState(() {
      _activeStep = step;
    });
  }

  onStepCancel() {
    if (_activeStep > 0) {
      setState(() {
        _activeStep -= 1;
      });
    }
  }

  onStepContinue() {
    if (_activeStep < widget.steps.length - 1) {
      validateStep();
      setState(() {
        _activeStep += 1;
      });
    }
  }

  Widget controlsBuilder(BuildContext context, ControlsDetails details) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: MaxWidthBox(
        maxWidth: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_activeStep != 0)
              Expanded(
                child: OutlinedButton(
                  onPressed: details.onStepCancel,
                  child: const Text("Back"),
                ),
              ),
            const SizedBox(
              width: 10,
            ),
            _activeStep != widget.steps.length - 1
                ? Expanded(
                    child: ElevatedButton(
                      onPressed: details.onStepContinue,
                      child: const Text("Next"),
                    ),
                  )
                : Expanded(
                    child: ElevatedButton(
                      onPressed: validate,
                      child: const Text("Submit"),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      connectorThickness: 1,
      currentStep: _activeStep,
      onStepTapped: onStepTapped,
      onStepContinue: onStepContinue,
      onStepCancel: onStepCancel,
      type: widget.orientation,
      steps: widget.steps
          .map(
            (step) => Step(
                state: stepValidationStatus[widget.steps.indexOf(step)]
                    ? StepState.indexed
                    : StepState.error,
                title: widget.labelPosition == LabelPosition.beside
                    ? ResponsiveBreakpoints.of(context).largerThan(MOBILE)
                        ? step.label
                        : _activeStep == widget.steps.indexOf(step)
                            ? step.label
                            : Container()
                    : Container(),
                label: widget.labelPosition == LabelPosition.below
                    ? ResponsiveBreakpoints.of(context).largerThan(MOBILE)
                        ? step.label
                        : _activeStep == widget.steps.indexOf(step)
                            ? step.label
                            : null
                    : null,
                content: Form(
                  key: _formKeys[widget.steps.indexOf(step)],
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 300,
                    child: SingleChildScrollView(
                      child: MaxWidthBox(maxWidth: 800, child: step.content),
                    ),
                  ),
                ),
                isActive: _activeStep >= widget.steps.indexOf(step)),
          )
          .toList(),
      controlsBuilder: controlsBuilder,
    );
  }
}
