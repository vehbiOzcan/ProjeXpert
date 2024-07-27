import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:projexpert/helpers/PreferencesManager.dart';
import 'package:projexpert/pages/login_page_widget.dart';
import 'package:projexpert/pages/project_page_model.dart';
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

  Future<void> _addProject(String name, String date, String status) async {
    final url = Uri.parse('http://10.0.2.2:14000/projects');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'projectName': name,
      'projectDate': date,
      'status': status,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        print('Project added successfully');
      } else {
        print(
            'Failed to add project: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error adding project: $e');
    }
  }

  String projectName = '';
  String projectDate = '';
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


//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _model.unfocusNode.canRequestFocus
//           ? FocusScope.of(context).requestFocus(_model.unfocusNode)
//           : FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
//         appBar: AppBar(
//           backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
//           automaticallyImplyLeading: false,
//           leading: FlutterFlowIconButton(
//             borderColor: Colors.transparent,
//             borderRadius: 30,
//             borderWidth: 1,
//             buttonSize: 60,
//             icon: Icon(
//               Icons.arrow_back_rounded,
//               color: FlutterFlowTheme.of(context).secondaryText,
//               size: 30,
//             ),
//             onPressed: () async {
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (context) => LoginPageWidget()));
//             },
//           ),
//           actions: [],
//           centerTitle: true,
//           elevation: 0,
//         ),
//         body: SafeArea(
//           top: true,
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
//                   child: Text(
//                     'Projelerim',
//                     style: FlutterFlowTheme.of(context).headlineMedium.override(
//                           fontFamily: 'Outfit',
//                           letterSpacing: 0,
//                         ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(24, 4, 0, 0),
//                   child: Text(
//                     'Daha önce oluşturulan projeler',
//                     textAlign: TextAlign.start,
//                     style: FlutterFlowTheme.of(context).labelMedium.override(
//                           fontFamily: 'Readex Pro',
//                           letterSpacing: 0,
//                         ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 24),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.max,
//                     children: _model.projects.map((project) {
//                       return Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
//                         child: Container(
//                           width: double.infinity,
//                           constraints: BoxConstraints(
//                             maxWidth: 570,
//                           ),
//                           decoration: BoxDecoration(
//                             color: FlutterFlowTheme.of(context)
//                                 .secondaryBackground,
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(
//                               color: FlutterFlowTheme.of(context).alternate,
//                               width: 2,
//                             ),
//                           ),
//                           child: Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.max,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsetsDirectional.fromSTEB(
//                                       0, 0, 12, 0),
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.max,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       RichText(
//                                         textScaler:
//                                             MediaQuery.of(context).textScaler,
//                                         text: TextSpan(
//                                           children: [
//                                             TextSpan(
//                                               text: 'Proje: ',
//                                               style: TextStyle(),
//                                             ),
//                                             TextSpan(
//                                               text: project.projectName,
//                                               style: TextStyle(
//                                                 color:
//                                                     FlutterFlowTheme.of(context)
//                                                         .primary,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ],
//                                           style: FlutterFlowTheme.of(context)
//                                               .bodyLarge
//                                               .override(
//                                                 fontFamily: 'Readex Pro',
//                                                 letterSpacing: 0,
//                                               ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             0, 4, 0, 0),
//                                         child: Text(
//                                           project.projectDate,
//                                           style: FlutterFlowTheme.of(context)
//                                               .labelMedium
//                                               .override(
//                                                 fontFamily: 'Readex Pro',
//                                                 letterSpacing: 0,
//                                               ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             0, 12, 0, 0),
//                                         child: Container(
//                                           height: 32,
//                                           decoration: BoxDecoration(
//                                             color: FlutterFlowTheme.of(context)
//                                                 .primaryBackground,
//                                             borderRadius:
//                                                 BorderRadius.circular(12),
//                                             border: Border.all(
//                                               color:
//                                                   FlutterFlowTheme.of(context)
//                                                       .alternate,
//                                               width: 2,
//                                             ),
//                                           ),
//                                           child: Align(
//                                             alignment:
//                                                 AlignmentDirectional(0, 0),
//                                             child: Padding(
//                                               padding: EdgeInsetsDirectional
//                                                   .fromSTEB(7, 0, 7, 0),
//                                               child: Text(
//                                                 project.docCount.toString(),
//                                                 style:
//                                                     FlutterFlowTheme.of(context)
//                                                         .labelMedium
//                                                         .override(
//                                                           fontFamily:
//                                                               'Readex Pro',
//                                                           letterSpacing: 0,
//                                                         ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Column(
//                                   mainAxisSize: MainAxisSize.max,
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     FFButtonWidget(
//                                       onPressed: () {
//                                         print('Button pressed ...');
//                                       },
//                                       text: 'Görüntüle',
//                                       options: FFButtonOptions(
//                                         height: 40,
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             24, 0, 24, 0),
//                                         iconPadding:
//                                             EdgeInsetsDirectional.fromSTEB(
//                                                 0, 0, 0, 0),
//                                         color: FlutterFlowTheme.of(context)
//                                             .primary,
//                                         textStyle: FlutterFlowTheme.of(context)
//                                             .titleSmall
//                                             .override(
//                                               fontFamily: 'Readex Pro',
//                                               color: Colors.white,
//                                               letterSpacing: 0,
//                                             ),
//                                         elevation: 3,
//                                         borderSide: BorderSide(
//                                           color: Colors.transparent,
//                                           width: 1,
//                                         ),
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsetsDirectional.fromSTEB(
//                                           0, 12, 0, 0),
//                                       child: Container(
//                                         height: 32,
//                                         decoration: BoxDecoration(
//                                           color: _getStatusColor(project.status)
//                                               .withOpacity(0.2),
//                                           borderRadius:
//                                               BorderRadius.circular(12),
//                                           border: Border.all(
//                                             color:
//                                                 _getStatusColor(project.status),
//                                             width: 2,
//                                           ),
//                                         ),
//                                         child: Align(
//                                           alignment: AlignmentDirectional(0, 0),
//                                           child: Padding(
//                                             padding:
//                                                 EdgeInsetsDirectional.fromSTEB(
//                                                     12, 0, 12, 0),
//                                             child: Text(
//                                               project.status,
//                                               style:
//                                                   FlutterFlowTheme.of(context)
//                                                       .bodyMedium
//                                                       .override(
//                                                         fontFamily:
//                                                             'Readex Pro',
//                                                         color: _getStatusColor(
//                                                             project.status),
//                                                         letterSpacing: 0,
//                                                       ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: Text('Yeni Proje Ekle',
//                 style:FlutterFlowTheme.of(context).headlineMedium.override(
//                           fontFamily: 'Outfit',
//                           letterSpacing: 0,
//                         ),),
//                 backgroundColor: Color.fromARGB(255, 255, 255, 255),
//                 content: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     TextField(
                      
//                       decoration: InputDecoration(hintText: 'Proje İsmi',),
//                       onChanged: (value) {
//                         projectName = value;
//                       },
//                     ),
//                     TextField(
//                       controller: _dateController, // Use the controller here
//                       readOnly: true,
//                       decoration: InputDecoration(
//                         hintText: 'Bitiş Tarihi',
//                         suffixIcon: Icon(Icons.calendar_today),
//                       ),
//                       onTap: () => _selectDate(context),
//                     ),
//                     DropdownButtonFormField<String>(
//                       value: projectStatus,
//                       decoration: InputDecoration(hintText: 'Durum'),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           projectStatus = newValue!;
//                         });
//                       },
//                       items: statusOptions.map((String status) {
//                         return DropdownMenuItem<String>(
//                           value: status,
//                           child: Text(status),
//                         );
//                       }).toList(),
//                     ),
//                   ],
//                 ),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     style: TextButton.styleFrom(
//                       backgroundColor: Color(0xFFEB5A46),
//                       primary: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                     ),
//                     child: Text('İptal'),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       _addProject(projectName, projectDate, projectStatus);
//                       Navigator.of(context).pop();
//                     },
//                     style: TextButton.styleFrom(
//                       backgroundColor: Color(0xFFFF9F1A),
//                       primary: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                     ),
//                     child: Text('Ekle'),
//                   ),
//                 ],
//               );
//             },
//           );
//         },
//         backgroundColor: Color(0xFFeb5a46),
//         child: Icon(Icons.add,color: Colors.white,),
//       ),
//       ),
//     );
//   }

//   Color _getStatusColor(String status) {
//     switch (status) {
//       case 'completed':
//         return Color(0xFF70b500);
//       case 'ongoing':
//         return Color(0xFFff9f1a);
//       case 'planned':
//         return Color(0xFFc377e0);
//       default:
//         return FlutterFlowTheme.of(context).accent1;
//     }
//   }
// }

@override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: () => _model.unfocusNode.canRequestFocus
        ? FocusScope.of(context).requestFocus(_model.unfocusNode)
        : FocusScope.of(context).unfocus(),
    child: Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: FlutterFlowTheme.of(context).secondaryText,
            size: 30,
          ),
          onPressed: () async {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginPageWidget()));
          },
        ),
        actions: [],
        centerTitle: true,
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
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
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
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
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
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 12, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                                      padding: EdgeInsetsDirectional.fromSTEB(
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
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 12, 0, 0),
                                      child: Container(
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
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
                                              style:
                                                  FlutterFlowTheme.of(context)
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
                                      print('Button pressed ...');
                                    },
                                    text: 'Görüntüle',
                                    options: FFButtonOptions(
                                      height: 40,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24, 0, 24, 0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 0),
                                      color: FlutterFlowTheme.of(context)
                                          .primary,
                                      textStyle: FlutterFlowTheme.of(context)
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
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 12, 0, 0),
                                    child: Container(
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(project.status)
                                            .withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(12),
                                        border: Border.all(
                                          color:
                                              _getStatusColor(project.status),
                                          width: 2,
                                        ),
                                      ),
                                      child: Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12, 0, 12, 0),
                                          child: Text(
                                            project.status,
                                            style:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          'Readex Pro',
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
                title: Text('Yeni Proje Ekle',
                style:FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Outfit',
                          letterSpacing: 0,
                        ),),
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(hintText: 'Proje İsmi',),
                      onChanged: (value) {
                        projectName = value;
                      },
                    ),
                    TextField(
                      controller: _dateController, // Use the controller here
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
                      _addProject(projectName, projectDate, projectStatus);
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
        child: Icon(Icons.add,color: Colors.white,),
      ),
    )
    );
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
