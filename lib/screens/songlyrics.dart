import 'package:flutter/material.dart';
import 'package:hod/ui/uielements.dart';
import 'package:hod/constdata/staticdata.dart' as staticdata;

class SongLyrics extends StatefulWidget {
  const SongLyrics({Key? key, required this.language}) : super(key: key);
  final String language;
  @override
  State<SongLyrics> createState() => _SongLyricsState();
}

class _SongLyricsState extends State<SongLyrics> {
  UIElements uiobj = UIElements();

  String selectedbutton = "A";
  List<String> elements = staticdata.englishAlphabates;
  List listData = [
    {"title": "this is test song", "id": "1"},
    {"title": "this is test song", "id": "1"},
    {"title": "this is test song", "id": "1"},
    {"title": "this is test song", "id": "1"},
    {"title": "this is test song", "id": "1"},
    {"title": "this is test song", "id": "1"},
    {"title": "this is test song", "id": "1"},
    {"title": "this is test song", "id": "1"},
    {"title": "this is test song", "id": "1"},
    {"title": "this is test song", "id": "1"},
  ];
  bool loadingdata = true;

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
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
            Container(
              width: double.infinity,
              height: 80,
              color: Colors.transparent,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: elements.length,
                itemBuilder: (context, itemIndex) {
                  return Container(
                    height: 70,
                    width: 70,
                    padding: const EdgeInsets.only(left: 16.0),
                    child: uiobj.CircleButtons(
                        labletext: elements[itemIndex],
                        onPressed: () {
                          setState(() {
                            selectedbutton = elements[itemIndex];
                          });
                        },
                        isActive: elements[itemIndex] == selectedbutton),
                  );
                },
              ),
            ),
            Container(
              height: screen_height - 200,
              child: Flexible(
                // child: ScaffoldSetPage('notes', selectetdButton),
                child: loadingdata
                    ? ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemCount: listData.length,
                        key: PageStorageKey("study"),
                        itemBuilder: (context, itemIndex) {
                          return Card(
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: const BorderRadius.only(
                            //       topLeft: Radius.circular(18.0),
                            //       topRight: Radius.circular(25.0),
                            //       bottomLeft: Radius.circular(18.0),
                            //       bottomRight: Radius.circular(18.0)),
                            // ),
                            shape: RoundedRectangleBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(25.0),
                              ),
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: InkWell(
                                onTap: () {
                                  Map<dynamic, dynamic> songdata =
                                      listData[itemIndex];
                                  print("this is is check $songdata");
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      height: 30,
                                      width: 30,
                                      decoration: new BoxDecoration(
                                        color: Colors.orange,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Text(
                                        "This is test title song",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                )),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 1,
                          );
                        },
                      )
                    : Center(child: CircularProgressIndicator()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
