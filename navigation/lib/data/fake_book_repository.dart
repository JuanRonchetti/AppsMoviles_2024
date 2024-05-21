import 'package:collection/collection.dart';
import 'package:navigation/core/entities/book.dart';
import 'package:navigation/data/book_repository.dart';

class FakeBookRepository implements BookRepository {
  final List<Book> listOfBooks = [
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
        id: 4)
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
}
