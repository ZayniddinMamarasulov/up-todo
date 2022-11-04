import 'package:flutter/material.dart';
import 'package:up_todo/screens/widgets/task_item.dart';
import 'package:up_todo/screens/widgets/update_task_widget.dart';

import '../database/local_database.dart';
import '../models/todo_model.dart';
import '../utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: (val) {
                setState(() {
                  search = val;
                });
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                filled: true,
                fillColor: AppColors.C_363636.withOpacity(0.5),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.white,
                )),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.red,
                )),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: LocalDatabase.getTaskByTitle(title: search),
              builder: (BuildContext context,
                  AsyncSnapshot<List<TodoModel>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return const Center(
                        child: Icon(
                      Icons.file_copy_outlined,
                      color: Colors.white,
                      size: 96,
                    ));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        model: snapshot.data![index],
                        onDeleted: () {
                          setState(() {});
                        },
                        onSelected: () {
                          showModalBottomSheet(
                            backgroundColor: AppColors.C_363636,
                            context: context,
                            builder: (context) {
                              return UpdateTaskWidget(
                                todo: snapshot.data![index],
                                onUpdatedTask: () {
                                  setState(() {});
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
