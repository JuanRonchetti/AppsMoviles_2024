import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:guia_de_lectura/domain/book.dart';

class MyUserBookStatus {
  String bookTitle;
  String status;
  bool isFavorite;

  MyUserBookStatus({
    this.bookTitle = '',
    this.status = 'Pendiente', // Otros estados: Leyendo, Leido
    this.isFavorite = false,
  });

  // Método para convertir a un mapa para Firestore
  Map<String, dynamic> toMap() {
    return {
      'bookTitle': bookTitle,
      'status': status,
      'isFavorite': isFavorite,
    };
  }

  // Método estático para convertir desde un mapa
  static MyUserBookStatus fromMap(Map<String, dynamic> map) {
    return MyUserBookStatus(
      bookTitle: map['bookTitle'],
      status: map['status'],
      isFavorite: map['isFavorite'],
    );
  }
}

class MyUser {
  String id;
  String username;
  String email;
  List<MyUserBookStatus>? bookStatusList;

  MyUser({
    required this.id,
    required this.username,
    required this.email,
    this.bookStatusList,
  });

  // Crea la lista de info
  void createBookStatusList(List<Book> listOfBooks) {
    bookStatusList = listOfBooks.map((book) {
      return MyUserBookStatus(bookTitle: book.title);
    }).toList();
  }

  // Si se inicializo la lista
  bool get hasBookStatusList {
    return bookStatusList != null;
  }

  // Actualizo un elemento de la lista
  void updateUserBookStatus(MyUserBookStatus status) {
    // Si no hay lista, salir sin hacer nada
    if (bookStatusList == null) {
      return;
    } else {
      // Buscar el UserBookStatus correspondiente y actualizarlo si existe
      for (int i = 0; i < bookStatusList!.length; i++) {
        if (bookStatusList![i].bookTitle == status.bookTitle) {
          bookStatusList![i] = status;
          return;
        }
      }
    }
  }

  // Obtengo el userbookstatus de un libro
  MyUserBookStatus? getUserBookStatus(Book book) {
    // Si no hay lista, salir sin hacer nada
    if (bookStatusList == null) {
      return null;
    } else {
      MyUserBookStatus? status = bookStatusList!
          .firstWhereOrNull((bookStatus) => bookStatus.bookTitle == book.title);
      return status;
    }
  }

  // Función para obtener el valor de isFavorite de un libro por su título
  bool? getIsFavoriteByBookTitle(String bookTitle) {
    if (bookStatusList == null) return null;

    MyUserBookStatus? bookStatus = bookStatusList!
        .firstWhereOrNull((status) => status.bookTitle == bookTitle);

    return (bookStatus != null) ? bookStatus.isFavorite : null;
  }

  // Función para obtener el valor de status de un libro por su título
  String? getStatusByBookTitle(String bookTitle) {
    if (bookStatusList == null) return null;

    MyUserBookStatus? bookStatus = bookStatusList!
        .firstWhereOrNull((status) => status.bookTitle == bookTitle);

    return (bookStatus != null) ? bookStatus.status : null;
  }

  // Método para convertir a un mapa para Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'bookStatusList':
          bookStatusList?.map((status) => status.toMap()).toList(),
    };
  }

  // Método estático para convertir desde un mapa
  static MyUser fromMap(Map<String, dynamic> map) {
    return MyUser(
        id: map['id'],
        username: map['username'],
        email: map['email'],
        bookStatusList: (map['bookStatusList'] as List<dynamic>?)
            ?.map((status) => MyUserBookStatus.fromMap(status))
            .toList());
  }

  static Future<MyUser?> getfromFirestore(String userId) async {
    try {
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      final userDocSnapshot = await userDocRef.get();

      if (userDocSnapshot.exists) {
        final userData = userDocSnapshot.data() as Map<String, dynamic>;

        // Recupera la subcolección bookStatusList
        final querySnapshot =
            await userDocRef.collection('bookStatusList').get();
        List<MyUserBookStatus>? bookStatusList = querySnapshot.docs.map((doc) {
          return MyUserBookStatus.fromMap(doc.data());
        }).toList();

        return MyUser(
          id: userData['id'],
          username: userData['username'],
          email: userData['email'],
          bookStatusList: bookStatusList,
        );
      } else {
        // print('El usuario con ID $userId no existe en Firestore.');
        return null;
      }
    } catch (e) {
      // print('Error al obtener usuario desde Firestore: $e');
      return null;
    }
  }

  MyUser copyWith({
    String? id,
    String? username,
    String? email,
    MyUserBookStatus? updatedBookStatus,
  }) {
    // Crear una copia de la lista actual de bookStatusList
    List<MyUserBookStatus>? updatedList = List.from(bookStatusList ?? []);

    // Buscar y actualizar el elemento en la lista según el bookTitle
    if (updatedBookStatus != null) {
      int index = updatedList.indexWhere(
          (status) => status.bookTitle == updatedBookStatus.bookTitle);
      if (index != -1) {
        updatedList[index] = updatedBookStatus;
      } else {
        // Si no se encuentra el elemento, agregarlo a la lista
        updatedList.add(updatedBookStatus);
      }
    }

    return MyUser(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      bookStatusList: updatedList.isEmpty ? null : updatedList,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'bookStatusList':
          bookStatusList?.map((status) => status.toMap()).toList(),
    };
  }

  // Función para guardar en Firestore
  static Future<void> saveToFirestore(MyUser user) async {
    try {
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(user.id);

      // Convertir MyUser a un mapa para Firestore
      Map<String, dynamic> userData = user.toFirestore();

      // Guardar el documento principal
      await userDocRef.set(userData);

      // Guardar subcolección bookStatusList si existe
      if (user.bookStatusList != null) {
        final batch = FirebaseFirestore.instance.batch();
        final bookStatusListRef = userDocRef.collection('bookStatusList');

        // Eliminar documentos existentes antes de guardar los nuevos
        final deleteBatch = FirebaseFirestore.instance.batch();
        final existingDocs = await bookStatusListRef.get();
        for (var doc in existingDocs.docs) {
          deleteBatch.delete(doc.reference);
        }
        await deleteBatch.commit();

        // Guardar nuevos documentos
        user.bookStatusList!.forEach((status) {
          final docRef = bookStatusListRef.doc(status.bookTitle);
          batch.set(docRef, status.toMap());
        });

        await batch.commit();
      }
    } catch (e) {
      // throw e; // Puedes manejar el error según tu lógica
      return;
    }
  }
}
