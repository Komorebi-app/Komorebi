class Book{
  final String id;
  final String selfLink;

  const Book({required this.id, required this.selfLink});

  factory Book.fromJson(Map <String, dynamic> json){
    return switch (json){
      {"id": String id, "selfLink": String selfLink} => Book(
        id : id,
        selfLink: selfLink
      ),
      _ => throw const FormatException("Fail to load book data")
    };

}
  
 

}