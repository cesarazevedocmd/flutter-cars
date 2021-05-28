import 'package:flutter/material.dart';

alert(BuildContext context, String msg, {Function callback}) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Cars"),
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (callback != null) {
                  callback();
                }
              },
              child: Text("OK"),
            ),
          ],
        );
      });
}
