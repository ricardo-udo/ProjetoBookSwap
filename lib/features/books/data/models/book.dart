class Book {
  final String id;
  final String title;
  final String author;
  final String? genre;
  final int? year;
  final int? pages;
  final String? synopsis;
  final String? imagePath;
  final String ownerId;
  final String? ownerName;
  final String status;
  final String? ownerAvatar;
  final String? publisher;

  Book({
    required this.id,
    required this.title,
    required this.author,
    this.genre,
    this.year,
    this.pages,
    this.synopsis,
    this.imagePath,
    required this.ownerId,
    this.ownerName,
    this.status = 'available',
    this.ownerAvatar,
    this.publisher,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'genre': genre,
      'year': year,
      'pages': pages,
      'synopsis': synopsis,
      'image_path': imagePath,
      'owner_id': ownerId,
      'owner_name': ownerName,
      'status': status,
      'owner_avatar': ownerAvatar,
      'publisher': publisher,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      genre: map['genre'],
      year: map['year'],
      pages: map['pages'],
      synopsis: map['synopsis'],
      imagePath: map['image_path'],
      ownerId: map['owner_id'],
      ownerName: map['owner_name'],
      status: map['status'] ?? 'available',
      ownerAvatar: map['owner_avatar'],
      publisher: map['publisher'],
    );
  }
}
