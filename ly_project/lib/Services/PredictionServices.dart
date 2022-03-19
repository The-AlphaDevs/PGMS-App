import 'dart:io';

import 'package:tflite/tflite.dart';

class PredictionServices {
  static Future<String> loadModel() async {
    String result = await Tflite.loadModel(
      model: "assets/BinaryClassifierModel.tflite",
      labels: "assets/labels.txt",
      useGpuDelegate: true,
      numThreads: 1,
    );
    return result;
  }

  static Future<List<dynamic>> classifyImage(File image) async {
    try {
      var output = await Tflite.runModelOnImage(
          path: image.path,
          imageMean: 0.0,
          imageStd: 255.0,
          numResults: 2,
          threshold: 0.2,
          asynch: true);
      return output;
    } catch (e) {
      print("Error in image classification.");
      return null;
    }
  }

  static Future<void> disposeModel() async {
    try {
      await Tflite.close();
    } catch (e) {
      print("Error while closing the model");
    }
  }
}
