import 'package:flutter/material.dart';
import 'package:tanvir/models/get_all_task.dart';
import 'package:tanvir/services/network_caller.dart';
import 'package:tanvir/services/network_response.dart';
import 'package:tanvir/services/urls.dart';
import 'package:tanvir/widgets/task_tile.dart';

class AllTaskScreen extends StatefulWidget {
  const AllTaskScreen({super.key});

  @override
  State<AllTaskScreen> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AllTaskScreen> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _desController = TextEditingController();
  List<MyTasks> _Tasklist = [];
  bool inProgress = false;

  @override
  void initState() {
    super.initState();
    _getAllTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade600,
        centerTitle: true,
        title: const Text(
          'Task',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Text(
            'Count : ${_Tasklist.length}', // Dynamic count
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          const Divider(),
          const SizedBox(height: 10),
          inProgress
              ? const Center(child: CircularProgressIndicator()) // Loading indicator
              : Expanded(
            child: ListView.builder(
              itemCount: _Tasklist.length,
              itemBuilder: (context, index) {
                return TaskTile(
                  myTasks: _Tasklist[index],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add Task'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        hintText: 'title',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _desController,
                      decoration: const InputDecoration(
                        hintText: 'description',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(onPressed: _createTask, child: const Text('Save'))
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _getAllTask() async {
    setState(() {
      inProgress = true;
    });

      NetworkResponse response = await NetworkCaller.getRequest(url: Urls.getAllTask);

      if (response.isSuccess) {
        GetAllTask taskResponse = GetAllTask.fromJson(response.responseBody);
        _Tasklist = taskResponse.data?.myTasks ?? [];
      } else {
      }
      setState(() {
        inProgress = false;
      });
  }
  Future<void> _createTask() async {

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.createTask,
      body: {
        "title": _titleController.text.trim(),
        "description": _desController.text.trim(),
      },
    );

    if (response.isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("created")),
      );
      Navigator.pop(context);
      // Check if token exists
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("faild")),
      );
    }
  }

}
