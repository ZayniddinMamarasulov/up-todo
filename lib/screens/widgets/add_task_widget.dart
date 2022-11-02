import 'package:flutter/material.dart';

import '../../database/local_database.dart';
import '../../models/todo_model.dart';

class AddTaskWidget extends StatefulWidget {
  VoidCallback onNewTask;

  AddTaskWidget({Key? key, required this.onNewTask}) : super(key: key);

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  final formKey = GlobalKey<FormState>();
  String newTitle = "";
  String newDescription = "";
  DateTime? taskDay; // 02.11.2022 ----
  TimeOfDay? taskTime; // ---------- 21:25

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              onSaved: (val) {
                newTitle = val ?? "";
              },
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.2),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              onSaved: (val) {
                newDescription = val ?? "";
              },
              maxLines: 8,
              decoration: InputDecoration(
                hintText: 'Description',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.2),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),
            IconButton(
              onPressed: () async {
                taskDay = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2300),
                );
                taskTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                taskDay = DateTime(
                  taskDay!.year,
                  taskDay!.month,
                  taskDay!.day,
                  taskTime!.hour,
                  taskTime!.minute,
                );
              },
              icon: Icon(
                Icons.calendar_month,
                color: Colors.white,
              ),
            ),
            Text(
              taskDay.toString(),
              style: TextStyle(color: Colors.white),
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    formKey.currentState?.save();
                    var newTodo = TodoModel(
                      title: newTitle,
                      description: newDescription,
                      date: taskDay.toString(),
                      priority: "priority",
                      isCompleted: 0,
                    );
                    LocalDatabase.insertToDatabase(newTodo);
                    widget.onNewTask();
                    Navigator.pop(context);
                  },
                  child: Text("Add")),
            )
          ],
        ),
      ),
    );
  }
}
