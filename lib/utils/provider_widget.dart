import 'dart:html';

import 'package:coo_doctor/services/auth_services.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget{
  final AuthService auth;
  const Provider({Key? key,required Widget child,required this.auth}):super(key: key,child: child);
  @override
  bool updateShouldNotify(InheritedWidget oldWidget){
    return true;
  }

  static Provider of(BuildContext context)=>
  (context.dependOnInheritedWidgetOfExactType(aspect: Provider) as Provider);
}