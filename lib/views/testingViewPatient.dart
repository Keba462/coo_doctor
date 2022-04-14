import 'dart:io';

import 'package:coo_doctor/utils/symtoms.dart';
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

  late Future<String> _loaded;
  int? _age;
  double? _temp;
  final fields = [
    DatasetFields(title: 'Heart disease'),
    DatasetFields(title: 'Kidney disease'),
    DatasetFields(title: 'High blood pressure'),
    DatasetFields(title: 'Lung disease'),
    DatasetFields(title: 'Diabetes'),
    DatasetFields(title: 'Stroke or reduced immunity'),
  ];
  final symptoms = [
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
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]{1,3}')),
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
      /*
      TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]{1,3}')),
        ],
        decoration: InputDecoration(
          labelText: 'Your Temperature',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      */
      TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]{1,3}')),
        ],
        /*
        onChanged: (value) {
          _calculate();
        },*/
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
        ...symptoms.map(buildSingleCheckbox).toList(),
      ],
    );
  }

  Widget buildSelectUnderlyingRowWidget(BuildContext context) {
    return Wrap(children: [
      ...fields.map(buildSingleCheckbox).toList(),
    ]);
  }

  Widget buildSingleCheckbox(DatasetFields field) => buildCheckbox(
        field: field,
        onClicked: () {
          setState(() {
            final newValue = !field.value;
            field.value = newValue;
          });
        },
      );

  Widget buildSubmitButton(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: () {},
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

  double _calculate() {
    return (_temp! * 1.8) + 32;
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
}
