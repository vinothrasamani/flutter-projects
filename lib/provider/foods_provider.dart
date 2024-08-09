import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods/data/data_instances.dart';

final foodProvider = Provider((ref) {
  return dummyDetails;
});
