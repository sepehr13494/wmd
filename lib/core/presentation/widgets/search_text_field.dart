import 'dart:async';

import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  final String hint;
  final int delay;
  final Function(String? text) function;

  const SearchTextField(
      {Key? key, required this.hint, required this.function, this.delay = 1})
      : super(key: key);

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  Timer? timer;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        // filled: true,
        // fillColor: Colors.white,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.cancel_rounded),
                onPressed: () {
                  setState(() {
                    controller.text = "";
                  });
                  widget.function(null);
                },
              )
            : null,
        hintText: widget.hint,
      ),
      onChanged: (val) {
        setState(() {});
        if (timer != null) {
          timer!.cancel();
        }
        if (widget.delay != 0) {
          timer = Timer(Duration(seconds: widget.delay), () {
            if (val.length > 2 || val.isEmpty) {
              widget.function(val.length > 2 ? val : "");
            }
          });
        } else {
          if (val.length > 2 || val.isEmpty) {
            widget.function(val.length > 2 ? val : "");
          }
        }
      },
    );
  }
}
