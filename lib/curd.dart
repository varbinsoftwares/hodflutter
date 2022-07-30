import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Dbconnect {
  Database? db;

  Dbconnect() {
    createDatabase();
  }

  //static Database? _database;

  Future<String> createDatabase() async {
    print("create table ");
    db = await openDatabase('hod5.db', version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE favourite_song (id INTEGER PRIMARY KEY,song_id CHAR(10),song_title,song_path TEXT ,user_id CHAR(10))');
    });
    return "ok";
  }

  Future<List> getFavouriteData(String song_id) async {
    List<Map<String, dynamic>> maps = await db!.rawQuery(
        'SELECT * FROM favourite_song where song_id = ?  order by id',
        [song_id]);
    if (maps.isEmpty) {
      print("no data");
      return [];
    } else {
      return maps;
    }
  }

  Future<int> insertDataFavourite(
      {song_id, song_title, song_path, user_id}) async {
    print("song data commig ${[song_id, song_title, song_path, user_id]}");
    int id2 = await db!.rawInsert(
        'INSERT INTO favourite_song(song_id, song_title, song_path, user_id) VALUES(?,?,?, ?)',
        [song_id, song_title, song_path, user_id]);
    print("inserted id is $id2");
    return id2;
  }

  Future<List> getAllFavouriteData() async {
    List<Map<String, dynamic>> maps =
        await db!.rawQuery('SELECT * FROM favourite_song order by id desc');
    if (maps.isEmpty) {
      print("no data");
      return [];
    } else {
      return maps;
    }
  }
}
