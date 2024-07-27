
import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'login_page_widget.dart' show LoginPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// class LoginPageModel extends FlutterFlowModel<LoginPageWidget> {
//   ///  State fields for stateful widgets in this page.

//   final unfocusNode = FocusNode();
//   FocusNode? textFieldFocusNode1;
//   TextEditingController? textController1;
//   String? Function(BuildContext, String?)? textController1Validator;
//   // State field(s) for TextField widget.
//   FocusNode? textFieldFocusNode2;
//   TextEditingController? textController2;
//   late bool passwordVisibility;
//   String? Function(BuildContext, String?)? textController2Validator;

//   @override
//   void initState(BuildContext context) {
//     passwordVisibility = false;
//   }

//   @override
//   void dispose() {
//     unfocusNode.dispose();
//     textFieldFocusNode1?.dispose();
//     textController1?.dispose();

//     textFieldFocusNode2?.dispose();
//     textController2?.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPageModel extends ChangeNotifier {
  ///  State fields for stateful widgets in this page.
  final unfocusNode = FocusNode();
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? textController2Validator;

  @override
  void initState() {
    passwordVisibility = false;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();
    textFieldFocusNode2?.dispose();
    textController2?.dispose();
    super.dispose();
  }
}


