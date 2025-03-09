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
    data['book_id'] = this.bookId;
    data['title'] = this.title;
    data['Description'] = this.description;
    data['date_published'] = this.datePublished;
    data['rating'] = this.rating;
    data['rating_count'] = this.ratingCount;
    data['categories'] = this.categories;
    data['for_ages'] = this.forAges;
    data['authors'] = this.authors;
    data['image_url'] = this.imageUrl;
    data['format'] = this.format;
    data['publisher'] = this.publisher;
    data['isbn'] = this.isbn;
    data['edition'] = this.edition;
    data['dimension_x'] = this.dimensionX;
    data['dimension_y'] = this.dimensionY;
    data['dimension_z'] = this.dimensionZ;
    data['dimension_w'] = this.dimensionW;
    return data;
  }
}
