import 'package:flutter/material.dart';

class DeleteTaskDialog extends StatelessWidget {
  const DeleteTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Attenzione!'),
      content: Text('Sei sicuro di voler cancellare il task?'),
      actions: <Widget>[
        TextButton(
          child: Text('No'),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        TextButton(
          child: Text('Sì, sono sicuro'),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}
