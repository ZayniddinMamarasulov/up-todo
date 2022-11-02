import 'package:flutter/material.dart';
import 'package:up_todo/database/local_database.dart';
import 'package:up_todo/utils/colors.dart';
import 'package:up_todo/utils/time_utils.dart';

import '../../models/todo_model.dart';

class TaskItem extends StatelessWidget {
  TodoModel? model;
  final VoidCallback onDeleted;
  final VoidCallback onSelected;

  TaskItem({
    Key? key,
    required this.model,
    required this.onDeleted,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelected,
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(12),
        color: AppColors.C_363636,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  model?.id.toString() ?? "-1",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 8),
                Text(
                  model?.title.toString() ?? "No title",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  TimeUtils.formatToMyTime(DateTime.parse(model!.date)),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Delete"),
                          content: Text(
                            "Are you sure to delete task ${model?.title}",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {},
                              child: Text("NO"),
                            ),
                            TextButton(
                              onPressed: () async {
                                var res = await LocalDatabase.deleteTaskById(
                                    model!.id!);
                                if (res != 0) {
                                  Navigator.pop(context);
                                  onDeleted();
                                }
                              },
                              child: Text("YES"),
                            ),
                          ],
                        );
                      });
                },
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                  size: 28,
                ))
          ],
        ),
      ),
    );
  }
}
