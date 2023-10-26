import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'domain/models/post_preview.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Future<void> _incrementCounter() async{
    final dio = Dio(BaseOptions(
      baseUrl: 'https://dummyapi.io/data/v1/',
      headers: {
        'app-id': '652a57047041f526ae199423'
        },
    ),
    );

    dio.get('post').then((value) => log(value.toString()));
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        leading: Icon(Icons.add),
        title: Text('AppBar'),
        actions: [
          Icon(Icons.add_card_outlined),
          Icon(Icons.read_more),
          Icon(Icons.read_more),
          Icon(Icons.read_more),
        ],
      ),
      body: PostPreviewCard(
        postPreview: PostPreview(
          id: 'asds',
          text: 'asdasdasdasdasd',
          image: 'hasdjhahsdhjasd',
          likes: 3,
          tags: ['asdasd', 'asdasd'],
          publishDate: '11.11.11',
        ),
      ),
    );
  }
}

class PostPreviewCard extends StatelessWidget {
  final PostPreview postPreview;

  const PostPreviewCard({
    required this.postPreview,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('LastName'),
                      ],
                    ),
                  ),
                ],
              ),
              Icon(Icons.more_horiz),
            ],
          ),
        ),
      ], // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


