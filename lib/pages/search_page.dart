import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:komorebi/config/app_config.dart';
import 'package:komorebi/features/auth/domain/services/auth_service.dart';
import 'package:komorebi/init_dependencies.dart';
import 'package:komorebi/models/book_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<BookModel> _results = [];

  Future<void> _handleSearch(String searchTerm) async {
    if (searchTerm.isEmpty) return;

    setState(() {
      _results = [];
    });

    try {
      String? token = await AuthService(getIt<FlutterSecureStorage>()).getToken();
      if (token != null) {
        final response = await Dio().get(
          '${AppConfig.apiUrl}/book/search-by-title/',
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
          queryParameters: {'title': searchTerm}, 
        );

        final List<dynamic> data = response.data;
        setState(() {
          _results = data.map((json) => BookModel.fromJson(json)).toList();
        });
      }

    } on DioException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur lors de la recherche : ${e.message}")),
        );
      }
    }
  }

  Future<void> _saveBook(BookModel book) async {
    try {
      String? token = await AuthService(getIt<FlutterSecureStorage>()).getToken();
      if (token != null) {
        final payload = {
          'isbn': book.isbn,
          'title': book.title,
          'author': book.author,
          'language': book.language,
          'pages': book.pages,
          'published': book.published is DateTime 
            ? (book.published as DateTime).toIso8601String().split('T')[0]
            : book.published,
          'resume': book.resume,
          'cover_url': book.coverUrl,
        };
        
        await Dio().post(
          '${AppConfig.apiUrl}/book/add-manual-to-library/',
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
          data: payload,
        );

        // Afficher un message de succès
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Livre ajouté à votre bibliothèque !")),
          );
        }
      }
    } on DioException catch (e) {
      if (mounted) {
        // Afficher un message si le livre est déjà en BDD
        if (e.response?.statusCode == 409) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Ce livre est déjà dans votre bibliothèque")),
          );
          // Message pour erreurs diverses pouvant survenir lors de la sauvegarde
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Erreur lors de la sauvegarde : ${e.message}")),
          );
        }
      }
    }
  }

  // Modale de confirmation pour ajouter le livre à la bibliothèque
  Future<void> _dialogBuilder(BuildContext context, BookModel book) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        bool isLoading = false;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Ajouter à la bibliothèque'),
              content: const Text(
                'Souhaitez-vous ajouter ce livre à votre bibliothèque ?',
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: isLoading ? null : () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Annuler'),
                ),
                TextButton(
                  onPressed: isLoading ? null : () async {
                    setState(() => isLoading = true);
                    await _saveBook(book);
                    if (mounted && context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: isLoading 
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Valider'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Barre de recherche
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              onSubmitted: _handleSearch,
              decoration: InputDecoration(
                hintText: "Entrez un titre de livre",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _handleSearch(_controller.text),
                ),
              ),
            ),
          ),

          // Liste des résultats
          Expanded(
              child: ListView.builder(
                itemCount: _results.length,
                itemBuilder: (context, index) {
                  final book = _results[index];
                  return ListTile(
                    leading: book.coverUrl.isNotEmpty
                        ? Image.network(book.coverUrl, width: 100, fit: BoxFit.cover)
                        : Image.network('https://docs.flutter.dev/assets/images/dash/dash-fainting.gif', width: 100, fit: BoxFit.cover),
                    title: Text(book.title),
                    subtitle: Text(book.author),
                    onTap: () => _dialogBuilder(context, book)
                  );
                },
              ),
          ),
        ],
      ),
    );
  }
}