
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLength;

  const ExpandableText({
    Key? key,
    required this.text,
    this.trimLength = 120,
  }) : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final String trimmedText = widget.text.length > widget.trimLength && !_isExpanded
        ? widget.text.substring(0, widget.trimLength) + " "
        : widget.text  + " ";

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Flexible(
          child: Text.rich(
            TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: trimmedText,
                  style: TextStyle(color: Colors.black),
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.bottom,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: Text(
                      _isExpanded ? 'Приховати' : 'Розгорнути',
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.normal, decoration: TextDecoration.underline, decorationColor: Colors.red,),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

