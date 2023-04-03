import 'package:flutter/material.dart';

class ShareIconButton extends StatelessWidget {
  final Function() onTap;

  const ShareIconButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ClipOval(
        child: Material(
          color: Colors.white, // button color
          child: InkWell(
            splashColor: Colors.grey,
            onTap: onTap,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey),
                ),
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: Icon(
                    Icons.share,
                    color: Colors.black,
                    size: 12,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
