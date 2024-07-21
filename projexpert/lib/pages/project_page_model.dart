import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'project_page_widget.dart' show ProjectPageWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProjectPageModel extends FlutterFlowModel<ProjectPageWidget> with ChangeNotifier {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  List<Project> _projects = [];

  List<Project> get projects => _projects;

  @override
  void initState(BuildContext context) {
    fetchProjects();
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    super.dispose();
  }

  Future<void> fetchProjects() async {
  try {
    final response = await http.get(Uri.parse('http://10.0.2.2:15000/projects'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      _projects = jsonResponse.map((project) => Project.fromJson(project)).toList();
      notifyListeners(); // To notify listeners about the data change
    } else {
      throw Exception('Failed to load projects: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching projects: $e');
    throw Exception('Failed to load projects: $e');
  }
}

}

class Project {
  final String projectName;
  final String projectDate;
  final int docCount;
  final String status;
  final int projectID;

  Project({
    required this.projectName,
    required this.projectDate,
    required this.docCount,
    required this.status,
    required this.projectID,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      projectName: json['projectName'],
      projectDate: json['projectDate'],
      docCount: json['docCount'],
      status: json['status'],
      projectID: json['projectID'],
    );
  }
}
