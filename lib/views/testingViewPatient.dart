import 'dart:io';

import 'package:flutter/material.dart';
import 'package:coo_doctor/utils/symtoms.dart';
import 'package:firebase_ml_custom/firebase_ml_custom.dart';
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
  Future<String> _loaded =loadModel();
   int? _age;
  double?_temp;
  final fields =[
    DatasetFields(title: 'Heart disease'),
    DatasetFields(title: 'Kidney disease'),
    DatasetFields(title: 'High blood pressure'),
    DatasetFields(title: 'Lung disease'),
    DatasetFields(title: 'Diabetes'),
    DatasetFields(title: 'Stroke or reduced immunity'),
  ];
   final symptoms =[
    DatasetFields(title: 'Dry Cough'),
    DatasetFields(title: 'Sore Throat'),
    DatasetFields(title: 'Pain in the chest'),
    DatasetFields(title: 'Breathing Problems'),
    DatasetFields(title: 'Loss of sense of smell'),
    DatasetFields(title: 'Weakness'),
    DatasetFields(title: 'Drowsiness'),
    DatasetFields(title: 'Change in apetite'),
    DatasetFields(title: 'Symptoms Progress'),
    DatasetFields(title: 'Travel History to afftected Country'),
  ];
  static Future<String> loadModel() async {
    final modelFile = await loadModelFromFirebase();
    return loadTFLiteModel(modelFile);
  }

  /// Downloads custom model from the Firebase console and return its file.
  /// located on the mobile device.
  static Future<File> loadModelFromFirebase() async {
    try {
      // Create model with a name that is specified in the Firebase console
      final model = FirebaseCustomRemoteModel('Covid-Diagnoser');

      // Specify conditions when the model can be downloaded.
      // If there is no wifi access when the app is started,
      // this app will continue loading until the conditions are satisfied.
      final conditions = FirebaseModelDownloadConditions(
          androidRequireWifi: true, iosAllowCellularAccess: false);

      // Create model manager associated with default Firebase App instance.
      final modelManager = FirebaseModelManager.instance;

      // Begin downloading and wait until the model is downloaded successfully.
      await modelManager.download(model, conditions);
      assert(await modelManager.isModelDownloaded(model) == true);

      // Get latest model file to use it for inference by the interpreter.
      var modelFile = await modelManager.getLatestModelFile(model);
      assert(modelFile != null);
      return modelFile;
    } catch (exception) {
      print('Failed on loading your model from Firebase: $exception');
      print('The program will not be resumed');
      rethrow;
    }
  }

  /// Loads the model into some TF Lite interpreter.
  /// In this case interpreter provided by tflite plugin.
  static Future<String> loadTFLiteModel(File modelFile) async {
    try {
      // TODO TFLite plugin is broken, see https://github.com/shaqian/flutter_tflite/issues/139#issuecomment-836596852
      // final appDirectory = await getApplicationDocumentsDirectory();
      // final labelsData =
      //     await rootBundle.load('assets/labels_mobilenet_v1_224.txt');
      // final labelsFile =
      //     await File('${appDirectory.path}/_labels_mobilenet_v1_224.txt')
      //         .writeAsBytes(labelsData.buffer.asUint8List(
      //             labelsData.offsetInBytes, labelsData.lengthInBytes));
      // assert(await Tflite.loadModel(
      //       model: modelFile.path,
      //       labels: labelsFile.path,
      //       isAsset: false,
      //     ) ==
      //     'success');
      return 'Model is loaded';
    } catch (exception) {
      print(
          'Failed on loading your model to the TFLite interpreter: $exception');
      print('The program will not be resumed');
      rethrow;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:DefaultTextStyle(
      style: TextStyle(color:Colors.purple),
      textAlign: TextAlign.center,
      child:FutureBuilder<String>(
        future:_loaded,
        builder:(BuildContext context,AsyncSnapshot<String>snapshot){
          if(snapshot.hasData){
            return readyScreen();
          }else if (snapshot.hasError){
            return errorScreen();
          }else{
            return loadingScreen();
          }
        }

      ),
      ),

    );

  }


  Widget errorScreen() {
    return Scaffold(
      body:Center(
        child:Text('Error Loading model.Please check logs'),
      ),
    );
  }

  Widget loadingScreen() {
    return Scaffold (
      body:Center(
        child:Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children:<Widget>[
            Padding(
              padding:EdgeInsets.only(bottom:20),
              child:CircularProgressIndicator(),
            ),
            Text('Please make sure that you are using wifi'),
          ],
        ),
      ),
    );
  }
  Widget readyScreen() {
    final columns =<Widget>[];
    columns.add(buildRowTitle(context,'Fill in the needed details for your test'));
    columns.add(buildInputDetails(context));
    columns.add(buildRowTitle(context,'Please select the symptoms that apply to you'));
    columns.add(buildSelectSymptomsRowWidget(context));
    columns.add(buildRowTitle(context,'Please select the underlying conditions that apply to you'));
    columns.add(buildSelectUnderlyingRowWidget(context));
    columns.add(buildSubmitButton(context));

 
    return Scaffold(
      
      key: _scaffoldKey,
      appBar:AppBar(
        centerTitle:true,
        title: Text('Test'),
        backgroundColor:Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Column(
               children: columns,            
             ),
          
        ),
        
    );
  }
  Widget buildSubmitButton(BuildContext context){
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed:(){},
             child: const Text('submit'),
             style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
              minimumSize: Size(200, 50)
            
                       ),
            ),

      ],
    );
  }
  Widget buildInputDetails(BuildContext context){
    return  Column(
          children:<Widget>[
              TextFormField(
             validator:(input) {
               if(input == ""){
                 return 'please type in your age';
               }
             },
             onSaved:(input) => _age = input! as int?,
             decoration: InputDecoration(
               labelText: 'Age',
               border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),),
             ),
            
           ),
           SizedBox(
             height: 10.0,
           ),
           TextFormField(
             validator:(input) {
               if(input == ""){
                 return 'please type in your temperature';
               }
             },
             onSaved:(input) => _temp = input! as double,
             onChanged: (value){
               _calculate();
             },
             decoration: InputDecoration(
               labelText: 'Your Temprature',
               border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),),
             ),
            
           ),
           SizedBox(
             height: 20.0,
           ),
          ]
    );
  }

  Widget buildSingleCheckbox(DatasetFields field) =>
    buildCheckbox(
      field:field,
      onClicked:(){
        setState((){
          final newValue =!field.value;
          field.value =newValue;
        });
      },
    );

  
    Widget buildCheckbox({
      required DatasetFields field,
      required VoidCallback onClicked,
    }) => ListTile (
      onTap:onClicked,
      leading:Checkbox(
        value:field.value,
        onChanged:(value)=>onClicked(),
      ),
    title:Text(field.title),
    );

  Widget buildSelectUnderlyingRowWidget(BuildContext context){
    return Wrap(
      children:[
        ...fields.map(buildSingleCheckbox).toList(),
      ]
    );
  }
    Widget buildRowTitle(BuildContext context,String title){
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 10.0),
          child: Text(title,style: Theme.of(context).textTheme.headline5
          ),
          ),
      );
    }

    Widget buildSelectSymptomsRowWidget(BuildContext context){
      return Wrap(
        children: <Widget>[
          ... symptoms.map(buildSingleCheckbox).toList(),
          
        ],
      );
    }
    double _calculate(){
      return (_temp! * 1.8) + 32;
      }
    
    
  
}