import 'package:flutter/material.dart';
import 'package:online_bookstore/repositories/auth_repo.dart';

import '../../widgets/book_list_item.dart';
import '../../widgets/custom_search_delegate.dart';
import '../book_details_screen/book_details_screen.dart';
import '../login_screen/login_screen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Wishlist"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(
                        searchTerms: AuthRepo.currentUser!.wishList),
                  );
                },
                icon: const Icon(Icons.search)),
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
                icon: const Icon(Icons.logout)),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.builder(
            itemCount: AuthRepo.currentUser!.wishList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (context) => BookDetailsScreen(
                              book: AuthRepo.currentUser!.wishList[index]),
                        ),
                      )
                      .whenComplete(() => setState(() {}));
                },
                child: BookListItem(
                  book: AuthRepo.currentUser!.wishList[index],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
