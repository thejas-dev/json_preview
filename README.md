# Flutter JSON Preview

A customizable Flutter widget for displaying JSON data in a collapsible tree view.

## Features

- Display JSON data in a hierarchical, collapsible tree view
- Color-coded highlighting based on data types (Customizable)
- Automatic expansion of top-level nodes
- Support for all JSON data types (objects, arrays, strings, numbers, booleans, null)

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  json_preview: ^0.1.0
```

## Usage

```dart
import 'package:json_preview/json_preview.dart';

// Sample JSON data
final Map jsonData = {
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
        child: JsonViewer(jsonData: jsonData),
      ),
    ),
  );
}
```

## Customization

The `JsonViewer` widget accepts the following parameters:

- `jsonData` (required): The JSON data to display
- `depth`: The current nesting level (defaults to 0)
- `parentKey`: The key of the parent node (if any)

## License

This project is licensed under the MIT License - see the LICENSE file for details.
