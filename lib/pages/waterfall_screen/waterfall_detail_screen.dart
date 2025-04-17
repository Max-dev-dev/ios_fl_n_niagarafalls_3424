import 'package:flutter/material.dart';
import 'package:ios_fl_n_niagarafalls_3424/extension/string_extension.dart';
import 'package:ios_fl_n_niagarafalls_3424/models/waterfalls_model.dart';

class WaterfallDetailScreen extends StatefulWidget {
  final WaterfallModel waterfall;

  const WaterfallDetailScreen({super.key, required this.waterfall});

  @override
  State<WaterfallDetailScreen> createState() => _WaterfallDetailScreenState();
}

class _WaterfallDetailScreenState extends State<WaterfallDetailScreen> {
  int _selectedImageIndex = 0;
  String? _userMark;

  @override
  Widget build(BuildContext context) {
    final w = widget.waterfall;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                w.images[_selectedImageIndex],
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        w.categories.join(', ').toTitleCase(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (_userMark != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
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
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.45),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: w.images.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final isSelected = index == _selectedImageIndex;
                        return GestureDetector(
                          onTap:
                              () => setState(() => _selectedImageIndex = index),
                          child: Container(
                            width: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    isSelected
                                        ? Colors.white
                                        : Colors.transparent,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                w.images[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
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
                    w.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _infoRow('Height', '${w.height} m'),
                  _infoRow('Width', '${w.width} m'),
                  _infoRow('Type', w.type),
                  _infoRow('Seasonality', w.seasonality),
                  _infoRow('Description', w.description),
                  const SizedBox(height: 16),
                  const Text(
                    'Historical Facts',
                    style: TextStyle(color: Color(0xFFBABABA), fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  ...w.historicalFacts.map(
                    (fact) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• ', style: TextStyle(color: Colors.white)),
                        Expanded(
                          child: Text(
                            fact,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _infoRow('Features', w.features),
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
              child: Text(
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
