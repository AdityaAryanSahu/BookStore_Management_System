import 'package:flutter/material.dart';
import 'package:online_bookstore/models/book.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

class BookListItem extends StatelessWidget {
  const BookListItem({super.key, required this.book});
  final Book book;

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: SizedBox(
        height: mq.height * 0.2,
        width: mq.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: double.infinity,
              alignment: Alignment.center, // This is needed
              child: Image.network(
                book.imageUrl!,
                fit: BoxFit.contain,
                width: mq.width < 600 ? mq.width / 3.5 : 200,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              width: 1.7 * mq.width / 3,
              child: Column(
                children: [
                  Text(
                    book.title!,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "By ${book.authors!.join(", ")}",
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RatingStars(
                    editable: false,
                    rating: book.rating!,
                    color: Colors.amber,
                    iconSize: 24,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("${book.ratingCount} Ratings"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
