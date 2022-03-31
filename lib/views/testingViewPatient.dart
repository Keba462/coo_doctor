 import 'package:flutter/material.dart';
 /*
 const String drycough=
 const String 
 const String 
 const String 
 const String 
 const String 
*/
class TestingViewPatient extends StatefulWidget {
  const TestingViewPatient({ Key? key }) : super(key: key);

  @override
  State<TestingViewPatient> createState() => _TestingViewPatientState();
}

class _TestingViewPatientState extends State<TestingViewPatient> {
  final GlobalKey<ScaffoldState>_scaffoldKey = GlobalKey<ScaffoldState>();
  bool _checked = false;
  @override
  Widget build(BuildContext context) {
    final columns =<Widget>[];
    columns.add(buildRowTitle(context,'Please select the symptoms that apply to you'));
    columns.add(buildSelectSymptomsRowWidget(context));
    columns.add(buildRowTitle(context,'Please select the underlying conditions that apply to you'));
    columns.add(buildSelectUnderlyingRowWidget(context));

    return Scaffold(
      
      key: _scaffoldKey,
      appBar:AppBar(
        centerTitle:true,
        title: Text('Test'),
        backgroundColor:Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children:columns
          ),
      ),
    );
  }
  Widget buildSelectUnderlyingRowWidget(BuildContext context){
    return Wrap(
      children:<Widget>[
       CheckboxListTile(
               title: Text('Heart Disease'),
            value:false,
             onChanged: (bool? value){
               setState(() {
                 _checked =value!;
               });
             }),
              CheckboxListTile(
               title: Text('Lung Disease'),
            value:false,
             onChanged: (bool? value){
               setState(() {
                 _checked =value!;
               });
             }),
              CheckboxListTile(
               title: Text('Kidney Disease'),
            value:false,
             onChanged: (bool? value){
               setState(() {
                 _checked =value!;
               });
             }),
              CheckboxListTile(
               title: Text('Diabetes'),
            value:false,
             onChanged: (bool? value){
               setState(() {
                 _checked =value!;
               });
             }),
              CheckboxListTile(
               title: Text('Stroke or Reduced immunity'),
            value:false,
             onChanged: (bool? value){
               setState(() {
                 _checked =value!;
               });
             }),
              CheckboxListTile(
               title: Text('High blood pressure'),
            value:false,
             onChanged: (bool? value){
               setState(() {
                 _checked =value!;
               });
             }),
              CheckboxListTile(
               title: Text(''),
            value:false,
             onChanged: (bool? value){
               setState(() {
                 _checked =value!;
               });
             }),
      ]
    );
  }
    Widget buildRowTitle(BuildContext context,String title){
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 10.0),
          child: Text(title,style: Theme.of(context).textTheme.headline1,
          ),
          ),
      );
    }

    Widget buildSelectSymptomsRowWidget(BuildContext context){
      return Wrap(
        children: <Widget>[
          CheckboxListTile(
            title: Text('Dry Cough'),
            value:false,
             onChanged: (bool? value){
               setState(() {
                 _checked =value!;
               });
             }),
             CheckboxListTile(
               title: Text('Sore Throat'),
            value:false,
             onChanged: (bool? value){
               setState(() {
                 _checked =value!;
               });
             }),
             CheckboxListTile(
               title: Text('Weakness'),
            value:false,
             onChanged: (bool? value){
               setState(() {
                 _checked =value!;
               });
             }),
             CheckboxListTile(
               title: Text('Breathing Problems'),
            value:false,
             onChanged: (bool? value){
               setState(() {
                 _checked =value!;
               });
             }),
             CheckboxListTile(
               title: Text('Drowsiness'),
            value:false,
             onChanged: (bool? value){
               setState(() {
                 _checked =value!;
               });
             }),
             CheckboxListTile(
               title: Text('Pain in the chest'),
            value:false,
             onChanged: (bool? value){
               setState(() {
                 _checked =value!;
               });
             }),
             CheckboxListTile(
               title: Text('Change in Appetite'),
            value:false,
             onChanged: (bool? value){
               setState(() {
                 _checked =value!;
               });
             }),
             CheckboxListTile(
               title: Text('Loss of sense of smell'),
            value:false,
             onChanged: (bool? value){
               setState(() {
                 _checked =value!;
               });
             }),
              CheckboxListTile(
               title: Text('Symptoms Progress'),
            value:false,
             onChanged: (bool? value){
               setState(() {
                 _checked =value!;
               });
             }),
              CheckboxListTile(
               title: Text('Travel history to affected country'),
            value:false,
             onChanged: (bool? value){
               setState(() {
                 _checked =value!;
               });
             }),
             
        ],
      );
    }
    
  
}