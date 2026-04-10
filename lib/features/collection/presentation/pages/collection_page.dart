import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:komorebi/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:komorebi/features/collection/presentation/bloc/collection_bloc.dart';
import 'package:komorebi/features/collection/presentation/widgets/book_card.dart';

class Collection extends StatefulWidget {
  const Collection({super.key});

  @override
  State<Collection> createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthGetUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          if (state.user == null) {
            context.replace('/auth');
          } else {
            context.read<CollectionBloc>().add(CollectionGetEvent(id: state.user!.library));
          }
        }
        if (state is AuthLoggoutSuccess) {
          context.go('/auth');
        }
      },
      builder: (context, state) {
        switch (state) {
          case AuthSuccess _:
            return BlocBuilder<CollectionBloc, CollectionState>(
              builder: (BuildContext context, CollectionState state) {
                switch (state) {
                  case CollectionSuccess _:
                    return SizedBox(
                      height: double.infinity,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Column(
                          spacing: 16,
                          children: state.collection.books.reversed.map((book) {
                            return BookCard(book: book);
                          }).toList(),
                        ),
                      ),
                    );
                  case CollectionFailure _:
                    // ignore: avoid_print
                    print(state.message);
                    return Center(child: Text("Une erreur est survenue !"));
                  default:
                    return Center(child: CircularProgressIndicator.adaptive());
                }
              },
            );
          case AuthFailure _:
            // ignore: avoid_print
            print(state.message);
            return Center(child: Text("Une erreur est survenue !"));
          default:
            return Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}
