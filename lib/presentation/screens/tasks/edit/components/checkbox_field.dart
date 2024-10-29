import 'package:flutter/material.dart';

class CheckboxField extends StatefulWidget {
  const CheckboxField({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  final bool initialValue;
  final Function(bool) onChanged;

  @override
  State<CheckboxField> createState() => _CheckboxFieldState();
}

class _CheckboxFieldState extends State<CheckboxField> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = value ?? false;
            });
            widget.onChanged(_isChecked);
          },
        ),
        Text('Completato'),
      ],
    );
  }
}
