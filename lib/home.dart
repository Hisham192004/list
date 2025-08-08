import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project/addlist.dart';

class Student {
  String name;
  String age;
  String studentClass;

  Student({required this.name, required this.age, required this.studentClass});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Student> students = [];
  final Box hiBox=Hive.box('hi');

  void addStudent(Student student) {
    setState(() {
      students.add(student);
    });
  }

  void updateStudent(int index, Student student) {
    setState(() {
      students[index] = student;
    });
  }

  void deleteStudent(int index) {
    setState(() {
      students.removeAt(index);
    });
  }

  void navigateToAddScreen({Student? student, int? index}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddScreen(
          student: student, Student: [],
        ),
      ),
    );

    if (result != null && result is Student) {
      if (student != null && index != null) {
        updateStudent(index, result);
      } else {
        addStudent(result);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lists"),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final stu = students[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(stu.name),
              subtitle: Text("Age: ${stu.age}, Class: ${stu.studentClass}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      navigateToAddScreen(student: stu, index: index);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      deleteStudent(index);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToAddScreen(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
