import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:one/res/constant/AppLinks.dart';

import '../../../core/cache_helper.dart';

part 'design_state.dart';

class DesignCubit extends Cubit<DesignState> {
  DesignCubit() : super(DesignInitial());
//init val
  late int slectedModel = 0;
  String selectedImgModel = '';
  final ImagePicker picker = ImagePicker();
  late File file;
  bool imageLoading = true;
  late XFile? xfile;
  double containerWidth = 200.0; // العرض الابتدائي
  double containerHeight = 200.0; // الطول الابتدائي

  double leftpos = 150.0;
  double toptpos = 60.0;
  double leftposDes = 60.0;
  double toptposDes = 90.0;
  int pageSelceted = 0;
  Color pickerColor = Colors.blue;
  List<dynamic> result = [];
  List<dynamic> resultimg = [];
  int selectedResult = 0;
  //controller text
  TextEditingController name = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController material = TextEditingController();
  TextEditingController sizes = TextEditingController();
  TextEditingController colors = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController desc = TextEditingController();

  // init func
  onChangeHeightWidth(double height, double width) {
    containerHeight = height;
    containerWidth = width;
    emit(DesignInitialSuccesDesign());
  }

  onChangePage(int val) {
    pageSelceted = val;
    emit(DesignInitialSuccesDesign());
  }

  onSelected(int val, String modelIMG) {
    slectedModel = val;
    selectedImgModel = modelIMG;
    emit(DesignModelSelected(val));
  }

  void changeColor(Color color) {
    pickerColor = color;
    print(color);
    emit(DesignInitialSuccesDesign());
  }

  onchangeSelectedSVG(int val) {
    selectedResult = val;
    emit(DesignInitialSuccesDesign());
  }

  onOPen(int val) {
    emit(DesignModelSelected(val));
  }

  saveData() {
    emit(DesignModelSelectedEdit(name.text));
  }

  removeFile() {
    if (file.existsSync()) {
      try {
        file.deleteSync();
        print('File deleted successfully');
        emit(DesignInitialSuccesDesign());
      } catch (e) {
        print('Error deleting file: $e');
      }
    } else {
      print('File does not exist or is already deleted');
    }
    emit(DesignInitialSuccesDesign());
  }

  onSelectImg() async {
    try {
      XFile? xfile = await picker.pickImage(source: ImageSource.camera);
      if (xfile != null) {
        file = File(xfile.path);
        imageLoading = false;
        emit(DesignInitialSuccesDesign());
      } else {
        print('image not selected');
      }
    } catch (e) {
      print(e);
    }
  }

  movephoto(double left, double top) {
    leftpos = left;
    toptpos = top;
    emit(DesignInitialSuccesDesign());
  }

  movephotoDes(double left, double top) {
    leftposDes = left;
    toptposDes = top;
    emit(DesignInitialSuccesDesign());
  }

  List<Color> colorslist = [
    Colors.black,
    Colors.red,
    Colors.blue.shade400,
    Color(0xff708090),
  ];
  int selectedColor = 0;
  onchangeSelectedColor(int val) {
    selectedColor = val;
    emit(DesignInitialSuccesDesign());
  }

  var headers = {'Authorization': CacheHelper.getToken()};
  getSVGView() async {
    result.clear();
    resultimg.clear();
    const String _userUrl = AppLinks.productDesign;
    emit(DesignInitialLoaing());
    try {
      Response response = await get(Uri.parse(_userUrl), headers: headers);
      result = jsonDecode(response.body)['data'];

      loopForGetImagesSVG();
      emit(DesignInitialSuccess());
    } catch (e) {
      emit(DesignInitialError());

      print(e);
    }
  }

  loopForGetImagesSVG() {
    if (result.isNotEmpty) {
      resultimg.addAll(result.map((item) {
        var img = item['img'];
        if (img is String) {
          return img;
        } else {
          print('Unexpected data format for "img" field');
          return ''; // or handle it differently based on your requirements
        }
      }));
    }
  }

  sendPrint(igmid) async {
    const String _userUrl = AppLinks.addDesign;

    try {
      var request = MultipartRequest('POST', Uri.parse(_userUrl));

      // Add parameters
      request.headers.addAll(headers);

      request.fields['desigmid'] = igmid;
      request.fields['color'] = pickerColor.toString();

      // Add file
      request.files.add(await MultipartFile.fromPath('file', file.path));

      // Send request
      var streamedResponse = await request.send();
      var response = await Response.fromStream(streamedResponse);
      var responseData = jsonDecode(response.body);
      print(responseData);
    } catch (e) {
      // emit(DesignInitialError());
      print(e);
    }
  }
}
