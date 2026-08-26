import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete Account"),
      content: const Text("Are you sure you want to delete your account?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text("Delete"),
        ),
      ],
    );
  }
}
