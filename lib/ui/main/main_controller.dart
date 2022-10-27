import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:git_get/base/base_controller.dart';
import 'package:git_get/data/model/post_model.dart';

class MainController extends BaseController {
  List<PostModel?>? listPost = [];

  @override
  void onInit() {
    super.onInit();
    getPosts();
  }

  void getPosts() async {
    EasyLoading.show(status: "Loading...");
    try {
      var response = await networkCore.dio.get("/posts");
      if(response.statusCode == 200) {
        EasyLoading.dismiss();
        // EasyLoading.showSuccess("Data berhasil diambil");
      }
      for (var element in (response.data as List)) {
        listPost?.add(PostModel.fromJson(element));
        update();
      }} on DioError catch(e) {
      EasyLoading.dismiss();
      // EasyLoading.showError("Data gagal diambil");
      print(e.error);
    }
  }
}