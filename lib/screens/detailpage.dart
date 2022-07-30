import 'package:flutter/material.dart';
import 'package:hod/ui/uielements.dart';
import 'package:hod/constdata/staticdata.dart' as staticdata;

class DetailPage extends StatefulWidget {
  Map listobj;
  String displaykey;
  DetailPage({
    required this.listobj,
    required this.displaykey,
  });

  @override
  _ButtonBarSet createState() => _ButtonBarSet();
}

class _ButtonBarSet extends State<DetailPage> {
  double fontsize = 15;
  String editdatatext = "";

  @override
  Widget build(BuildContext context) {
    editdatatext = widget.listobj['title'];
    return new Scaffold(
        appBar: new AppBar(
          title: Text(
            editdatatext,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          // title: new Text("kkkk"),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(null),
            ),
          ],
          // leading: new Container(),
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          child: Card(
            child: Column(children: [
              new ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OutlinedButton(
                      child: Text('Small', style: TextStyle(fontSize: 15)),
                      style: OutlinedButton.styleFrom(
                        primary: fontsize == 15 ? Colors.white : Colors.red,
                        // backgroundColor: Colors.red,
                        side: BorderSide(
                          color: Colors.red,
                        ),
                        backgroundColor:
                            fontsize == 15 ? Colors.pink : Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          fontsize = 15;
                        });
                      },
                    ),
                    OutlinedButton(
                      child: Text('Medium', style: TextStyle(fontSize: 20)),
                      style: OutlinedButton.styleFrom(
                        primary: fontsize == 20 ? Colors.white : Colors.pink,
                        //backgroundColor: Colors.teal,
                        side: BorderSide(
                          color: Colors.red,
                        ),
                        backgroundColor:
                            fontsize == 20 ? Colors.pink : Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      onPressed: () {
                        setState(() {
                          fontsize = 20;
                        });
                      },
                    ),
                    OutlinedButton(
                      child: Text('Large', style: TextStyle(fontSize: 25)),
                      style: OutlinedButton.styleFrom(
                        primary: fontsize == 25 ? Colors.white : Colors.red,
                        //   backgroundColor: Colors.teal,
                        side: BorderSide(
                          color: Colors.red,
                        ),
                        backgroundColor:
                            fontsize == 25 ? Colors.pink : Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      onPressed: () {
                        setState(() {
                          fontsize = 25;
                        });
                      },
                    ),
                  ]),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.listobj.containsKey('title')
                        ? Text(widget.listobj['title'],
                            style: TextStyle(
                                fontSize: fontsize,
                                fontWeight: FontWeight.w900))
                        : Text(""),
                    widget.listobj.containsKey('title')
                        ? Divider(
                            height: 20,
                          )
                        : Text(""),
                    Text(widget.listobj['body'],
                        style: TextStyle(fontSize: fontsize)),
                  ],
                ),
              ),
            ]),
          ),
        )));
  }
}
