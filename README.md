# Flutter JSON Viewer

A lightweight and highly customizable Flutter widget for displaying JSON data in a collapsible tree view.

![JSON Viewer Example](https://ik.imagekit.io/d3kzbpbila/thejashari_7b-oV6LYY)

## Features

- Display JSON data in a hierarchical, collapsible tree view
- Extensive styling options for all JSON elements
- Color-coded highlighting based on data types
- Automatic expansion of top-level nodes
- Support for all JSON data types (objects, arrays, strings, numbers, booleans, null)
- Customizable icons and text styles

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_json_viewer: ^0.1.0
```

## Usage

```dart
import 'package:flutter_json_viewer/flutter_json_viewer.dart';

// Sample JSON data
final Map<String, dynamic> jsonData = {
  'name': 'John Doe',
  'age': 30,
  'isActive': true,
  'address': {
    'street': '123 Main St',
    'city': 'New York',
    'coordinates': [40.7128, -74.0060]
  },
  'tags': ['developer', 'flutter']
};

// In your widget tree
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('JSON Viewer Example')),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: JsonPreview(jsonData: jsonData),
      ),
    ),
  );
}
```

## Customization

The `JsonPreview` widget accepts the following parameters:

### Required Parameters

- `jsonData` (required): The JSON data to display

### Optional Parameters

#### Structure Parameters
- `depth`: The current nesting level (defaults to 0)
- `parentKey`: The key of the parent node (if any)
- `fallbackValueText`: Text to display for unsupported or unexpected data types

#### Icon Customization
- `expandedArrowIcon`: The icon to show when a node is expanded (default: Icons.arrow_drop_down)
- `collapsedArrowIcon`: The icon to show when a node is collapsed (default: Icons.arrow_right)
- `arrowIconColor`: Color for the collapse/expand arrow icons

#### Text Style Customization
- `itemsTextStyle`: Style for item count text (e.g., "2 items")
- `keyStyle`: Style for object keys
- `arrayKeyStyle`: Style for array indices
- `emptySquareBraceStyle`: Style for empty arrays ("[]")
- `emptyBracketStyle`: Style for empty objects ("{}")

#### Value Color Customization
- `stringValueColor`: Color for string values (default: green)
- `numValueColor`: Color for number values (default: blue)
- `boolValueColor`: Color for boolean values (default: purple)
- `nullValueColor`: Color for null values (default: gray)
- `defaultValueColor`: Default color for other value types

## Complete Example with Customization

```dart
import 'package:flutter/material.dart';
import 'package:flutter_json_viewer/flutter_json_viewer.dart';

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
                'Custom Styled JSON Data',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Custom styled JSON viewer
              JsonPreview(
                jsonData: sampleJson,
                arrowIconColor: Colors.deepPurple,
                itemsTextStyle: TextStyle(
                  color: Colors.deepPurple.shade300,
                  fontStyle: FontStyle.italic,
                ),
                keyStyle: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.w700,
                ),
                arrayKeyStyle: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.w600,
                ),
                stringValueColor: Colors.green.shade800,
                numValueColor: Colors.blue.shade800,
                boolValueColor: Colors.amber.shade900,
                nullValueColor: Colors.grey.shade500,
                expandedArrowIcon: Icons.keyboard_arrow_down,
                collapsedArrowIcon: Icons.keyboard_arrow_right,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Dark Mode Example

```dart
JsonPreview(
  jsonData: sampleJson,
  arrowIconColor: Colors.lightBlueAccent,
  itemsTextStyle: TextStyle(
    color: Colors.grey.shade300,
    fontStyle: FontStyle.italic,
  ),
  keyStyle: TextStyle(
    color: Colors.pinkAccent,
    fontWeight: FontWeight.w700,
  ),
  arrayKeyStyle: TextStyle(
    color: Colors.cyanAccent,
    fontWeight: FontWeight.w600,
  ),
  emptySquareBraceStyle: TextStyle(color: Colors.grey.shade400),
  emptyBracketStyle: TextStyle(color: Colors.grey.shade400),
  stringValueColor: Colors.lightGreenAccent,
  numValueColor: Colors.lightBlue,
  boolValueColor: Colors.purpleAccent,
  nullValueColor: Colors.grey,
  defaultValueColor: Colors.white,
),
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.