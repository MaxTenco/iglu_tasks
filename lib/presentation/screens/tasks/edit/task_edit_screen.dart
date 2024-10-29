import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../commons/alert_snack_bar.dart';
import '../../../providers/tasks/task_edit_provider.dart';
import '../../../validator.dart';
import 'components/checkbox_field.dart';
import 'components/delete_task_dialog.dart';

class TaskEditScreen extends StatelessWidget {
  const TaskEditScreen({super.key});

  Future<void> _onDeletePressed(BuildContext context, TaskEditProvider provider) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => DeleteTaskDialog(),
    );

    if (result != null && result) {
      try {
        provider.showLoading();
        await provider.deleteTask();

        if (context.mounted) {
          Navigator.pop(context, true);
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(kAlertSnackBar);
        }
      } finally {
        if (context.mounted) {
          provider.hideLoading();
        }
      }
    }
  }

  Future<void> _onSavePressed(BuildContext context, TaskEditProvider provider) async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();

      provider.showLoading();
      final result = await provider.onSavePressed();

      if (result && context.mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(kAlertSnackBar);
      }
    } finally {
      if (context.mounted) {
        provider.hideLoading();
      }
    }
  }

  Widget _form(TaskEditProvider provider) {
    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, top: 8),
          child: Form(
            key: provider.formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Titolo',
                    hintText: 'Inserisci un titolo',
                  ),
                  initialValue: provider.taskForm.title,
                  onSaved: (value) => provider.taskForm.title = value,
                  validator: Validator.required().call,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Descrizione',
                    hintText: 'Inserisci una descrizione',
                  ),
                  initialValue: provider.taskForm.description,
                  onSaved: (value) => provider.taskForm.description = value,
                  validator: Validator.required().call,
                ),
                const SizedBox(height: 16),
                if (provider.taskForm.hasId)
                  CheckboxField(
                    initialValue: provider.taskForm.isCompleted,
                    onChanged: provider.onCheckBoxChanged,
                  ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskEditProvider>();

    return Scaffold(
      appBar: AppBar(
        actions: [
          if (provider.taskForm.hasId)
            IconButton(
              onPressed: provider.isLoading ? null : () => _onDeletePressed(context, provider),
              icon: Icon(Icons.delete),
            ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: provider.isLoading ? null : () => _onSavePressed(context, provider),
          child: provider.isLoading ? CircularProgressIndicator() : Text('Salva'),
        ),
      ),
      body: _form(provider),
    );
  }
}
