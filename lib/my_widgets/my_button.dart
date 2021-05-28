import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  String label;

  Function onPressed;

  MyButton(this.label, this.onPressed);

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: ElevatedButton(
        onPressed: _onPressed,
        child: _loading
            ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white)))
            : Text(widget.label, style: TextStyle(fontSize: 22, color: Colors.white)),
      ),
    );
  }

  _onPressed() async {
    setState(() => _loading = true);
    await widget.onPressed();
    setState(() => _loading = false);
  }
}
