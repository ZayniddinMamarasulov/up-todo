import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:up_todo/screens/widgets/category_picker.dart';
import 'package:up_todo/utils/colors.dart';

import '../../database/category.dart';
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
  int categoryId = -1; // ---------- 21:25

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
            Row(
              children: [
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
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          backgroundColor: AppColors.C_363636,
                          content: CategoryPicker(
                            onSelected: (index) {
                              categoryId = index;
                              setState(() {});
                            },
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.label,
                      color: Colors.white,
                    ))
              ],
            ),
            Row(
              children: [
                Text(
                  taskDay.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(width: 24),
                categoryId != -1
                    ? Text(
                        TodoCategory.categories[categoryId].name,
                        style: TextStyle(color: Colors.white),
                      )
                    : Container(),
              ],
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    formKey.currentState?.save();
                    if (newTitle.isNotEmpty &&
                        newDescription.isNotEmpty &&
                        taskDay != null &&
                        categoryId != -1) {
                      var newTodo = TodoModel(
                        title: newTitle,
                        description: newDescription,
                        date: taskDay.toString(),
                        categoryId: categoryId,
                        priority: 0,
                        isCompleted: 0,
                      );
                      LocalDatabase.insertToDatabase(newTodo);
                      widget.onNewTask();
                      Navigator.pop(context);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Oshibka qildin"),
                          content: Text("Hamasn toldrin"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Chundm"),
                            )
                          ],
                        ),
                      );
                    }
                  },
                  child: Text("Add")),
            )
          ],
        ),
      ),
    );
  }
}
