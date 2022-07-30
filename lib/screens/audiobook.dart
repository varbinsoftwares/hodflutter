//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hod/ui/uielements.dart';
import 'package:hod/constdata/staticdata.dart' as staticdata;
import 'package:hod/screens/detailpage.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sqflite/sqflite.dart';
import '../curd.dart';
import 'page_manager.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:hod/screens/favouritepage.dart';
import 'package:audio_service/audio_service.dart';

class AudioSong extends StatefulWidget {
  @override
  State<AudioSong> createState() => _AudioSongState();
}

class _AudioSongState extends State<AudioSong> {
  UIElements uiobj = UIElements();
  Dbconnect dbObj = Dbconnect();
  late final PageManager _pageManager;

  late Dio dio;
  String selectedbutton = "A";
  List<String> elements = staticdata.englishAlphabates;
  var temp = '';
  @override
  void initState() {
    super.initState();
    dio = Dio();
    dbObj.createDatabase();

    super.initState();
    _pageManager = PageManager();
  }

  List listData = [
    {
      "title": "first song ",
      "id": "1",
      "song_id": "101",
      "link":
          "https://hod.christianappdevelopers.com/assets/songs_files/song1.mp3"
    },
    {
      "title": "second song",
      "id": "2",
      "song_id": "102",
      "link":
          "https://hod.christianappdevelopers.com/assets/songs_files/song2.mp3"
    },
    {
      "title": "third song",
      "id": "3",
      "song_id": "103",
      "link":
          "https://hod.christianappdevelopers.com/assets/songs_files/song3.mp3"
    },
  ];
  bool loadingdata = true;

  var progress = "";
  String savePath = "";

  bool downloading = true;
  String downloadingStr = "No data";

  Future downloadFile(song_detail) async {
    print("download function");

    try {
      Dio dio = Dio();
      String fileName = song_detail['link']
          .substring(song_detail['link'].lastIndexOf("/") + 1);
      Directory tempDir = await getApplicationDocumentsDirectory();
      String savePath = '${tempDir.path}/$fileName';

      await dio.download(song_detail['link'], savePath,
          onReceiveProgress: (rec, total) {
        setState(() {
          downloading = true;
          // download = (rec / total) * 100;
          downloadingStr = "Downloading URL : $rec";
          temp = savePath;
        });
      });

      dbObj.insertDataFavourite(
          song_id: song_detail['song_id'],
          song_title: song_detail['title'],
          song_path: temp,
          user_id: song_detail['id']);
      setState(() {
        downloading = false;
        downloadingStr = "Completed";
      });
    } catch (e) {
      print(e.toString());
    }
  }

  var FavData = [];

  favouriteButton(song_detail) {
    print('+++++++++++++++++++++++++');
    print(song_detail);

    dbObj.getFavouriteData(song_detail['song_id']).then((value) {
      print("bxvbxvxvbxhv$value");
      if (value.isEmpty) {
        downloadFile(song_detail);
      } else {}
    });
  }

  var current_song = {};
  bool current_song_state = false;
  bool isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Audio Book"),
        actions: [
          IconButton(
            icon: Icon(
              FontAwesomeIcons.heart,
            ),
            iconSize: 23,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavouriteSong()),
              );
            },
          )
        ],
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
            Divider(
              height: 10,
            ),
            Flexible(
              child: loadingdata
                  ? ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemCount: listData.length,
                      key: PageStorageKey("study1"),
                      itemBuilder: (context, itemIndex) {
                        return Container(
                          height: 50,
                          child: ListTile(
                            title: Text(
                              listData[itemIndex]["title"],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                            ),
                            onTap: () {
                              setState(() {
                                current_song_state = true;
                                // print(listData[itemIndex]);
                                current_song = listData[itemIndex];
                                isButtonPressed = false;
                              });
                              _pageManager
                                  .setNewSong(listData[itemIndex]["link"]);
                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 0,
                        );
                      },
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
            current_song_state
                ? Container(
                    height: 150,
                    margin: EdgeInsets.all(5.0),
                    //padding: EdgeInsets.all(10),
                    color: Color.fromARGB(255, 15, 165, 145),
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        Card(
                          color: Color.fromARGB(255, 15, 165, 145),
                          child: ListTile(
                            title: Text(
                              current_song['title'],
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              "test2vdsvdv",
                              style: TextStyle(color: Colors.white),
                            ),
                            leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://images.unsplash.com/photo-1547721064-da6cfb341d50")),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    isButtonPressed
                                        ? FontAwesomeIcons.solidHeart
                                        : FontAwesomeIcons.heart,
                                  ),
                                  iconSize: 23,
                                  color: isButtonPressed
                                      ? Colors.red
                                      : Colors.white,
                                  onPressed: () {
                                    favouriteButton(current_song);
                                    setState(() {
                                      isButtonPressed = !isButtonPressed;
                                    });
                                  },
                                ),
                                ValueListenableBuilder<ButtonState>(
                                  valueListenable: _pageManager.buttonNotifier,
                                  builder: (_, value, __) {
                                    switch (value) {
                                      case ButtonState.loading:
                                        return Container(
                                          margin: const EdgeInsets.all(8.0),
                                          width: 32.0,
                                          height: 32.0,
                                          child:
                                              const CircularProgressIndicator(),
                                        );
                                      case ButtonState.paused:
                                        return IconButton(
                                          icon: const Icon(Icons.play_arrow),
                                          iconSize: 32.0,
                                          color: Colors.white,
                                          onPressed: () {
                                            _pageManager.play();

                                            print("Playing now");
                                          },
                                        );
                                      case ButtonState.playing:
                                        return IconButton(
                                          icon: const Icon(Icons.pause),
                                          iconSize: 32.0,
                                          color: Colors.white,
                                          onPressed: () {
                                            print("Pause now");
                                            _pageManager.pause();
                                          },
                                        );
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.forwardStep,
                                  ),
                                  iconSize: 22,
                                  color: Colors.white,
                                  //   splashColor: Colors.purple,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          margin: EdgeInsets.all(15.0),
                          child: ValueListenableBuilder<ProgressBarState>(
                            valueListenable: _pageManager.progressNotifier,
                            builder: (_, value, __) {
                              return ProgressBar(
                                baseBarColor: Colors.white,
                                thumbColor: Colors.white,
                                progressBarColor: Colors.white,
                                progress: value.current,
                                buffered: value.buffered,
                                total: value.total,
                                onSeek: _pageManager.seek,
                              );
                            },
                          ),
                        )
                      ],
                    ))
                : Container(),
          ],
        ),
      ),
    );
  }
}
