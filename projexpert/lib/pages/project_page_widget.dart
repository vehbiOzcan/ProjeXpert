import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:projexpert/helpers/PreferencesManager.dart';
import 'package:projexpert/pages/login_page_widget.dart';
import 'package:projexpert/pages/project_page_model.dart';
import 'package:projexpert/pages/projectdetail_page_widget.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProjectPageWidget extends StatefulWidget {
  const ProjectPageWidget({super.key});

  @override
  State<ProjectPageWidget> createState() => _ProjectPageWidgetState();
}

class _ProjectPageWidgetState extends State<ProjectPageWidget> {
  late ProjectPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProjectPageModel());
    _model.fetchProjects().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _fetchAndUpdateProjects() async {
    await _model.fetchProjects();
    setState(() {});
  }

  Future<void> _navigateToProjectDetail(String projectId) async {
    try {
      final accessToken = await PreferencesManager().getAccessToken();
      //print("Proje ID:"+ projectId + "  " + accessToken.toString());
      // Ensure the access token is not null
      if (accessToken == null) {
        throw Exception('Access token is not available.');
      }

      // Make the HTTP GET request with Authorization header
      final response = await http.get(
        Uri.parse('http://10.0.2.2:15000/api/project/detail/$projectId'),
        headers: {
          'Authorization': 'Bearer: $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response body as JSON
        print(response.body);
        final projectDetail = json.decode(response.body);

        // Navigate to ProjectdetailPageWidget with project detail data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectdetailPageWidget(
              projectDetail: projectDetail["data"],
            ),
          ),
        );
      } else {
        throw Exception(
            'Failed to load project detail: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching project detail: $e');
      throw Exception('Failed to load project detail: $e');
    }
  }

  Future<void> _addProject(
      String name, String no, String date, String status) async {
    try {
      final accessToken = await PreferencesManager().getAccessToken();
      //print("Proje ID:"+ projectId + "  " + accessToken.toString());
      // Ensure the access token is not null
      if (accessToken == null) {
        throw Exception('Access token is not available.');
      }
      final url = Uri.parse('http://10.0.2.2:15000/api/project/add-project');
      final headers = {
        'Authorization': 'Bearer: $accessToken',
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        'projectName': name,
        'projectNo': no,
        'projectDate': date,
        'status': status,
      });
      print("PROJECT INFO: " + name + " " + date + " " + status);
      final response = await http.post(url, headers: headers, body: body);
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ProjectdetailPageWidget(projectDetail: jsonResponse['data'],)));
      if (response.statusCode == 200) {
        print('Project added successfully');
      } else {
        print(
            'Failed to add project: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error adding project: $e');
    } finally {
      projectName = '';
      projectDate = '';
      projectNo = '';
      projectStatus = 'planned';
    }
  }

  String projectName = '';
  String projectDate = '';
  String projectNo = '';
  String projectStatus = 'planned'; // Default seçili durum

  final List<String> statusOptions = ['planned', 'ongoing', 'completed'];
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      setState(() {
        projectDate = formattedDate;
        _dateController.text = formattedDate; // Update the controller's text
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => _model.unfocusNode.canRequestFocus
            ? FocusScope.of(context).requestFocus(_model.unfocusNode)
            : FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Color(0xFFF9F9F9),
          appBar: AppBar(
            backgroundColor: Color(0xFFff9f1a),
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 60,
              icon: Icon(
                Icons.exit_to_app,
                color: FlutterFlowTheme.of(context).primaryBackground,
                size: 30,
              ),
              onPressed: () async {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPageWidget()));
              },
            ),
            title: Text(
              'Projeler',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit', letterSpacing: 0, color: Colors.white),
            ),
            actions: [],
            centerTitle: false,
            elevation: 0,
          ),
          body: SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                    child: Text(
                      'Projelerim',
                      style:
                          FlutterFlowTheme.of(context).headlineMedium.override(
                                fontFamily: 'Outfit',
                                letterSpacing: 0,
                              ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 4, 0, 0),
                    child: Text(
                      'Daha önce oluşturulan projeler',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0,
                          ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: _model.projects.map((project) {
                        return Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                          child: Container(
                            width: double.infinity,
                            constraints: BoxConstraints(
                              maxWidth: 570,
                            ),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16, 12, 16, 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 12, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          textScaler:
                                              MediaQuery.of(context).textScaler,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Proje: ',
                                                style: TextStyle(),
                                              ),
                                              TextSpan(
                                                text: project.projectName,
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                            style: FlutterFlowTheme.of(context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  letterSpacing: 0,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 4, 0, 0),
                                          child: Text(
                                            project.createDate.split("T")[0],
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  letterSpacing: 0,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 4, 0, 0),
                                          child: Text(
                                            project.id,
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  letterSpacing: 0,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 12, 0, 0),
                                          child: Container(
                                            height: 32,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                width: 2,
                                              ),
                                            ),
                                            child: Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(7, 0, 7, 0),
                                                child: Text(
                                                  project.docCount.toString(),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        letterSpacing: 0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      FFButtonWidget(
                                        onPressed: () {
                                          _navigateToProjectDetail(project.id);
                                        },
                                        text: 'Görüntüle',
                                        options: FFButtonOptions(
                                          height: 40,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24, 0, 24, 0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 0),
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: Colors.white,
                                                    letterSpacing: 0,
                                                  ),
                                          elevation: 3,
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 12, 0, 0),
                                        child: Container(
                                          height: 32,
                                          decoration: BoxDecoration(
                                            color:
                                                _getStatusColor(project.status)
                                                    .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                              color: _getStatusColor(
                                                  project.status),
                                              width: 2,
                                            ),
                                          ),
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(12, 0, 12, 0),
                                              child: Text(
                                                project.status,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: _getStatusColor(
                                                          project.status),
                                                      letterSpacing: 0,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Yeni Proje Ekle',
                      style:
                          FlutterFlowTheme.of(context).headlineMedium.override(
                                fontFamily: 'Outfit',
                                letterSpacing: 0,
                              ),
                    ),
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Proje İsmi',
                          ),
                          onChanged: (value) {
                            projectName = value;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Proje No',
                          ),
                          onChanged: (value) {
                            projectNo = value;
                          },
                        ),
                        TextField(
                          controller:
                              _dateController, // Use the controller here
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: 'Bitiş Tarihi',
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          onTap: () => _selectDate(context),
                        ),
                        DropdownButtonFormField<String>(
                          value: projectStatus,
                          decoration: InputDecoration(hintText: 'Durum'),
                          onChanged: (String? newValue) {
                            setState(() {
                              projectStatus = newValue!;
                            });
                          },
                          items: statusOptions.map((String status) {
                            return DropdownMenuItem<String>(
                              value: status,
                              child: Text(status),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xFFEB5A46),
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text('İptal'),
                      ),
                      TextButton(
                        onPressed: () {
                          _addProject(projectName, projectNo, projectDate,
                              projectStatus);
                          _fetchAndUpdateProjects();
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xFFFF9F1A),
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text('Ekle'),
                      ),
                    ],
                  );
                },
              );
            },
            backgroundColor: Color(0xFFeb5a46),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ));
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return Color(0xFF70b500);
      case 'ongoing':
        return Color(0xFFff9f1a);
      case 'planned':
        return Color(0xFFc377e0);
      default:
        return FlutterFlowTheme.of(context).accent1;
    }
  }
}