import 'package:flutter/material.dart';
import 'package:hod/ui/uielements.dart';
import 'package:hod/screens/songlyrics.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  UIElements uiobj = UIElements();

  //navigate to lyrics page
  navigationToPage(language) {
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SongLyrics(language: language)),
    );
  }

  // select language
  selectLanguage(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select Language"),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                uiobj.LanguageButton(
                  lableText: "English",
                  onPressed: () {
                    navigationToPage("English");
                  },
                ),
                uiobj.LanguageButton(
                  lableText: "Hindi",
                  onPressed: () {
                    navigationToPage("Hindi");
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
            uiobj.CircleButtons(
                labletext: "A", onPressed: () => {}, isActive: true),
            uiobj.HomeButtons(
              labletext: "Song Lyrics",
              onPressed: () {
                print("hi this is working");
                selectLanguage(context);
              },
              image: "assets/song-lyrics.png",
            ),
            uiobj.HomeButtons(
              labletext: "Audio Songs",
              onPressed: () => {},
              image: "assets/love-song.png",
            ),
          ],
        ),
      ),
    );
  }
}
