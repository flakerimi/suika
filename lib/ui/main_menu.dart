import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suika/ui/game.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Suika',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => Get.to(() => const Game()),
                child: const Text('Start'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
