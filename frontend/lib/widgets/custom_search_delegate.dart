import 'package:flutter/material.dart';
import 'package:online_bookstore/widgets/book_list_item.dart';

import '../models/book.dart';
import '../screens/book_details_screen/book_details_screen.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Book> searchTerms;

  CustomSearchDelegate(
      {super.searchFieldLabel,
      super.searchFieldStyle,
      super.searchFieldDecorationTheme,
      super.keyboardType,
      super.textInputAction,
      required this.searchTerms});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Book> matchQuery = [];
    for (var book in searchTerms) {
      if (book.title!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(book);
      }
    }
    for (var book in searchTerms) {
      if (book.authors!.join(",").toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(book);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    BookDetailsScreen(book: matchQuery[index]),
              ),
            );
          },
          child: BookListItem(
            book: matchQuery[index],
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Book> matchQuery = [];
    for (var book in searchTerms) {
      if (book.title!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(book);
      }
    }
    for (var book in searchTerms) {
      if (book.authors!.join(",").toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(book);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    BookDetailsScreen(book: matchQuery[index]),
              ),
            );
          },
          child: BookListItem(
            book: matchQuery[index],
          ),
        );
      },
    );
  }
}
