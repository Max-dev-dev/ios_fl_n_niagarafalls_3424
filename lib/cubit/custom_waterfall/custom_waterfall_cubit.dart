import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_fl_n_niagarafalls_3424/models/custom_waterfall.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CustomWaterfallEntryCubit extends Cubit<List<CustomWaterfallEntry>> {
  CustomWaterfallEntryCubit() : super([]);

  Future<void> loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList('custom_waterfall_entries') ?? [];
    final parsed =
        rawList
            .map((e) => CustomWaterfallEntry.fromJson(json.decode(e)))
            .toList();
    emit(parsed);
  }

  Future<void> addEntry(CustomWaterfallEntry entry) async {
    final updated = [...state, entry];
    emit(updated);
    await _save(updated);
  }

  Future<void> _save(List<CustomWaterfallEntry> entries) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = entries.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList('custom_waterfall_entries', encoded);
  }

  Future<void> clearAll() async {
    emit([]);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('custom_waterfall_entries');
  }

  Future<void> deleteEntry(CustomWaterfallEntry entry) async {
    final updated = List<CustomWaterfallEntry>.from(state)..remove(entry);
    emit(updated);
    await _save(updated);
  }
}
