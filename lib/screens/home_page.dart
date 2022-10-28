import 'package:flutter/material.dart';
import 'package:up_todo/screens/widgets/task_item.dart';

import '../database/local_database.dart';
import '../models/todo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: LocalDatabase.getList(),
        builder:
            (BuildContext context, AsyncSnapshot<List<TodoModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
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
                  model: snapshot.data?[index],
                  onDeleted: () {
                    setState(() {});
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
