import 'package:flutter/material.dart';

class SafeProgressOverlay extends StatelessWidget {
  final bool isSaving;

  const SafeProgressOverlay({Key? key, required this.isSaving})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      //Wenn wir nicht speichern können wir drücken
      ignoring: !isSaving,
      child: Visibility(
        visible: isSaving,
        child: Center(
          child: CircularProgressIndicator(color: Colors.pink),
        ),
      ),
    );
  }
}
