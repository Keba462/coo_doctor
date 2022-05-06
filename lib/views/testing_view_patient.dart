import 'dart:io';

import 'package:coo_doctor/utils/symptoms.dart';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const kModelName = "Covid-Diagnoser";

class TestingViewPatient extends StatefulWidget {
  const TestingViewPatient({Key? key}) : super(key: key);

  @override
  State<TestingViewPatient> createState() => _TestingViewPatientState();
}

class _TestingViewPatientState extends State<TestingViewPatient> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseCustomModel? model;

   Future<String>?_loaded;
  final TextEditingController _age = TextEditingController();
  final TextEditingController _temp = TextEditingController();

  final fields = [
    DatasetFields(title: 'Diabetes'),
    DatasetFields(title: 'Heart disease'),
    DatasetFields(title: 'Lung disease'),
    DatasetFields(title: 'Stroke or reduced immunity'),
    DatasetFields(title: 'High blood pressure'),
    DatasetFields(title: 'Kidney disease'),
  ];
  List<DatasetFields> selectedSymptoms = [];
  final symptoms = [
    DatasetFields(title: 'Dry Cough'),
    DatasetFields(title: 'Sore Throat'),
    DatasetFields(title: 'Weakness'),
    DatasetFields(title: 'Breathing Problems'),
    DatasetFields(title: 'Drowsiness'),
    DatasetFields(title: 'Pain in the chest'),
    DatasetFields(title: 'Travel History to afftected Country'),
    DatasetFields(title: 'Symptoms Progress'),
  ];
  List<DatasetFields> selectedFieldItems = [];
  List symtomsList =<bool> [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTextStyle(
        style: const TextStyle(color: Colors.purple),
        textAlign: TextAlign.center,
        child: FutureBuilder<String>(
            future: _loaded,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return readyScreen();
              } else if (snapshot.hasError) {
                return errorScreen();
              } else {
                return loadingScreen();
              }
            }),
      ),
    );
  }

  Widget buildCheckbox({
    required DatasetFields field,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        onTap: onClicked,
        leading: Checkbox(
          value: field.value,
          onChanged: (value) => onClicked(),
        ),
        title: Text(field.title),
      );

  Widget buildInputDetails(BuildContext context) {
    return Column(children: <Widget>[
      TextFormField(
        controller: _age,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]{2}')),
        ],
        decoration: InputDecoration(
          labelText: 'Age',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      const SizedBox(
        height: 10.0,
      ),
      
      TextFormField(
        controller: _temp,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]{4}')),
        ],
        decoration: InputDecoration(
          labelText: 'Your Temprature',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      const SizedBox(
        height: 20.0,
      ),
    ]);
  }

  Widget buildRowTitle(BuildContext context, String title) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child: Text(title, style: Theme.of(context).textTheme.headline5),
      ),
    );
  }

  Widget buildSelectSymptomsRowWidget(BuildContext context) {
    return Wrap(
      children: <Widget>[
        ...symptoms.map(buildSingleCheckboxFields).toList(),
      ],
    );
  }

  Widget buildSelectUnderlyingRowWidget(BuildContext context) {
    return Wrap(children: [
      ...fields.map(buildSingleCheckboxSymptoms).toList(),
    ]);
  }

  Widget buildSingleCheckboxFields(DatasetFields field) {
    return buildCheckbox(
      field: field,
      onClicked: () {
        setState(() {
          //symtomsList.add(field.value);
          final newValue = !field.value;
          field.value = newValue;
          if(field.value == true){
            selectedFieldItems.add(field);
          }else{
            selectedFieldItems.remove(field);
          }

        });
      },
    );
  }

  Widget buildSingleCheckboxSymptoms(DatasetFields field) {
    return buildCheckbox(
      field: field,
      onClicked: () {
        setState(() {
          final newValue = !field.value;
          field.value = newValue;
          //symtomsList.add(field.value);
          if(field.value == true){
            selectedSymptoms.add(field);
          }else{
            selectedSymptoms.remove(field);
          }


        });
      },
    );
  }

  Widget buildSubmitButton(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: () {

            
            symtomsList =[];
            if (kDebugMode) {
           for (var symptom in symptoms) {
                 symtomsList.add(symptom.value);
                  print("Selected Symptoms: ${symptom.value}");
                
              }
              for (var field in fields) {
                symtomsList.add(field.value);
                  print("Selected Fields: ${field.title}");
                
              }
            
            }
            createFeatureList();
          },
          child: const Text('submit'),
          style: ElevatedButton.styleFrom(
              primary: Colors.purple,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
              minimumSize: const Size(200, 50)),
        ),
      ],
    );
  }

  Widget errorScreen() {
    return const Scaffold(
      body: Center(
        child: Text('Error Loading model.Please check logs'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initWithLocalModel();
  }

  /// Initially get the local model if found, and asynchronously get the latest one in background.
  initWithLocalModel() async {
    final _model = await FirebaseModelDownloader.instance.getModel(
        kModelName, FirebaseModelDownloadType.localModelUpdateInBackground);
    _loaded = loadModel();

    setState(() {
      model = _model;
    });
  }

  Widget loadingScreen() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: CircularProgressIndicator(),
            ),
            Text('Please make sure that you are using wifi'),
          ],
        ),
      ),
    );
  }

  Future<String> loadModel() async {
    final modelFile = await loadModelFromFirebase();
    return loadTFLiteModel(modelFile!);
  }

  /// Downloads custom model from the Firebase console and return its file.
  /// located on the mobile device.
  Future<File?> loadModelFromFirebase() async {
    try {
      // Create model with a name that is specified in the Firebase console
      final _model = await FirebaseModelDownloader.instance
          .getModel(kModelName, FirebaseModelDownloadType.latestModel);

      setState(() {
        model = _model;
      });

      // Get latest model file to use it for inference by the interpreter.
      var modelFile = model?.file.absolute;
      assert(modelFile != null);
      return modelFile;
    } catch (exception) {
      if (kDebugMode) {
        print('Failed on loading your model from Firebase: $exception');
      }
      if (kDebugMode) {
        print('The program will not be resumed');
      }
      rethrow;
    }
  }

  Widget readyScreen() {
    final columns = <Widget>[];
    columns.add(
        buildRowTitle(context, 'Fill in the needed details for your test'));
    columns.add(buildInputDetails(context));
    columns.add(
        buildRowTitle(context, 'Please select the symptoms that apply to you'));
    columns.add(buildSelectSymptomsRowWidget(context));
    columns.add(buildRowTitle(
        context, 'Please select the underlying conditions that apply to you'));
    columns.add(buildSelectUnderlyingRowWidget(context));
    columns.add(buildSubmitButton(context));

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Test'),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: columns,
        ),
      ),
    );
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
      if (kDebugMode) {
        print(
          'Failed on loading your model to the TFLite interpreter: $exception');
      }
      if (kDebugMode) {
        print('The program will not be resumed');
      }
      rethrow;
    }
  }


  void _showDiagnosisDialog(String result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("Your Diagnosis"),
          content: setupAlertDialogContainer(result),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(primary: Colors.purple),
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void createFeatureList(){
    List features =<double>[];
    List symptoms =<bool>[];
    String result= "";
    String result1 = "Low Risk";
    String result2= "Moderate Risk";
    String result3 = "High Risk";
    double age= double.parse(_age.text);
    double temp= double.parse(_temp.text);
    features.add(age);
    features.add(temp);
    print("list:$symtomsList");
    for(var list in symtomsList) {
      if(list == true){
        //list = 1.0;
        features.add(1.0);
      }else if(list == false){
       // list=0.0;
        features.add(0.0);
      }
      //features.add(list);
      print("feautures:, ${features}");

    }

    print("Evalluation");
    if(features[6] <= 0.50){
          if(features[11] <= 0.50){
            if(features[7] <= 0.50){
              if(features[8] <= 0.50){
                if(features[3] <= 0.50){
                  result =result1;
                  print("result:$result");
                }
                else{
                  result =result1;
                  print("result:$result");
                }
              }else{
                if(features[1] <= 37.58){
                  result =result2;
                  print("result:$result");
                }else{
                  result =result1;
                  print("result:$result");
                }
              }
            }else{
              if(features[13] <= 0.50){
                result =result2;
                  print("result:$result");
                }else{
                  result =result1;
                  print("result:$result");
                }
            }
          }else{
            if(features[14] <= 0.50){
              if(features[3] <= 0.50){
                result =result2;
                  print("result:$result");
                }else{
                  if(features[15] <= 0.50){
                    result =result1;
                  print("result:$result");
                  }else{
                    result =result3;
                    print("result:$result");
                  }
                }
            }else if(features[14] > 0.50){
              result =result3;
                print("result:$result");
                }
          }
      }else{
         if(features[7] <= 0.50){
           if(features[1] <= 39.25){
             if(features[0] <= 32.00){
               result =result2;
                print("result:$result");
             } else{
               if(features[0] <= 37.00){
                 result =result1;
                  print("result:$result");
               }else{
                 result =result2;
                  print("result:$result");
               }
             }
           }else{
             if(features[0] <= 41.00){
               result =result2;
                  print("result:$result");
               }else{
                 result =result3;
                  print("result:$result");
               }
           }
         }else{
             if(features[5] <= 0.50){
               if(features[0] <= 37.50){
                 result =result1;
                  print("result:$result2");
               }else{
                  if(features[10] <= 0.50){
                    result =result1;
                  print("result:$result2");
               }else{
                 result =result1;
                  print("result:$result3");
               }}
               }else{
                  if(features[9] <= 0.50){
                     if(features[13] <= 0.5){
                       result =result1;
                    print("result:$result3");
                  } else{
                    result =result2;
                    print("result:$result2");
                  }
                  }else{
                    result =result3;
                     print("result:$result");
                  }
               }
           }
      }
    _showSymptomsDialog(result);
  }

  void _showSymptomsDialog(String result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("Your  Diagnosis"),
          content: setupAlertDialogContainer(result),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(primary: Colors.purple),
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                return _showDiagnosis(result);
              },
            ),
          ],
        );
      },
    );
  }

  Widget setupAlertDialogContainer(String result) {
    return SizedBox(
      height: 300.0,
      width: 300.0,
      child: Column(

        children: [
          const Text('Your Underlying conditions are:',style: TextStyle(fontWeight: FontWeight.bold),),
          Expanded(
            child: ListView.builder(
              itemCount: selectedSymptoms.length,
              itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(selectedSymptoms[index].title),
                  );

              },
              shrinkWrap: true,
            ),
          ),
          //const SizedBox(height: 2.0,),
          const Text('Your Symptoms are:',style: TextStyle(fontWeight: FontWeight.bold),),
          ListView.builder(
            itemCount: selectedFieldItems.length,
            itemBuilder: (context, index) {
                return ListTile(
                  title: Text(selectedFieldItems[index].title),
                );

            },
            shrinkWrap: true,
          ),
        ],
      ),
    );
  }

  void _showDiagnosis(String result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("Your  Diagnosis"),
          content: Text("Your Diagnosis is: $result"),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(primary: Colors.purple),
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  }


