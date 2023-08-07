import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Flutter Meet')),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        'Wellcome to Flutter Meet!',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 48,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                  Expanded(
                      flex: 4,
                      child: Image(
                          image: AssetImage(
                              'flutter_meet_landing_page_asset.png')))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      height: 60,
                      width: 300,
                      child: Obx(() => OutlinedButton(
                          onPressed: () => controller.createRoom(),
                          onHover: (value) =>
                              controller.isCreateButtonHover.value = value,
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  controller.isCreateButtonHover.value
                                      ? Colors.pink.shade900
                                      : null),
                              side: MaterialStatePropertyAll(
                                  BorderSide(color: Colors.pink.shade900))),
                          child: const Text(
                            'Create an instant room',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )))),
                  SizedBox(
                      height: 60,
                      width: 300,
                      child: Obx(() => OutlinedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                barrierColor: const Color.fromARGB(157, 0, 0, 0),
                                builder: (context) {
                                  return _showJoinRoomDialog(context);
                                });
                          },
                          onHover: (value) =>
                              controller.isJoinButtonHover.value = value,
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  controller.isJoinButtonHover.value
                                      ? Colors.pink.shade900
                                      : null),
                              side: MaterialStatePropertyAll(
                                  BorderSide(color: Colors.pink.shade900))),
                          child: const Text(
                            'Join an meeting',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ))))
                ],
              )
            ],
          ),
        ));
  }

  Widget _showJoinRoomDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      title: const Text(
        'Join A Room',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 18),
      ),
      content: TextField(
        controller: controller.roomIdController,
        style: const TextStyle(
          color: Colors.white,
                  fontSize: 14
        ),
        decoration: InputDecoration(
          
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.pink.shade900)),
            prefix: const Text(
              'Room ID: ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700),
            )),
      ),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: const ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Color.fromARGB(255, 36, 36, 36))),
            child: const Text(
              'Cancel',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
        ElevatedButton(
            onPressed: () => controller.joinRoom(),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Colors.pink.shade900)),
            child: const Text(
              'Join',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ))
      ],
    );
  }
}
