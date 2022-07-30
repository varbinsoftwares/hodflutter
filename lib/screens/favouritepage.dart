import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sqflite/sqflite.dart';
import '../curd.dart';
import 'package:hod/ui/uielements.dart';
import 'dart:convert';
import 'page_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

class FavouriteSong extends StatefulWidget {
  @override
  State<FavouriteSong> createState() => FavouriteState();
}

class FavouriteState extends State<FavouriteSong> {
  UIElements uiobj = UIElements();
  Dbconnect dbObj = Dbconnect();
  late final PageManager _pageManager;

  void initState() {
    dbObj.createDatabase().then((strdta) => {getAllFavouriteData()});
    _pageManager = PageManager();
  }

  var temp;
  var listData = [];
  bool loadingdata = false;
  getAllFavouriteData() async {
    temp = dbObj.getAllFavouriteData();
    dbObj.getAllFavouriteData().then((value) {
      print("LLLLLLLLLLLLLLLLLLL");
      print(value);
      setState(() {
        listData = value;
        loadingdata = true;
      });
    });
  }

  var current_song = {};
  bool current_song_state = false;

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite List"),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: uiobj.GoldenGradiant(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: loadingdata
                  ? ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemCount: listData.length,
                      padding: EdgeInsets.all(5),
                      key: PageStorageKey("study"),
                      itemBuilder: (context, itemIndex) {
                        return Container(
                          //height: 50,
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(15.0), //or 15.0
                              child: Container(
                                  height: 50.0,
                                  width: 50.0,
                                  //color: Color(0xffFF0E58),
                                  child: Image.network(
                                      'https://images.unsplash.com/photo-1547721064-da6cfb341d50')),
                            ),
                            title: Text(
                              listData[itemIndex]["song_title"],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                            ),
                            onTap: () {
                              setState(() {
                                current_song_state = true;
                                print(listData[itemIndex]);
                                current_song = listData[itemIndex];
                              });
                              _pageManager
                                  .setNewSong(listData[itemIndex]["song_path"]);
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
                              current_song['song_title'],
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
                                // IconButton(
                                //   icon: Icon(
                                //     isButtonPressed
                                //         ? FontAwesomeIcons.solidHeart
                                //         : FontAwesomeIcons.heart,
                                //   ),
                                //   iconSize: 23,
                                //   color: isButtonPressed
                                //       ? Colors.red
                                //       : Colors.white,
                                //   onPressed: () {
                                //     favouriteButton(current_song);
                                //     setState(() {
                                //       isButtonPressed = !isButtonPressed;
                                //     });
                                //   },
                                // ),
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
