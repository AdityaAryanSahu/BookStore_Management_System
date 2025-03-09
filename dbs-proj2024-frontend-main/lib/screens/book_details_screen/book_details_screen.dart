import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_bookstore/repositories/auth_repo.dart';
import 'package:online_bookstore/widgets/book_specs_dialog.dart';
import 'package:online_bookstore/widgets/snack_b.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

import '../../models/book.dart';
import '../../repositories/all_books_repo.dart';
import '../../widgets/book_list_item.dart';
import '../login_screen/login_screen.dart';
import '../wishlist_screen/wishlist_screen.dart';
import 'bloc/book_details_bloc.dart';

class BookDetailsScreen extends StatefulWidget {
  final Book book;

  const BookDetailsScreen({super.key, required this.book});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  final _bloc = BookDetailsBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.favorite,
          ),
          onPressed: () {
            if (AuthRepo.currentUser!.wishList.isEmpty ||
                !AuthRepo.currentUser!.wishList.contains(widget.book)) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              _bloc.add(AddBookToWishlistActionEvent(book: widget.book));
              setState(() {});
            } else {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              _bloc.add(RemoveBookFromWishlistActionEvent(book: widget.book));
              setState(() {});
            }
          },
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const WishlistScreen()),
                    );
                  },
                  icon: const Icon(Icons.favorite)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                onPressed: () {
                  AuthRepo.currentUser = null;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                  const snackBar = SnackBar(
                    content: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Logged out successfully!"),
                      ],
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                icon: const Icon(Icons.logout),
              ),
            ),
          ],
        ),
        body: BlocConsumer<BookDetailsBloc, BookDetailsState>(
          listenWhen: (previous, current) => current is BookDetailsActionState,
          buildWhen: (previous, current) => current is! BookDetailsActionState,
          listener: (context, state) {
            switch (state.runtimeType) {
              case AddedToWishlistActionState:
                runRegularSnackBar(context, Icons.star, Colors.yellow.shade800,
                    "Book added to wish list");
                break;
              case UnableToAddToWishlistActionState:
                runRegularSnackBar(context, Icons.error_outline, Colors.red,
                    "Oops! An error occurred.");
                break;
              case BookAlreadyThereInWishlistActionState:
                runRegularSnackBar(context, Icons.warning_amber, Colors.amber,
                    "Book is already there in wishlist.");
                break;
              case RemovedFromWishlistActionState:
                runRegularSnackBar(context, Icons.remove_circle, Colors.red,
                    "Removed from wishlist.");
                break;
              case BookNotThereInWishlistActionState:
                runRegularSnackBar(context, Icons.warning_amber, Colors.amber,
                    "Book is already removed from wishlist.");
                break;
              case RemovingFromWishListActionState:
                const snackBar = SnackBar(
                  content: Row(
                    children: [
                      CircularProgressIndicator.adaptive(
                        strokeWidth: 3.0,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Removing from wishlist..."),
                    ],
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                break;
              case AddingToWishListActionState:
                const snackBar = SnackBar(
                  content: Row(
                    children: [
                      CircularProgressIndicator.adaptive(
                        strokeWidth: 3.0,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Adding to wishlist..."),
                    ],
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                break;
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      widget.book.title!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.network(widget.book.imageUrl!),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "By ${widget.book.authors!.join(", ")}",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.book.categories!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(letterSpacing: 1, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            RatingStars(
                              editable: false,
                              rating: widget.book.rating!,
                              color: Colors.amber,
                              iconSize: 24,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${widget.book.rating!} stars\n"
                              "${widget.book.ratingCount!} ratings",
                              textAlign: TextAlign.center,
                              style: const TextStyle(letterSpacing: 1),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 35,
                        ),
                        Text(
                          "Published: ${widget.book.datePublished!}\nFor ages: ${widget.book.forAges!}\nand above",
                          textAlign: TextAlign.center,
                          style: const TextStyle(letterSpacing: 1),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextButton(
                      onPressed: () {
                        if (AuthRepo.currentUser!.wishList
                            .contains(widget.book)) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          _bloc.add(RemoveBookFromWishlistActionEvent(
                              book: widget.book));
                          setState(() {});
                        } else {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          _bloc.add(
                              AddBookToWishlistActionEvent(book: widget.book));
                          setState(() {});
                        }
                      },
                      child: Text(
                        AuthRepo.currentUser!.wishList.contains(widget.book)
                            ? 'Remove from Wishlist'
                            : 'Add to Wishlist',
                        style: TextStyle(
                          color: AuthRepo.currentUser!.wishList
                                  .contains(widget.book)
                              ? Colors.red
                              : Colors.yellow,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              getBookSpecificationsDialogObject(
                                  context, widget.book),
                        );
                      },
                      child: const Text("Technical Specifications"),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ExpandableText(
                      widget.book.description!.split(". ").join(". \n\n"),
                      expandText: "Show more",
                      collapseText: "Show less",
                      maxLines: 12,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        letterSpacing: 0.7,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Recommendations!",
                      style:
                          TextStyle(fontSize: 28, color: Colors.amber.shade800),
                    ),
                    Text(
                      "Based on your current wishlist",
                      style:
                          TextStyle(fontSize: 18, color: Colors.green.shade400),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    BlocBuilder<BookDetailsBloc, BookDetailsState>(
                        builder: (context, state) {
                      switch (state.runtimeType) {
                        default:
                          final recs = AuthRepo.currentUser!.recommendations;
                          return SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.6,
                            child: recs.isNotEmpty
                                ? ListView.builder(
                                    itemCount: recs.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BookDetailsScreen(
                                                book: recs[index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: BookListItem(book: recs[index]),
                                      );
                                    },
                                  )
                                : const Center(
                                    child: Text(
                                        "Add a book to your wishlist to get started!"),
                                  ),
                          );
                      }
                    }),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
