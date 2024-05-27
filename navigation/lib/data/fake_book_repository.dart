import 'package:collection/collection.dart';
import 'package:navigation/core/entities/book.dart';
import 'package:navigation/data/book_repository.dart';

class FakeBookRepository implements BookRepository {
  static final List<Book> listOfBooks = [
    Book(
        name: "Elantris",
        author: "Brandon Sanderson",
        year: "2005",
        coverURL:
            "https://http2.mlstatic.com/D_NQ_NP_981299-MLU70052642116_062023-O.webp",
        description:
            'Elantris was the capital of Arelon: gigantic, beautiful, literally radiant, filled with benevolent beings who used their powerful magical abilities for the benefit of all. Yet each of these demigods was once an ordinary person until touched by the mysterious transforming power of the Shaod. Ten years ago, without warning, the magic failed. Elantrians became wizened, leper-like, powerless creatures, and Elantris itself dark, filthy, and crumbling.',
        id: 1),
    Book(
        name: 'Mistborn I: The Final Empire',
        author: 'Brandon Sanderson',
        year: '2006',
        coverURL:
            'https://m.media-amazon.com/images/I/91U6rc7u0yL._AC_UF1000,1000_QL80_.jpg',
        description:
            'For a thousand years, the ash has fallen and no flowers have bloomed. For a thousand years, the Skaa have slaved in misery and lived in fear. For a thousand years, the Lord Ruler has reigned with absolute power and ultimate terror. Until Kelsier, a brilliant half-Skaa thief and natural leader, finds in himself the powers of a Mistborn, and turns his talents to the ultimate caper, with the Lord Ruler himself as the mark.',
        id: 2),
    Book(
        name: "Mistborn II: The Well of Ascension",
        author: "Brandon Sanderson",
        year: "2007",
        coverURL:
            "https://prodimage.images-bn.com/pimages/9781250868299_p0_v2_s1200x630.jpg",
        description:
            'The impossible task has been accomplished. The Lord Ruler has been vanquished. But with Kelsier dead, too, the awesome task of building a new world has been left to former street urchin and Kelsiers protégé Vin, who is now the most powerful Mistborn in the land. Vin is now worshipped as a hero in her own right, but she is haunted by a strange vaporous entity hidden in the mists.',
        id: 3),
    Book(
        name: 'Mistborn III: The Hero of Ages',
        author: 'Brandon Sanderson',
        year: '2008',
        coverURL: 'https://m.media-amazon.com/images/I/51DZcL07ZUL.jpg',
        description:
            'Having escaped death only by becoming a Mistborn himself, Emperor Elend Venture now hopes to find clues left behind by the Lord Ruler that will allow him to save the world. But with the return of lethal mists, increasingly heavy ashfalls, and ever more powerful earthquakes, Elend and Vin arent sure that killing the Lord Ruler to end the Final Empire was the right thing to do after all.',
        id: 4),
    Book(
      name: 'Warbreaker',
      author: 'Brandon Sanderson',
      year: '2009',
      coverURL:
          'https://m.media-amazon.com/images/I/81RwObv1RsL._AC_UF1000,1000_QL80_.jpg',
      description:
          'Warbreaker is the story of two sisters who happen to be princesses, the God King one of them has to marry, the lesser god who doesn’t like his job, and the immortal who’s still trying to undo the mistakes he made hundreds of years ago.',
      id: 5,
    ),
    Book(
      name: 'The Way of Kings',
      author: 'Brandon Sanderson',
      year: '2010',
      coverURL:
          'https://m.media-amazon.com/images/I/91UDzcPH-nL._AC_UF1000,1000_QL80_.jpg',
      description:
          'Roshar is a world of stone and storms. Uncanny tempests of incredible power sweep across the rocky terrain so frequently that they have shaped ecology and civilization alike. Animals hide in shells, trees pull in branches, and grass retracts into the soilless ground. Cities are built only where the topography offers shelter.',
      id: 6,
    ),
    Book(
      name: 'Words of Radiance',
      author: 'Brandon Sanderson',
      year: '2014',
      coverURL:
          'https://m.media-amazon.com/images/I/91tECQfrZTL._AC_UF1000,1000_QL80_.jpg',
      description:
          'Brandon Sanderson\'s The Stormlight Archive sequence began in 2010 with the New York Times bestseller The Way of Kings. Now, the eagerly anticipated Words of Radiance continues the epic story and answers many of your questions.',
      id: 7,
    ),
    Book(
      name: 'Death on the Nile',
      author: 'Agatha Christie',
      year: '1937',
      coverURL:
          'https://m.media-amazon.com/images/I/916EaU54GlL._AC_UF1000,1000_QL80_.jpg',
      description:
          'The novel recounts the vacation of Belgian detective Hercule Poirot aboard the Karnak, a tourist boat that travels the Nile River. During the trip, a young heiress is murdered, prompting Poirot to utilize all of his skills to solve the mystery.',
      id: 8,
    ),
    Book(
      name: 'Murder on the Orient Express',
      author: 'Agatha Christie',
      year: '1934',
      coverURL:
          'https://m.media-amazon.com/images/I/81WpR6-y5+L._AC_UF1000,1000_QL80_.jpg',
      description:
          'Murder on the Orient Express is a detective novel by Agatha Christie featuring the Belgian detective Hercule Poirot. The story follows Poirot, who is on a luxurious train trip from Istanbul to Calais, as he investigates the murder of a fellow passenger.',
      id: 9,
    ),
    Book(
      name: 'The Mysterious Affair at Styles',
      author: 'Agatha Christie',
      year: '1920',
      coverURL:
          'https://m.media-amazon.com/images/I/91OPp9ldt9L._AC_UF1000,1000_QL80_.jpg',
      description:
          'The Mysterious Affair at Styles is a detective novel by Agatha Christie. It is Christie\'s first published novel and introduces Hercule Poirot, Inspector (later, Chief Inspector) Japp, and Arthur Hastings. The story is set in Essex in England during World War I, and follows Poirot as he investigates the murder of a wealthy elderly woman in her locked bedroom.',
      id: 10,
    ),
  ];

  @override
  Future<List<Book>> getBooks() async {
    await Future.delayed(const Duration(seconds: 1));
    return listOfBooks;
  }

  @override
  Future<Book?> getBookById(int id) async {
    await Future.delayed(const Duration(seconds: 1));
    return listOfBooks.firstWhereOrNull((element) => element.id == id);
  }

  @override
  Future<int> getBookCount() async {
    await Future.delayed(const Duration(seconds: 1));
    return (listOfBooks.length);
  }

  @override
  Future<int> getNewId() async {
    await Future.delayed(const Duration(seconds: 1));
    if (listOfBooks.isEmpty) {
      return 1;
    }
    int idMaximo = listOfBooks.first.id;
    for (Book book in listOfBooks) {
      if (book.id > idMaximo) {
        idMaximo = book.id;
      }
    }
    return idMaximo + 1;
  }

  @override
  Future<void> insertBook(Book book) async {
    await Future.delayed(const Duration(seconds: 1));
    listOfBooks.add(book);
  }

  @override
  Future<void> updateBook(Book book) async {
    await Future.delayed(const Duration(seconds: 1));
    listOfBooks[listOfBooks.indexWhere((element) => element.id == book.id)] =
        book;
  }

  @override
  Future<void> deleteBook(Book book) async {
    await Future.delayed(const Duration(seconds: 1));
    listOfBooks.remove(book);
  }
}
