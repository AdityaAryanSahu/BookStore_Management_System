import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:online_bookstore/models/customer.dart';
import 'package:online_bookstore/repositories/all_books_repo.dart';
import 'package:online_bookstore/repositories/auth_repo.dart';
import 'package:http/http.dart' as http;

import '../models/book.dart';

class WishlistRepo {
  static Future<http.Response> addToWishList(Book book) async {
    Customer user = AuthRepo.currentUser!;
    if (user.wishList.isNotEmpty) {
      user.wishList.add(book);
    } else {
      user.wishList = await getItemsFromWishListFromDB();
      user.wishList.add(book);
    }
    int customerId = user.id;
    int bookId = book.bookId!;

    if (kDebugMode) {
      print(user.wishList);
    }

    final client = http.Client();

    final url = Uri.parse('https://bookstore-management-system-3lku.onrender.com/wishlist/');
    final headers = {'Content-Type': 'application/json'};
    final body = {'customer_id': customerId, 'book_id': bookId};

    final response =
        await client.post(url, headers: headers, body: jsonEncode(body));
    return response;
  }

  static Future<http.Response> removeFromWishList(Book book) async {
    Customer user = AuthRepo.currentUser!;
    if (user.wishList.isNotEmpty) {
      user.wishList.remove(book);
    } else {
      user.wishList = await getItemsFromWishListFromDB();
      user.wishList.remove(book);
    }

    int customerId = user.id;
    int bookId = book.bookId!;

    if (kDebugMode) {
      print(user.wishList);
    }

    final client = http.Client();

    final url = Uri.parse(
        'https://bookstore-management-system-3lku.onrender.com/wishlist/$customerId/$bookId');
    final response = await client.delete(url);

    return response;
  }

  static Future<List<Book>> getItemsFromWishListFromDB() async {
    final client = http.Client();
    int cid = AuthRepo.currentUser!.id;
    final url =
        Uri.parse('https://bookstore-management-system-3lku.onrender.com/wishlist/$cid');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> mp = jsonDecode(response.body);

      List<Book> ret = [];
      for (var entry in mp["wishlist"]!) {
        int currBookId = entry[1];

        ret.add(AllBooksRepo.allBooks
            .where((element) => element.bookId == currBookId)
            .first);
      }
      return ret;
    }
    throw Exception("Status code not 200");
  }
}
