import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';

StateProvider<PhotoViewControllerBase> photoviewControllerProvider =
    StateProvider<PhotoViewControllerBase>((ref) => PhotoViewController());
