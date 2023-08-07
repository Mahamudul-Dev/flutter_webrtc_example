import 'package:flutter_webrtc_example/app/modules/video_call/controllers/video_call_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

    Get.lazyPut<VideoCallController>(
      () => VideoCallController(),
    );
  }
}
