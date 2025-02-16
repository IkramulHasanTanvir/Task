class GetAllTask {
  String? status;
  String? message;
  TaskList? data;

  GetAllTask({this.status, this.message, this.data});

  GetAllTask.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new TaskList.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TaskList {
  int? count;
  List<MyTasks>? myTasks;

  TaskList({this.count, this.myTasks});

  TaskList.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['myTasks'] != null) {
      myTasks = <MyTasks>[];
      json['myTasks'].forEach((v) {
        myTasks!.add(new MyTasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.myTasks != null) {
      data['myTasks'] = this.myTasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyTasks {
  String? sId;
  String? title;
  String? description;
  String? creatorEmail;
  String? createdAt;
  String? updatedAt;
  int? iV;

  MyTasks(
      {this.sId,
        this.title,
        this.description,
        this.creatorEmail,
        this.createdAt,
        this.updatedAt,
        this.iV});

  MyTasks.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    creatorEmail = json['creator_email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['creator_email'] = this.creatorEmail;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
