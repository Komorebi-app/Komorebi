class BookModel {
  final int id; 
  final String title;
  final String author; 
  final String isbn;
  final String language;
  final String coverUrl;
  final int pages;
  final DateTime? published;
  final String? resume;

  const BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.isbn,
    required this.language,
    required this.coverUrl,
    required this.pages,
    this.published,
    this.resume,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    String extractCoverUrl(Map<String, dynamic> json) {
      final existingCoverUrl = json['cover_url'] as String?;
      if (existingCoverUrl != null && existingCoverUrl.isNotEmpty) {
        return existingCoverUrl;
      }

      if (json['imageLinks'] is Map) {
        final imageLinks = json['imageLinks'] as Map;
        final thumbnail = imageLinks['thumbnail']?.toString();
        final smallThumbnail = imageLinks['smallThumbnail']?.toString();
        return thumbnail ?? smallThumbnail ?? '';
      }

      return '';
    }

    String extractIsbn(Map<String, dynamic> json) {
      // Depuis la DB 
      if (json['isbn'] != null) {
        return json['isbn'] as String;
      }
      
      // Depuis Google Books (industryIdentifiers)
      if (json['industryIdentifiers'] is List) {
        try {
          final identifiers = json['industryIdentifiers'] as List;
          for (var id in identifiers) {
            if (id is Map && id['type'] == 'ISBN_13') {
              return id['identifier'].toString();
            }
          }
          for (var id in identifiers) {
            if (id is Map && id['type'] == 'ISBN_10') {
              return id['identifier'].toString();
            }
          }
        } catch (_) {}
      }
      return '';
    }

    // Extraction auteurs
    String extractAuthor(Map<String, dynamic> json) {
      // Depuis la DB
      if (json['author'] != null) {
        return json['author'].toString();
      }
      // Depuis Google Books (authors)
      if (json['authors'] is List && (json['authors'] as List).isNotEmpty) {
        return (json['authors'] as List).first.toString();
      }
      return 'Inconnu';
    }

    return BookModel(
      id: json['id'] ?? json['title'].toString().hashCode.abs(),
      title: json['title'] as String? ?? 'Sans titre',
      author: extractAuthor(json),
      isbn: extractIsbn(json),
      language: json['language'] as String? ?? '',
      coverUrl: extractCoverUrl(json),
      pages: json['pageCount'] ?? json['pages'] ?? 0,
      published: json['publishedDate'] != null 
          ? DateTime.tryParse(json['publishedDate'].toString()) 
          : (json['published'] != null ? DateTime.tryParse(json['published'].toString()) : null),
      resume: json['description'] ?? json['resume'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author, 
      'isbn': isbn,
      'language': language,
      'cover_url': coverUrl,
      'pages': pages,
      'published': published?.toIso8601String().split('T')[0], 
      'resume': resume,
    };
  }
}