import 'package:flutter/material.dart';
import 'package:hod/ui/uielements.dart';

class SongLyrics extends StatefulWidget {
  const SongLyrics({Key? key, required this.language}) : super(key: key);
  final String language;
  @override
  State<SongLyrics> createState() => _SongLyricsState();
}

class _SongLyricsState extends State<SongLyrics> {
  UIElements uiobj = UIElements();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.language),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: uiobj.GoldenGradiant(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            uiobj.CircleButtons(labletext: "A", onPressed: () => {}),
          ],
        ),
      ),
    );
  }
}
