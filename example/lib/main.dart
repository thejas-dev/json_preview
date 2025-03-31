import 'package:flutter/material.dart';
import 'package:json_preview/json_preview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSON Viewer Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample JSON data
    final sampleJson = {
      'name': 'John Doe',
      'age': 30,
      'isActive': true,
      'address': {
        'street': '123 Main St',
        'city': 'New York',
        'coordinates': [40.7128, -74.0060]
      },
      'tags': ['developer', 'flutter'],
      'projects': [
        {
          'name': 'Project A',
          'isCompleted': true,
          'tasks': [
            {'title': 'Task 1', 'done': true},
            {'title': 'Task 2', 'done': false}
          ]
        },
        {'name': 'Project B', 'isCompleted': false, 'tasks': []}
      ],
      'nullValue': null
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('JSON Viewer Example'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sample JSON Data',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              JsonPreview(jsonData: sampleJson),
            ],
          ),
        ),
      ),
    );
  }
}
