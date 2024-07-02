import 'package:collection/collection.dart';
import 'package:guia_de_lectura/domain/book.dart';

class BookRepository {
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

// final List<Book> listOfBooks = [
//   Book(
//     title: 'El Imperio Final',
//     year: '2006',
//     saga: 'Mistborn',
//     coverURL: '',
//     description:
//         'Durante mil años ha caído la ceniza y no han florecido las flores. Durante mil años, los Skaa han sido esclavizados en la miseria y han vivido con miedo. Durante mil años, el Lord Legislador ha reinado con poder absoluto y terror supremo. Hasta que Kelsier, un brillante ladrón medio Skaa y líder natural, descubre en sí mismo los poderes de un Mistborn, y dirige sus talentos hacia el golpe supremo, con el propio Lord Legislador como objetivo.',
//     id: '1',
//     order: 1,
//   ),
//   Book(
//     title: 'El Pozo de la Ascension',
//     year: '2007',
//     saga: 'Mistborn',
//     coverURL: '',
//     description:
//         'Tras derrocar al Lord Legislador, Vin y Elend Venture son ahora los gobernantes de Luthadel. Sin embargo, la paz es frágil y nuevas amenazas surgen mientras intentan construir un nuevo orden en el imperio.',
//     id: '2',
//     order: 2,
//   ),
//   Book(
//     title: 'El Heroe de las Eras',
//     year: '2008',
//     saga: 'Mistborn',
//     coverURL: '',
//     description:
//         'Vin y Elend se enfrentan al desafío definitivo mientras luchan por salvar su mundo de la destrucción total. Los secretos del Lord Legislador y la verdadera naturaleza de los metales de alomancia se revelan en este épico final de la trilogía de Mistborn.',
//     id: '3',
//     order: 3,
//   ),
//   Book(
//     title: 'Aleacion de Ley',
//     year: '2011',
//     saga: 'Mistborn',
//     coverURL: '',
//     description:
//         'Cientos de años después de los eventos de la trilogía original de Mistborn, la tecnología ha progresado y la magia de la alomancia y la feruquimia evoluciona en un nuevo escenario. Waxillium Ladrian, un noble y alomántico, investiga crímenes en la bulliciosa ciudad de Elendel.',
//     id: '4',
//     order: 18,
//   ),
//   Book(
//     title: 'Sombras de Identidad',
//     year: '2015',
//     saga: 'Mistborn',
//     coverURL: '',
//     description:
//         'Waxillium Ladrian debe enfrentarse a misterios y conspiraciones más oscuros que nunca en la continuación de la serie de Mistborn, mientras el mundo alomántico se expande y los personajes se enfrentan a desafíos personales y globales.',
//     id: '5',
//     order: 19,
//   ),
//   Book(
//     title: 'Brazales de Duelo',
//     year: '2016',
//     saga: 'Mistborn',
//     coverURL: '',
//     description:
//         'Wax y Wayne regresan en otra emocionante aventura en la ciudad de Elendel. Mientras lidian con los desafíos de la política y la tecnología, también descubren nuevos misterios sobre el pasado y el futuro de Scadrial.',
//     id: '6',
//     order: 20,
//   ),
//   Book(
//     title: 'Historia Secreta',
//     year: '2016',
//     saga: 'Mistborn',
//     coverURL: '',
//     description:
//         'Este relato sigue a Kelsier en el más allá, explorando eventos y revelaciones que impactan la trilogía original de Mistborn desde una perspectiva totalmente nueva.',
//     id: '7',
//     order: 21,
//   ),
//   Book(
//     title: 'El Metal Perdido',
//     year: '2022',
//     saga: 'Mistborn',
//     coverURL: '',
//     description:
//         'Waxillium Ladrian, ahora senador, se ve envuelto en un conflicto entre Elendel y las Ciudades Exteriores. Si no puede dejar de lado su difícil relación con Armonía y convertirse en su espada, una calamidad de proporciones sin precedentes puede desencadenarse en Scadrial.',
//     id: '8',
//     order: 22,
//   ),
//   Book(
//     title: 'El Undecimo Metal',
//     year: '2011',
//     saga: 'Mistborn',
//     coverURL: '',
//     description:
//         'Cuenta la historia de cómo Gemmel enseña a Kelsier el arte de la alomancia. Viajan a Mantiz y atacan la fortaleza Shezler. Allí, Kelsier descubre que Antillius Shezler ha estado buscando mestizos skaa y torturándolos, esperando que Rompan y después dándoles metales para encontrar el undécimo metal.',
//     id: '9',
//     order: 17,
//   ),
//   Book(
//     title: 'El Camino de los Reyes',
//     year: '2010',
//     saga: 'El Archivo de las Tormentas',
//     coverURL: '',
//     description:
//         'En el mundo de Roshar, una guerra inminente amenaza con desatar fuerzas ancestrales. En medio de la tormenta, surge un asesino legendario y una joven que busca la verdad sobre su pasado, desencadenando eventos que podrían cambiar el mundo.',
//     id: '10',
//     order: 5,
//   ),
//   Book(
//     title: 'Palabras Radiantes',
//     year: '2014',
//     saga: 'El Archivo de las Tormentas',
//     coverURL: '',
//     description:
//         'Los secretos de Roshar se profundizan mientras los personajes enfrentan desafíos personales y políticos. Las antiguas órdenes de los Caballeros Radiantes resurgen, y la guerra amenaza con consumir todo lo que han conocido.',
//     id: '11',
//     order: 6,
//   ),
//   Book(
//     title: 'Danzante del Filo',
//     year: '2016',
//     saga: 'El Archivo de las Tormentas',
//     coverURL: '',
//     description:
//         'Tres años atrás, Lift le pidió a una diosa que detuviese su envejecimiento, un deseo que ella creía concedido. Ahora, la apenas adolescente y recién Caballera Radiante descubre que el tiempo no se detiene para nadie.',
//     id: '12',
//     order: 7,
//   ),
//   Book(
//     title: 'Juramentada',
//     year: '2017',
//     saga: 'El Archivo de las Tormentas',
//     coverURL: '',
//     description:
//         'Con el regreso de los Caballeros Radiantes, la lucha por el futuro de Roshar se intensifica. Mientras tanto, nuevas conspiraciones y amenazas emergen, llevando a los personajes al límite de sus habilidades y lealtades.',
//     id: '13',
//     order: 8,
//   ),
//   Book(
//     title: 'Esquirla del Amanecer',
//     year: '2021',
//     saga: 'El Archivo de las Tormentas',
//     coverURL: '',
//     description:
//         'Tras el descubrimiento de un barco fantasma, cuya tripulación al parecer murió intentando llegar a la isla de Akinah, rodeada por tormentas, Navani Kholin deberá enviar una expedición para asegurarse de que la isla no haya caído en manos enemigas. Los Caballeros Radiantes que vuelan demasiado cerca de Akinah se encuentran de pronto con su luz tormentosa drenada, por lo que la travesía debe realizarse por mar.',
//     id: '14',
//     order: 9,
//   ),
//   Book(
//     title: 'El Ritmo de la Guerra',
//     year: '2020',
//     saga: 'El Archivo de las Tormentas',
//     coverURL: '',
//     description:
//         'La guerra en Roshar alcanza su punto álgido mientras los protagonistas enfrentan decisiones difíciles y descubren verdades impactantes sobre el pasado de su mundo y sus propios destinos.',
//     id: '15',
//     order: 10,
//   ),
//   Book(
//     title: 'Elantris',
//     year: '2005',
//     coverURL: '',
//     description:
//         'En la ciudad de Elantris, los habitantes son transformados en seres decrépitos con una maldición inexplicable. Raoden, príncipe de Arelon, se ve atrapado en este destino junto a otros personajes que buscan desentrañar el misterio que rodea a la ciudad caída.',
//     id: '16',
//     order: 12,
//   ),
//   Book(
//     title: 'La Esperanza de Elantris',
//     year: '2006',
//     coverURL: '',
//     description:
//         'El libro está ambientado en el mundo de Elantris y ocurre al mismo tiempo que ciertos acontecimientos del libro, pero se centra en personajes diferentes.',
//     id: '17',
//     order: 13,
//   ),
//   Book(
//     title: 'El Alma del Emperador',
//     year: '2012',
//     coverURL: '',
//     description:
//         'Narra la historia de una mujer llamada Shai, ladrona y falsificadora, una persona capaz de reescribir el pasado de los objetos para cambiar su presente. Comienza en prisión pero, en lugar de ser ejecutada, se le ofrece una oportunidad. El emperador ha sido herido en la cabeza por unos asesinos y ha entrado en estado vegetativo. Sus ayudantes lo han ocultado al imperio y le ofrecerán a Shai su vida a cambio de crear una falsificación del alma del emperador, con la esperanza de que parezca que el atentado contra su vida nunca ocurrió.',
//     id: '18',
//     order: 11,
//   ),
//   Book(
//     title: 'El Aliento de los Dioses',
//     year: '2009',
//     coverURL: '',
//     description:
//         'En Hallandren, los colores son magia y la vida se mueve al ritmo de la respiración de los dioses. Cuando la princesa Siri se ve obligada a casarse con el dios rey de Idris, Vivenna se embarca en una misión para rescatar a su hermana. Ambas descubren secretos que podrían cambiar sus destinos y los de sus reinos.',
//     id: '19',
//     order: 4,
//   ),
//   Book(
//     title: 'Arena Blanca',
//     year: '2016',
//     coverURL: '',
//     description:
//         'En el mundo de Taldain, la arena blanca controla la magia y los secretos del pasado. Kenton, un maestro de la arena, debe luchar contra la traición y la conspiración mientras intenta salvar a su gente de la destrucción.',
//     id: '20',
//     order: 16,
//   ),
//   Book(
//     title: 'Sexto del Ocaso',
//     year: '2014',
//     coverURL: '',
//     description:
//         'La historia sigue a un trampero llamado Sexto del Ocaso en su esfuerzo por salvar su isla natal de un peligro catastrófico del que le han advertido, pero que no comprende.',
//     id: '21',
//     order: 14,
//   ),
//   Book(
//     title: 'Sombras por Silencio en los Bosques del Infierno',
//     year: '2013',
//     coverURL: '',
//     description:
//         'La historia sigue a Silencio Montane, propietaria de una posada en los bosques del infierno e identidad secreta del legendario cazarrecompensas conocido como «Zorro Blanco». Desesperada por seguir siendo solvente y mantener su posada fuera del alcance de su acreedor Theopolis, acepta el reto de dar caza a Chesterton Divide, un famoso asaltante de caminos, y a su banda. ',
//     id: '22',
//     order: 15,
//   ),
//   Book(
//     title: 'Trenza del Mar Esmeralda',
//     year: '2023',
//     coverURL: '',
//     description:
//         'En una isla en el medio del Mar de Esporas, Trenza lleva una vida tranquila. Pero todo cambia cuando su querido Charlie es secuestrado por la peligrosa hechicera, y Trenza decide embarcarse junto a piratas para ir a rescatarlo.',
//     id: '23',
//     order: 23,
//   ),
//   Book(
//     title: 'Yumi y el Pintor de Pesadillas',
//     year: '2023',
//     coverURL: '',
//     description:
//         'Yumi y Pintor son dos jóvenes que llevan vidas muy distintas en dos lugares muy distintos. Cuando sus destinos son atados mágicamente y comienzan a intercambiar cuerpos, deberán comprender la vida del otro para salvar a sus ciudades.',
//     id: '24',
//     order: 24,
//   ),
//   Book(
//     title: 'El Hombre Iluminado',
//     year: '2023',
//     coverURL: '',
//     description:
//         'Años atrás tenía compañeros de armas y una causa en la que creer, pero ahora el hombre que se hace llamar a sí mismo Nomad solo conoce una vida huyendo. Forzado a saltar de mundo en mundo dentro del Cosmere, cada vez que la implacable «Night Brigade» se acerca demasiado, Nomad acaba llegando a un nuevo planeta donde se ve inmediatamente envuelto en una contienda entre un tirano y unos rebeldes.',
//     id: '25',
//     order: 25,
//   ),
// ];
