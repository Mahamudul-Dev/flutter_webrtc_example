import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter_webrtc_example/app/modules/video_call/controllers/signaling.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class VideoCallController extends GetxController {

  RxBool isCameraEnabled = false.obs;
  RxBool isLive = false.obs;
  
  Signaling signaling = Signaling();
  Rx<RTCVideoRenderer> localRenderer = RTCVideoRenderer().obs;
  Rx<RTCVideoRenderer> remoteRenderer = RTCVideoRenderer().obs;
  Rx<TextEditingController> roomIdController= TextEditingController().obs;

  @override
  void onInit() async {
    localRenderer.value.initialize();
    remoteRenderer.value.initialize();

    signaling.onAddRemoteStream = ((stream) {
      remoteRenderer.value.srcObject = stream;
    });
    await signaling.openUserMedia(localRenderer.value, remoteRenderer.value).then((value) => isCameraEnabled.value = true);
    super.onInit();
  }



  @override
  void dispose() {
    localRenderer.value.dispose();
    remoteRenderer.value.dispose();
    super.dispose();
  }

  void goLive(){
    try {
      signaling.createRoom(remoteRenderer.value).then((roomId) => roomIdController.value.text = roomId);
      isLive.value = true;
      update();
    } catch (e) {
      Logger().e(e);
    }
  }

}
