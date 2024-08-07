import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guia_de_lectura/domain/user.dart';

final myUserNotifierProvider =
    StateNotifierProvider<MyUserNotifier, MyUser>((ref) => MyUserNotifier());

class MyUserNotifier extends StateNotifier<MyUser> {
  MyUserNotifier() : super(MyUser(id: '', username: '', email: ''));

  void setUser(MyUser newUser) {
    state = newUser;
  }

  void updateUserBookStatus(MyUserBookStatus newBookStatus) {
    state = state.copyWith(updatedBookStatus: newBookStatus);
  }
}

StateProvider<MyUserBookStatus> initialStatusProvider =
    StateProvider<MyUserBookStatus>((ref) => MyUserBookStatus());
