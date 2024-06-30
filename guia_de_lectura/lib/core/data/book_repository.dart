import 'package:collection/collection.dart';
import 'package:guia_de_lectura/domain/book.dart';

class BookRepository {
  // final List<Book> listOfBooks = [
  //   Book(
  //       title: "Elantris",
  //       year: "2005",
  //       coverURL:
  //           "https://http2.mlstatic.com/D_NQ_NP_981299-MLU70052642116_062023-O.webp",
  //       description:
  //           'Elantris was the capital of Arelon: gigantic, beautiful, literally radiant, filled with benevolent beings who used their powerful magical abilities for the benefit of all. Yet each of these demigods was once an ordinary person until touched by the mysterious transforming power of the Shaod. Ten years ago, without warning, the magic failed. Elantrians became wizened, leper-like, powerless creatures, and Elantris itself dark, filthy, and crumbling.',
  //       id: 1,
  //       order: 1),
  //   Book(
  //       title: 'Mistborn I: El Imperio Final',
  //       year: '2006',
  //       coverURL:
  //           'https://m.media-amazon.com/images/I/91U6rc7u0yL._AC_UF1000,1000_QL80_.jpg',
  //       description:
  //           'For a thousand years, the ash has fallen and no flowers have bloomed. For a thousand years, the Skaa have slaved in misery and lived in fear. For a thousand years, the Lord Ruler has reigned with absolute power and ultimate terror. Until Kelsier, a brilliant half-Skaa thief and natural leader, finds in himself the powers of a Mistborn, and turns his talents to the ultimate caper, with the Lord Ruler himself as the mark.',
  //       id: 2,
  //       order: 2),
  //   Book(
  //       title: "Mistborn II: The Well of Ascension",
  //       year: "2007",
  //       coverURL:
  //           "https://prodimage.images-bn.com/pimages/9781250868299_p0_v2_s1200x630.jpg",
  //       description:
  //           'The impossible task has been accomplished. The Lord Ruler has been vanquished. But with Kelsier dead, too, the awesome task of building a new world has been left to former street urchin and Kelsiers protégé Vin, who is now the most powerful Mistborn in the land. Vin is now worshipped as a hero in her own right, but she is haunted by a strange vaporous entity hidden in the mists.',
  //       id: 3,
  //       order: 3),
  //   Book(
  //       title: 'Mistborn III: The Hero of Ages',
  //       year: '2008',
  //       coverURL: 'https://m.media-amazon.com/images/I/51DZcL07ZUL.jpg',
  //       description:
  //           'Having escaped death only by becoming a Mistborn himself, Emperor Elend Venture now hopes to find clues left behind by the Lord Ruler that will allow him to save the world. But with the return of lethal mists, increasingly heavy ashfalls, and ever more powerful earthquakes, Elend and Vin arent sure that killing the Lord Ruler to end the Final Empire was the right thing to do after all.',
  //       id: 4,
  //       order: 4),
  //   Book(
  //     title: 'Warbreaker',
  //     year: '2009',
  //     coverURL:
  //         'https://m.media-amazon.com/images/I/81RwObv1RsL._AC_UF1000,1000_QL80_.jpg',
  //     description:
  //         'Warbreaker is the story of two sisters who happen to be princesses, the God King one of them has to marry, the lesser god who doesn’t like his job, and the immortal who’s still trying to undo the mistakes he made hundreds of years ago.',
  //     id: 5,
  //     order: 5,
  //   ),
  //   Book(
  //     title: 'The Way of Kings',
  //     year: '2010',
  //     coverURL:
  //         'https://m.media-amazon.com/images/I/91UDzcPH-nL._AC_UF1000,1000_QL80_.jpg',
  //     description:
  //         'Roshar is a world of stone and storms. Uncanny tempests of incredible power sweep across the rocky terrain so frequently that they have shaped ecology and civilization alike. Animals hide in shells, trees pull in branches, and grass retracts into the soilless ground. Cities are built only where the topography offers shelter.',
  //     id: 6,
  //     order: 6,
  //   ),
  //   Book(
  //     title: 'Words of Radiance',
  //     year: '2014',
  //     coverURL:
  //         'https://m.media-amazon.com/images/I/91tECQfrZTL._AC_UF1000,1000_QL80_.jpg',
  //     description:
  //         'Brandon Sanderson\'s The Stormlight Archive sequence began in 2010 with the New York Times bestseller The Way of Kings. Now, the eagerly anticipated Words of Radiance continues the epic story and answers many of your questions.',
  //     id: 7,
  //     order: 7,
  //   ),
  // ];
  late final List<Book> listOfBooks;

  BookRepository.fromList(this.listOfBooks);

  BookRepository.emptyRepository() {
    listOfBooks = [];
  }

  List<Book> getBooks() {
    return listOfBooks;
  }

  Book? getBookById(int id) {
    return listOfBooks.firstWhereOrNull((element) => element.id == id);
  }

  int getBookCount() {
    return (listOfBooks.length);
  }

  Book? getBookByTitle(String title) {
    return listOfBooks.firstWhereOrNull((element) => element.title == title);
  }

  // Método para obtener el libro anterior al book recibido según su order
  Book? getPreviousBook(Book book) {
    Book? previousBook;
    int closestOrderDiff = -1;

    for (var b in listOfBooks) {
      if (b.order < book.order) {
        int diff = book.order - b.order;
        if (closestOrderDiff == -1 || diff < closestOrderDiff) {
          closestOrderDiff = diff;
          previousBook = b;
        }
      }
    }
    return previousBook;
  }

  // Método para obtener el libro siguiente al book recibido según su order
  Book? getNextBook(Book book) {
    Book? nextBook;
    int closestOrderDiff = -1;

    for (var b in listOfBooks) {
      if (b.order > book.order) {
        int diff = b.order - book.order;
        if (closestOrderDiff == -1 || diff < closestOrderDiff) {
          closestOrderDiff = diff;
          nextBook = b;
        }
      }
    }
    return nextBook;
  }
}
