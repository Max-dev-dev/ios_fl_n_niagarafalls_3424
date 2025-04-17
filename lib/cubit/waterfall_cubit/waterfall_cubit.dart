import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:ios_fl_n_niagarafalls_3424/models/waterfalls_model.dart';
import 'package:logger/logger.dart';

class FallsCubit extends Cubit<List<WaterfallModel>> {
  FallsCubit() : super([]);

  final logger = Logger();

  Future<void> loadFalls() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/falls.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final falls = FallsModel.fromJson(jsonData);
      logger.i('Parsed ${falls.items.length} waterfall items');
      emit(falls.items);
    } catch (e) {
      logger.e('Error loading falls.json: $e');
    }
  }
}
