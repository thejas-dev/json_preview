import 'package:flutter/material.dart';
import 'package:json_preview/src/constants/json_viewer_constants.dart';
import 'package:json_preview/src/styles/json_viewer_styles.dart';

class JsonPreview extends StatefulWidget {
  final dynamic jsonData;
  final int depth;
  final String? parentKey;
  final Color arrowIconColor;
  final TextStyle itemsTextStyle;
  final TextStyle keyStyle;
  final TextStyle arrayKeyStyle;
  final TextStyle emptySquareBraceStyle;
  final TextStyle emptyBracketStyle;
  final Color stringValueColor;
  final Color numValueColor;
  final Color boolValueColor;
  final Color nullValueColor;
  final Color defaultValueColor;
  final String fallbackValueText;
  final IconData expandedArrowIcon;
  final IconData collapsedArrowIcon;

  const JsonPreview({
    super.key,
    required this.jsonData,
    this.depth = 0,
    this.parentKey,
    this.arrowIconColor = const Color(0xFF616161),
    this.itemsTextStyle = JsonViewerStyles.itemsTextStyle,
    this.keyStyle = JsonViewerStyles.jsonKeyStyle,
    this.arrayKeyStyle = JsonViewerStyles.jsonArrayKeyStyle,
    this.emptySquareBraceStyle = JsonViewerStyles.emptySquareBraceStyle,
    this.emptyBracketStyle = JsonViewerStyles.emptyBracketStyle,
    this.stringValueColor = const Color(0xFF388E3C),
    this.numValueColor = const Color(0xFF1976D2),
    this.boolValueColor = const Color(0xFF7B1FA2),
    this.nullValueColor = const Color(0xFF616161),
    this.defaultValueColor = const Color(0xFF000000),
    this.fallbackValueText = 'null',
    this.expandedArrowIcon = Icons.arrow_drop_down,
    this.collapsedArrowIcon = Icons.arrow_right,
  });

  @override
  JsonPreviewState createState() => JsonPreviewState();
}

class JsonPreviewState extends State<JsonPreview> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    // Automatically expand first level, collapse deeper levels
    _isExpanded = widget.depth < 1;
  }

  Color _getColorForType(dynamic value) {
    if (value == null) return widget.nullValueColor;
    if (value is String) return widget.stringValueColor;
    if (value is num) return widget.numValueColor;
    if (value is bool) return widget.boolValueColor;
    return widget.defaultValueColor;
  }

  String _getValueDisplay(dynamic value) {
    if (value == null) return widget.fallbackValueText;
    if (value is String) return '"$value"';
    return value.toString();
  }

  Widget _buildJsonNode(dynamic data) {
    // Handle primitive types
    if (data == null || data is String || data is num || data is bool) {
      return Text(
        _getValueDisplay(data),
        style: TextStyle(
          color: _getColorForType(data),
          fontSize: 14,
        ),
      );
    }

    // Handle Map
    if (data is Map) {
      final itemCount = data.length;
      final isCollapsible = itemCount > 0;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isCollapsible)
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Row(
                children: [
                  Icon(
                    _isExpanded ? Icons.arrow_drop_down : Icons.arrow_right,
                    color: widget.arrowIconColor,
                  ),
                  Text(
                    '{  $itemCount${JsonViewerConstants.itemsText}',
                    style: widget.itemsTextStyle,
                  ),
                ],
              ),
            )
          else
            Text(
              '{}',
              style: widget.emptyBracketStyle,
            ),
          if (_isExpanded && isCollapsible)
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: data.entries
                    .map<Widget>(
                      (entry) => Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '"${entry.key}": ',
                              style: widget.keyStyle,
                            ),
                            Expanded(
                              child: JsonPreview(
                                jsonData: entry.value,
                                depth: widget.depth + 1,
                                parentKey: entry.key,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      );
    }

    // Handle List
    if (data is List) {
      final itemCount = data.length;
      final isCollapsible = itemCount > 0;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isCollapsible)
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Row(
                children: [
                  Icon(
                    _isExpanded
                        ? widget.expandedArrowIcon
                        : widget.collapsedArrowIcon,
                    color: widget.arrowIconColor,
                  ),
                  Text(
                    '[  $itemCount${JsonViewerConstants.itemsText}',
                    style: widget.itemsTextStyle,
                  ),
                ],
              ),
            )
          else
            Text(
              '[]',
              style: widget.emptySquareBraceStyle,
            ),
          if (_isExpanded && isCollapsible)
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: data
                    .asMap()
                    .entries
                    .map<Widget>(
                      (entry) => Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '[${entry.key}]: ',
                              style: widget.arrayKeyStyle,
                            ),
                            Expanded(
                              child: JsonPreview(
                                jsonData: entry.value,
                                depth: widget.depth + 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      );
    }

    // Fallback
    return Text(
      data.toString(),
      style: TextStyle(color: _getColorForType(data)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildJsonNode(widget.jsonData);
  }
}
