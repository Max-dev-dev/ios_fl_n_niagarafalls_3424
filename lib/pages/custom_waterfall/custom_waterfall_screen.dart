import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_fl_n_niagarafalls_3424/cubit/custom_waterfall/custom_waterfall_cubit.dart';
import 'package:ios_fl_n_niagarafalls_3424/models/custom_waterfall.dart';
import 'package:ios_fl_n_niagarafalls_3424/pages/custom_waterfall/add_custom_waterfall_screen.dart';
import 'package:ios_fl_n_niagarafalls_3424/pages/custom_waterfall/custom_waterfall_detail_screen.dart';

class CustomWaterfallScreen extends StatefulWidget {
  const CustomWaterfallScreen({super.key});

  @override
  State<CustomWaterfallScreen> createState() => _CustomWaterfallScreenState();
}

class _CustomWaterfallScreenState extends State<CustomWaterfallScreen> {
  @override
  void initState() {
    context.read<CustomWaterfallEntryCubit>().loadEntries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Flow-journal',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<
                CustomWaterfallEntryCubit,
                List<CustomWaterfallEntry>
              >(
                builder: (context, entries) {
                  if (entries.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 100.0),
                          const Text(
                            "There's nothing here yet",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 100),
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      final entry = entries[index];
                      return GestureDetector(
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => CustomWaterfallDetailScreen(
                                      entry: entry,
                                    ),
                              ),
                            ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2B7A52),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: FutureBuilder<bool>(
                                    future:
                                        File(entry.imagePath ?? '').exists(),
                                    builder: (context, snapshot) {
                                      final exists = snapshot.data ?? false;
                                      if (exists) {
                                        return Image.file(
                                          File(entry.imagePath!),
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        );
                                      } else {
                                        return Image.asset(
                                          'assets/images/waterfall.png',
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        );
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'best moments',
                                        style: TextStyle(
                                          color: Color(0xFFFEC20C),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Color(0xFFFEC20C),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        entry.title,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        entry.description,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Color(0xFFEEEEEE),
                                          fontSize: 14,
                                          height: 1.4,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: List.generate(5, (i) {
                                          final isFilled =
                                              i < entry.emotionIntensity;
                                          return Icon(
                                            isFilled
                                                ? Icons.star
                                                : Icons.star_border,
                                            size: 20,
                                            color: const Color(0xFFFEC20C),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddCustomWaterfallScreen(),
                  ),
                );
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFEC20C),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Add',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
