import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/moviemodel.dart';

class ApiServices {
  Future<Moviemodel> createAlbum(String item) async {
    final http.Response response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/$item?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed'),
      // headers: {
      //   'X-RapidAPI-Key': '46f7dffe1amsh1715f22da088b7bp195c52jsn2014f61ad5fc',
      //   'X-RapidAPI-Host': 'spotify23.p.rapidapi.com'
      // },
    );

    if (response.statusCode == 200) {
      return Moviemodel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create album.');
    }
  }
}
