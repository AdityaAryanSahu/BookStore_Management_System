import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_bookstore/repositories/all_books_repo.dart';
import 'package:online_bookstore/repositories/auth_repo.dart';
import 'package:online_bookstore/screens/home_screen/bloc/home_screen_bloc.dart';
import 'package:online_bookstore/screens/login_screen/login_screen.dart';
import 'package:online_bookstore/screens/wishlist_screen/wishlist_screen.dart';
import 'package:online_bookstore/widgets/book_list_item.dart';

import '../../widgets/custom_search_delegate.dart';
import '../book_details_screen/book_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _bloc = HomeScreenBloc();

  @override
  void initState() {
    _bloc.add(FetchAllBooksEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Books"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(
                        searchTerms: AllBooksRepo.allBooks),
                  );
                },
                icon: const Icon(Icons.search)),
          ),
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
                icon: const Icon(Icons.logout)),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocConsumer<HomeScreenBloc, HomeScreenState>(
          listenWhen: (previous, current) => current is HomeScreenActionState,
          buildWhen: (previous, current) => current is! HomeScreenActionState,
          listener: (BuildContext context, HomeScreenState state) {
            switch (state.runtimeType) {
              case AllBooksErrorState:
                const snackBar = SnackBar(
                  content: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Oops! an error occurred"),
                    ],
                  ),
                );
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case AllBooksFetchSuccessState:
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView.builder(
                      itemCount: AllBooksRepo.allBooks.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => BookDetailsScreen(
                                    book: AllBooksRepo.allBooks[index]),
                              ),
                            );
                          },
                          child: BookListItem(
                            book: AllBooksRepo.allBooks[index],
                          ),
                        );
                      },
                    ),
                  ),
                );
              case AllBooksLoadingState:
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              default:
                return const Text("Default");
            }
          },
        ),
      ),
    );
  }
}
