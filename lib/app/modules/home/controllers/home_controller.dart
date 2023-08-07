import 'package:flutter/material.dart';
import 'package:flutter_webrtc_example/app/modules/video_call/controllers/video_call_controller.dart';
import 'package:flutter_webrtc_example/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isJoinButtonHover = false.obs;
  RxBool isCreateButtonHover = false.obs;

  TextEditingController roomIdController = TextEditingController();


  void createRoom () {
    Get.offAllNamed(Routes.VIDEO_CALL);
  }

  void joinRoom (){
    if(roomIdController.text == '' || roomIdController.text.isEmpty){
      Get.snackbar('Sorry', 'Please enter the room Id');
      return;
    } else {
      Get.find<VideoCallController>().signaling.joinRoom(roomIdController.text, Get.find<VideoCallController>().remoteRenderer.value);
      Get.find<VideoCallController>().isLive.value = true;
      Get.offAllNamed(Routes.VIDEO_CALL);
    }
  }
}
