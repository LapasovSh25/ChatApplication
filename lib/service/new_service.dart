import 'dart:io';

import 'package:checkingfile/constants/project_urls.dart';
import 'package:checkingfile/model/new_model.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class NewService {
  static Box<NewModel>? userBox; // aniq ishlataman degani late
  static Future<dynamic> getNewService() async {
    await openBox();
    try {
      Response response =
          await Dio().get(ChatAppUrls.userUrl);
      if (response.statusCode == 200) {
        List<NewModel> resData =
            (response.data as List).map((e) => NewModel.fromJson(e)).toList();
        await putToBox(resData);
        return response.data;
      } else {
        return response.statusMessage;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  static openBox() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path); // appDocDir ni path iga papkasiga initial bo'l
    userBox = await Hive.openBox<NewModel>(
        "currency"); // currency degan box ochadi va shu yerga joylaydi.
  }

  static putToBox(List<NewModel> data) async {
    await userBox!.clear();
    for (NewModel element in data) {
      await userBox!.add(element);
    }
    print("Succesfully");
  }

  static void registerAdapters() {
    Hive.registerAdapter(NewModelAdapter());
    Hive.registerAdapter(AddressAdapter());
    Hive.registerAdapter(GeoAdapter());
    Hive.registerAdapter(CompanyAdapter());
  }
}
