import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({super.key, required this.title});
  String title;

  Size get preferredSize {
    return new Size.fromHeight(50.0);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: Icon(
          Icons.arrow_back,
          size: 22.0,
          color: Colors.white,
        ),
      ),
      elevation: 0.0,
      backgroundColor: Color.fromARGB(255, 7, 125, 180),
      title: Text(
        "${title}",
        style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    );
  }
}
