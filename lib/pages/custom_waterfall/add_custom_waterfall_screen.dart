import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ios_fl_n_niagarafalls_3424/cubit/custom_waterfall/custom_waterfall_cubit.dart';
import 'package:ios_fl_n_niagarafalls_3424/models/custom_waterfall.dart';
import 'package:intl/intl.dart';

class AddCustomWaterfallScreen extends StatefulWidget {
  const AddCustomWaterfallScreen({super.key});

  @override
  State<AddCustomWaterfallScreen> createState() =>
      _AddCustomWaterfallScreenState();
}

class _AddCustomWaterfallScreenState extends State<AddCustomWaterfallScreen> {
  DateTime _selectedDate = DateTime.now();
  String? _imagePath;
  final TextEditingController _title = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _description = TextEditingController();

  final List<String> _emotions = [];
  int _intensity = 0;
  String? _weather;
  final List<String> _impressionTypes = [];
  bool _addToBestMoments = false;

  void _saveEntry() {
    if (_title.text.trim().isEmpty) return;

    final entry = CustomWaterfallEntry(
      date: _selectedDate,
      imagePath: _imagePath,
      title: _title.text.trim(),
      location: _location.text.trim(),
      description: _description.text.trim(),
      emotions: _emotions,
      emotionIntensity: _intensity,
      weather: _weather,
      impressionTypes: _impressionTypes,
      addToBestMoments: _addToBestMoments,
    );

    context.read<CustomWaterfallEntryCubit>().addEntry(entry);
    Navigator.pop(context);
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: const Text(
          'Add entry',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 20),
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    'assets/images/waterfall.png',
                    width: 150,
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData.dark().copyWith(
                              colorScheme: const ColorScheme.dark(
                                primary: Color(0xFFFEC20C),
                                surface: Color(0xFF2D6939),
                                onSurface: Colors.white,
                              ),
                              dialogBackgroundColor: Color(0xFF2D6939),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (picked != null) {
                        setState(() {
                          _selectedDate = picked;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3A8C60),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 18,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            DateFormat('MMMM dd, yyyy').format(_selectedDate),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: 100,
              height: 200,
              decoration: BoxDecoration(
                color: const Color(0xFF3A8C60),
                borderRadius: BorderRadius.circular(16),
              ),
              child:
                  _imagePath == null
                      ? const Icon(Icons.image, color: Colors.white, size: 40)
                      : ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(File(_imagePath!), fit: BoxFit.cover),
                      ),
            ),
          ),

          const SizedBox(height: 16),
          _buildTextField(_title, 'Entry Title'),
          _buildTextField(_location, 'Location'),
          _buildTextField(_description, 'Description', maxLines: 4),

          const SizedBox(height: 16),
          _buildChips('Emotions', [
            '😊Joy',
            '🧘Calm',
            '😢Sadness',
            '🌟Inspiration',
          ], _emotions),
          _buildStars('Emotion Intensity', 5),
          _buildChips(
            'Weather',
            ['☀️Sunny', '🌧️Rainy', '⛅Cloudy', '❄️Snowy'],
            [_weather],
            single: true,
          ),
          _buildCheckboxGroup('Impression Type', [
            'Visual',
            'Auditory',
            'Meditative',
          ], _impressionTypes),
          Row(
            children: [
              Checkbox(
                value: _addToBestMoments,
                onChanged:
                    (val) => setState(() => _addToBestMoments = val ?? false),
                side: const BorderSide(color: Color(0xFFFEC20C), width: 2),
                activeColor: const Color(0xFFFEC20C),
                checkColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Add to "Best Moments"',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),

          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _title.text.trim().isEmpty ? null : _saveEntry,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  _title.text.trim().isEmpty
                      ? Colors.grey
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
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF3A8C60),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        cursorColor: Colors.white,
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFFBABABA)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          border: InputBorder.none,
        ),
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  Widget _buildChips(
    String label,
    List<String> options,
    List<String?> selected, {
    bool single = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(label, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children:
              options.map((e) {
                final isSelected = selected.contains(e);
                return ChoiceChip(
                  label: Text(e),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      if (single) {
                        selected.clear();
                        selected.add(e);
                        _weather = e;
                      } else {
                        isSelected ? selected.remove(e) : selected.add(e);
                      }
                    });
                  },
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.black : Colors.white,
                  ),
                  selectedColor: const Color(0xFFFEC20C),
                  backgroundColor: const Color(0xFF3A8C60),
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget _buildCheckboxGroup(
    String label,
    List<String> options,
    List<String> selected,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(label, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 8),
        ...options.map((category) {
          return Row(
            children: [
              Checkbox(
                value: selected.contains(category),
                onChanged: (bool? checked) {
                  setState(() {
                    checked!
                        ? selected.add(category)
                        : selected.remove(category);
                  });
                },
                side: const BorderSide(color: Color(0xFFFEC20C), width: 2),
                activeColor: const Color(0xFFFEC20C),
                checkColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                category,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget _buildStars(String label, int count) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(label, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 4),
        Row(
          children: List.generate(count, (index) {
            final isFilled = index < _intensity;
            return IconButton(
              onPressed: () => setState(() => _intensity = index + 1),
              icon: Icon(
                isFilled ? Icons.star : Icons.star_border,
                color: isFilled ? const Color(0xFFFEC20C) : Colors.white,
              ),
            );
          }),
        ),
      ],
    );
  }
}
