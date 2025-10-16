import 'dart:convert';
import '../models/book.dart';
import 'package:http/http.dart' as http;

import 'all_books_repo.dart';
import 'auth_repo.dart';

class RecommendationsRepo {
  static Future<List<Book>> getRecommendationsFromDB() async {
    final client = http.Client();
    int cid = AuthRepo.currentUser!.id;
    final url =
        Uri.parse('https://cors-anywhere.herokuapp.com/http://0.0.0.0:8000/recommend/$cid');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> mp = jsonDecode(response.body);

      List<Book> ret = [];
      if ((mp["recommendations"]! as List).isEmpty) {
        return ret;
      }
      for (var entry in mp["recommendations"]!) {
        var matchingBooks = AllBooksRepo.allBooks.where((element) => element.bookId == entry);
      if (matchingBooks.isNotEmpty) {
       ret.add(matchingBooks.first);
      } 
      }
      return ret;
    }
    throw Exception("Status code not 200");
  }
}
