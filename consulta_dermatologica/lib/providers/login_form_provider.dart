import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String name='';
  String email='';
  bool seguro=false;
  String direccion='';
  String telefono='';
  String password='';
  String c_password='';


  // List<CiclesResponse> listCicles= [];

  bool _isLoading = false;
  bool get isLoading =>_isLoading;
  
  set isLoading( bool value) {
    _isLoading=value;
    notifyListeners();
  }


  bool isValidForm() {
    
    return formKey.currentState?.validate() ?? false;
  }
}