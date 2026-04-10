import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:komorebi/features/auth/domain/services/auth_service.dart';
import 'package:komorebi/features/collection/data/models/book_model.dart';
import 'package:komorebi/init_dependencies.dart';

class BookCard extends StatefulWidget {
  final BookModel book;

  const BookCard({super.key, required this.book});

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push<void>('/book/${widget.book.id}');
      },
      child: Card(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Column(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Align(
                      alignment: Alignment.center,
                      child: FutureBuilder<String?>(
                        future: AuthService(
                          getIt<FlutterSecureStorage>(),
                        ).getToken(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox(
                              width: 90,
                              height:
                                  120,
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          }

                          if (snapshot.hasError ||
                              !snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const SizedBox(
                              width: 90,
                              child: Icon(Icons.book, size: 50),
                            );
                          }

                          return Image.network(
                            widget.book.coverUrl ?? "",
                            width: 90,
                            headers: {
                              'Authorization': 'Bearer ${snapshot.data}',
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.book, size: 50);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsGeometry.only(top: 10),
                              child: Text(
                                widget.book.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .apply(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsGeometry.only(top: 5),
                              child: Text(
                                widget.book.author.getFullname(),
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .apply(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsGeometry.only(top: 5),
                              child: Text(
                                widget.book.formatedDate(),
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .apply(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsGeometry.only(top: 5, right: 15, left: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Progression",
                          style: Theme.of(context).textTheme.titleLarge!.apply(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          "${widget.book.progress}%",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.only(top: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: widget.book.progress / 100,
                              color: Theme.of(context).colorScheme.tertiary,
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                              minHeight: 8,
                              year2023: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
