import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class AllBooksRepo {
  static String apiURL = "https://dbs-proj2024-backend.vercel.app/books/";

  static List<Book> allBooks = [];

  static Future<List<Book>> fetchBooks() async {
    var client = http.Client();
    final response = await client.get(Uri.parse(apiURL));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['books'];
      var a = jsonData.map((json) => Book.fromJson(json)).toList();
      return a;
    } else {
      throw Exception('Failed to load books');
    }
  }
}
