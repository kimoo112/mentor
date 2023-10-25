import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentor/WebServices/web_services.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          ElevatedButton(
            child: const Text('Go Back'),
            onPressed: () {
              context.pop();
            },
          ),
         
         
        ],
      ),
    ));
  }
}
