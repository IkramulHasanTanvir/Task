import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tanvir/models/get_all_task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.myTasks});

  final MyTasks myTasks;

  @override
  Widget build(BuildContext context) {
    final String date = DateFormat('EEE, M/ d/ y').format(
      DateTime.parse(
        myTasks.createdAt!,
      ),
    );

    return ListTile(
      title: Text(myTasks.title ?? '',
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(myTasks.description ?? ''),
          Text(
            'email : ${myTasks.creatorEmail}',
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600),
          ),
          Text(
            'Date: $date',
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              )),
        ],
      ),
    );
  }
}
