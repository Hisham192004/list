import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'home.dart';

class AddScreen extends StatefulWidget {
  final Student? student;

  const AddScreen({super.key, this.student, required List<Student> Student});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final Box hiBox=Hive.box('hi');

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      nameController.text = widget.student!.name;
      ageController.text = widget.student!.age;
      classController.text = widget.student!.studentClass;
    }
  }

  void addData() {
    final name = nameController.text.trim();
    final age = ageController.text.trim();
    final studentClass = classController.text.trim();

    if (name.isNotEmpty && age.isNotEmpty && studentClass.isNotEmpty) {
      final student = Student(name: name, age: age, studentClass: studentClass);
      Navigator.pop(context, student);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.student == null ? 'Add Student' : 'Edit Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Student Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Age'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: classController,
                decoration: const InputDecoration(labelText: 'Class'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: addData,
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
