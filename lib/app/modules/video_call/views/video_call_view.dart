import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter_webrtc_example/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/video_call_controller.dart';

class VideoCallView extends StatefulWidget {
  const VideoCallView({Key? key}) : super(key: key);

  @override
  State<VideoCallView> createState() => _VideoCallViewState();
}

final controller = Get.find<VideoCallController>();

class _VideoCallViewState extends State<VideoCallView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Row(
            children: [
              Expanded(child: Obx(() => RTCVideoView(controller.localRenderer.value, mirror: true,))),
              Expanded(child: Obx(() => RTCVideoView(controller.remoteRenderer.value)))
            ],
          ),
          Align( alignment: Alignment.bottomCenter, child: _callControllBar(context)),
          Align(alignment: Alignment.bottomLeft, child: _roomIdView(context))
        ],
      ),
    
    );
  }

  Widget _callControllBar(BuildContext context){
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width / 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color.fromARGB(196, 5, 5, 5)
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(onPressed: (){if (!controller.isLive.value) {
            controller.goLive();
          } else {Get.snackbar('Opps', 'You are already in live');}}, icon: Obx(() => Icon(Icons.group, color: controller.isLive.value? Colors.green : Colors.red,)), label: Obx(() => Text('Go Live', style:  TextStyle(fontFamily: 'Roboto', color: controller.isLive.value ? Colors.green : Colors.red),))),
          IconButton(onPressed: (){controller.signaling.openUserMedia(controller.localRenderer.value, controller.remoteRenderer.value); controller.isCameraEnabled.value = true;}, icon: Obx(() => Icon(Icons.camera_alt_rounded, color: controller.isCameraEnabled.value ? Colors.green : Colors.white,))),
          ElevatedButton(onPressed: (){controller.signaling.hangUp(controller.localRenderer.value).then((_) => Get.offAllNamed(Routes.HOME));}, style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)), child: const Icon(Icons.call_end, color: Colors.white,))
        ],
      ),
    );
  }

  Widget _roomIdView(BuildContext context){
    return Container(
              height: 50,
              width: MediaQuery.of(context).size.width / 4,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color.fromARGB(169, 0, 0, 0)
              ),
              child: Row(
                children: [
                  const Text('Room ID: ', style: TextStyle(fontFamily: 'Roboto', color: Colors.white, fontSize: 16),),
                  Expanded(child: Obx(() => TextField(controller: controller.roomIdController.value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800), decoration: const InputDecoration(border: InputBorder.none),)))
                ],
              ),
            );
  }
}
