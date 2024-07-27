// import 'package:flutterflow_ui/flutterflow_ui.dart';
// import 'project_page_widget.dart' show ProjectPageWidget;
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class ProjectPageModel extends FlutterFlowModel<ProjectPageWidget> with ChangeNotifier {
//   ///  State fields for stateful widgets in this page.

//   final unfocusNode = FocusNode();
//   List<Project> _projects = [];

//   List<Project> get projects => _projects;

//   @override
//   void initState(BuildContext context) {
//     fetchProjects();
//   }

//   @override
//   void dispose() {
//     unfocusNode.dispose();
//     super.dispose();
//   }

//   Future<void> fetchProjects() async {
//   try {
//     final response = await http.get(Uri.parse('http://10.0.2.2:14000/projects'));

//     if (response.statusCode == 200) {
//       List jsonResponse = json.decode(response.body);
//       _projects = jsonResponse.map((project) => Project.fromJson(project)).toList();
//       notifyListeners(); // To notify listeners about the data change
//     } else {
//       throw Exception('Failed to load projects: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('Error fetching projects: $e');
//     throw Exception('Failed to load projects: $e');
//   }
// }

// }

// class Project {
//   final String projectName;
//   final String projectDate;
//   final int docCount;
//   final String status;
//   final int projectID;

//   Project({
//     required this.projectName,
//     required this.projectDate,
//     required this.docCount,
//     required this.status,
//     required this.projectID,
//   });

//   factory Project.fromJson(Map<String, dynamic> json) {
//     return Project(
//       projectName: json['projectName'],
//       projectDate: json['projectDate'],
//       docCount: json['docCount'],
//       status: json['status'],
//       projectID: json['projectID'],
//     );
//   }
// }


import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:projexpert/helpers/PreferencesManager.dart';
import 'project_page_widget.dart' show ProjectPageWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProjectPageModel extends FlutterFlowModel<ProjectPageWidget> with ChangeNotifier {
  /// State fields for stateful widgets in this page.
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



//  Future<void> fetchProjects() async {
//   try {
//     final response = await http.get(Uri.parse('http://10.0.2.2:15000/api/project/user-projects'));

//     if (response.statusCode == 200) {
//       // Log the response body to inspect the JSON structure
//       //print('Response body: ${response.body}');
//       print('PREFERENCES: ${await PreferencesManager().getAccessToken()}');
//       // Decode the response body as a Map
//       Map<String, dynamic> jsonResponse = json.decode(response.body);

//       // Extract the list of projects from the 'data' field
//       List<dynamic>? projectsJson = jsonResponse['data']; 

//       if (projectsJson == null) {
//         throw Exception('No projects found in the response.');
//       }

//       // Update the projects list with the fetched data
//       _projects = projectsJson.map((project) => Project.fromJson(project)).toList();
//       notifyListeners(); // To notify listeners about the data change
//     } else {
//       throw Exception('Failed to load projects: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('Error fetching projects: $e');
//     throw Exception('Failed to load projects: $e');
//   }
// }

Future<void> fetchProjects() async {
  try {
    // Get the access token
    final accessToken = await PreferencesManager().getAccessToken();

    // Ensure the access token is not null
    if (accessToken == null) {
      throw Exception('Access token is not available.');
    }

    // Make the HTTP GET request with Authorization header
    final response = await http.get(
      Uri.parse('http://10.0.2.2:15000/api/project/user-projects'),
      headers: {
        'Authorization': 'Bearer: $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Log the response body to inspect the JSON structure
      //print('Response body: ${response.body}');
      print('PREFERENCES: $accessToken');
      
      // Decode the response body as a Map
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      // Extract the list of projects from the 'data' field
      List<dynamic>? projectsJson = jsonResponse['data']; 

      if (projectsJson == null) {
        throw Exception('No projects found in the response.');
      }

      // Update the projects list with the fetched data
      _projects = projectsJson.map((project) => Project.fromJson(project)).toList();
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
  final String id; // Using _id from JSON
  final String projectNo; // Using _id for projectNo
  final String projectName;
  final String status;
  final String createDate;
  final List<dynamic> projectDocs;
  final int docCount;

  Project({
    required this.id,
    required this.projectNo,
    required this.projectName,
    required this.status,
    required this.createDate,
    required this.projectDocs,
  }) : docCount = projectDocs.length;

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['_id'],
      projectNo: json['_id'], // projectNo as _id
      projectName: json['projectName'],
      status: json['status'],
      createDate: json['createDate'],
      projectDocs: json['projectDocs'],
    );
  }
}
