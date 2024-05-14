class Book {
  String name;
  String author;
  String year;
  String? description;
  String coverURL;

  Book( {required this.name, required this.author, required this.year, this.description, required this.coverURL} );
}

final List<Book> listOfBooks = [
  Book(name: "Elantris", author: "Brandon Sanderson", year: "2005", coverURL: "https://http2.mlstatic.com/D_NQ_NP_981299-MLU70052642116_062023-O.webp", description: 'Elantrica'),
  Book(name: 'Mistborn', author: 'Brandon Sanderson', year: '2006', coverURL: 'https://images.cdn1.buscalibre.com/fit-in/360x360/e4/77/e47764810a27f69df11408c8dd38cb23.jpg'),
  Book(name: "Elantris", author: "Brandon Sanderson", year: "2005", coverURL: "https://http2.mlstatic.com/D_NQ_NP_981299-MLU70052642116_062023-O.webp",
      description: 'Elantrica'),
  Book(name: 'Mistborn', author: 'Brandon Sanderson', year: '2006', coverURL: 'https://images.cdn1.buscalibre.com/fit-in/360x360/e4/77/e47764810a27f69df11408c8dd38cb23.jpg')
];