// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ios_fl_n_niagarafalls_3424/cubit/custom_waterfall/custom_waterfall_cubit.dart';
import 'package:ios_fl_n_niagarafalls_3424/extension/string_extension.dart';
import 'package:ios_fl_n_niagarafalls_3424/models/custom_waterfall.dart';

class CustomWaterfallDetailScreen extends StatefulWidget {
  final CustomWaterfallEntry entry;

  const CustomWaterfallDetailScreen({super.key, required this.entry});

  @override
  State<CustomWaterfallDetailScreen> createState() =>
      _CustomWaterfallDetailScreenState();
}

class _CustomWaterfallDetailScreenState
    extends State<CustomWaterfallDetailScreen> {
  String? _userMark;

  void _showDeleteDialog() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: const Color(0xFF2D6939),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text(
              'Delete Entry',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text(
              'Are you sure you want to delete this entry?',
              style: TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red, fontSize: 16.0),
                ),
              ),
            ],
          ),
    );

    if (shouldDelete == true) {
      final cubit = context.read<CustomWaterfallEntryCubit>();
      await cubit.deleteEntry(widget.entry);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final e = widget.entry;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.file(
                File(e.imagePath ?? ''),
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 50,
                left: 16,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
              Positioned(
                top: 50,
                right: 16,
                child: Row(
                  children: [
                    if (_userMark != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          _userMark!.toTitleCase(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                    SizedBox(width: 12),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: _showDeleteDialog,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Wrap(
                  spacing: 12,
                  children: [
                    ...e.emotions.map((e) => _tag(e)),
                    if (e.weather != null) _tag(e.weather!),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _infoRow('Date', DateFormat('dd.MM.yyyy').format(e.date)),
                  if (e.location.isNotEmpty) _infoRow('Location', e.location),
                  _infoRow('Description', e.description),
                  _buildStars('Emotion Intensity', e.emotionIntensity),
                  SizedBox(height: 12),
                  if (e.impressionTypes.isNotEmpty)
                    _infoRow('Impression Type', e.impressionTypes.join(", ")),
                  if (e.addToBestMoments)
                    Row(
                      children: [
                        Checkbox(
                          value: true,
                          onChanged: null,
                          side: const BorderSide(
                            color: Color(0xFFFEC20C),
                            width: 2,
                          ),
                          activeColor: const Color(0xFFFEC20C),
                          checkColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const Text(
                          'Add to "Best Moments"',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: ElevatedButton(
              onPressed: () {
                _showMarkAsSheet(
                  context,
                  _userMark != null ? [_userMark!] : [],
                  (selected) {
                    setState(() {
                      _userMark = selected.isEmpty ? null : selected.first;
                    });
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFEC20C),
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Mark as',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Color(0xFFBABABA), fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStars(String label, int count) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(color: Color(0xFFBABABA), fontSize: 14),
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(5, (index) {
            final isFilled = index < count;
            return Icon(
              isFilled ? Icons.star : Icons.star_border,
              color: const Color(0xFFFEC20C),
            );
          }),
        ),
      ],
    );
  }

  Widget _tag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.black, fontSize: 14),
      ),
    );
  }

  void _showMarkAsSheet(
    BuildContext context,
    List<String> selectedCategories,
    Function(List<String>) onApply,
  ) {
    final options = ['Visited', 'In the plans'];
    final lowerOptions = options.map((e) => e.toLowerCase()).toList();
    final selected = Set<String>.from(selectedCategories);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: const Color(0xFF2D6939),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mark as',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...lowerOptions.map((category) {
                    return Row(
                      children: [
                        Checkbox(
                          value: selected.contains(category),
                          onChanged: (bool? checked) {
                            setState(() {
                              selected.clear();
                              if (checked == true) selected.add(category);
                            });
                          },
                          side: const BorderSide(
                            color: Color(0xFFFEC20C),
                            width: 2,
                          ),
                          activeColor: const Color(0xFFFEC20C),
                          checkColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          category[0].toUpperCase() + category.substring(1),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed:
                              selected.isEmpty
                                  ? null
                                  : () {
                                    Navigator.pop(context);
                                    onApply(selected.toList());
                                  },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                selected.isEmpty
                                    ? Color(0xFF676767)
                                    : const Color(0xFFFEC20C),
                            foregroundColor: Colors.black,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            'Apply',
                            style: TextStyle(
                              fontSize: 18,
                              color:
                                  selected.isEmpty
                                      ? Color(0xFF9C9C9C)
                                      : Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          selected.clear();
                        });
                        Navigator.pop(context);
                        onApply([]);
                      },
                      child: const Text(
                        'Clear filters',
                        style: TextStyle(
                          color: Color(0xFFFEC20C),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
