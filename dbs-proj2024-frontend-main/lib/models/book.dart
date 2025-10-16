class Book {
  int? bookId;
  String? title;
  String? description;
  String? datePublished;
  double? rating;
  int? ratingCount;
  String? categories;
  String? forAges;
  List<String>? authors;
  String? imageUrl;
  String? format;
  String? publisher;
  String? isbn;
  String? edition;
  int? dimensionX;
  int? dimensionY;
  int? dimensionZ;
  int? dimensionW;

  Book(
      {this.bookId,
      this.title,
      this.description,
      this.datePublished,
      this.rating,
      this.ratingCount,
      this.categories,
      this.forAges,
      this.authors,
      this.imageUrl,
      this.format,
      this.publisher,
      this.isbn,
      this.edition,
      this.dimensionX,
      this.dimensionY,
      this.dimensionZ,
      this.dimensionW});

  Book.fromJson(Map<String, dynamic> json) {
    bookId = json['book_id'];
    title = json['title'];
    description = json['Description'];
    datePublished = json['date_published'];
    rating = json['rating'];
    ratingCount = json['rating_count'];
    categories = json['categories'];
    forAges = json['for_ages'];
    authors = json['authors'].cast<String>();
    imageUrl = json['image_url'];
    format = json['format'];
    publisher = json['publisher'];
    isbn = json['isbn'];
    edition = json['edition'];
    dimensionX = json['dimension_x'];
    dimensionY = json['dimension_y'];
    dimensionZ = json['dimension_z'];
    dimensionW = json['dimension_w'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['book_id'] = bookId;
    data['title'] = title;
    data['Description'] = description;
    data['date_published'] = datePublished;
    data['rating'] = rating;
    data['rating_count'] = ratingCount;
    data['categories'] = categories;
    data['for_ages'] = forAges;
    data['authors'] = authors;
    data['image_url'] = imageUrl;
    data['format'] = format;
    data['publisher'] = publisher;
    data['isbn'] = isbn;
    data['edition'] = edition;
    data['dimension_x'] = dimensionX;
    data['dimension_y'] = dimensionY;
    data['dimension_z'] = dimensionZ;
    data['dimension_w'] = dimensionW;
    return data;
  }
}
