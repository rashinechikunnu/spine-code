import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNoted extends StatefulWidget {
  const AddNoted({super.key});

  @override
  State<AddNoted> createState() => _AddNotedState();
}

class _AddNotedState extends State<AddNoted> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _addNote() async {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Both fields are required")),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('notepad').add({
        'title': title,
        'description': description,
        'timestamp': FieldValue.serverTimestamp(), // optional: for sorting
      });

      Navigator.pop(context); // Go back to home after adding
    } catch (e) {
      print("Error adding note: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add note")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text("Add Note"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  label: Text("Title"),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  label: Text("Description"),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: _addNote,
                child: Text("Add Note"),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
