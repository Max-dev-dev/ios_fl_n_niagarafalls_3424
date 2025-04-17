import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_fl_n_niagarafalls_3424/cubit/custom_waterfall/custom_waterfall_cubit.dart';
import 'package:ios_fl_n_niagarafalls_3424/cubit/waterfall_cubit/waterfall_cubit.dart';
import 'package:ios_fl_n_niagarafalls_3424/models/waterfalls_model.dart';
import 'package:ios_fl_n_niagarafalls_3424/pages/waterfall_screen/waterfall_detail_screen.dart';

class WaterfallHomeScreen extends StatefulWidget {
  const WaterfallHomeScreen({super.key});

  @override
  State<WaterfallHomeScreen> createState() => _WaterfallHomeScreenState();
}

class _WaterfallHomeScreenState extends State<WaterfallHomeScreen> {
  List<String> _activeCategories = [];

  @override
  void initState() {
    super.initState();
    context.read<FallsCubit>().loadFalls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Home',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Waterfall Locations',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFD9D9D9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _showFilterSheet(context, _activeCategories, (selected) {
                      setState(() {
                        _activeCategories = selected;
                      });
                    });
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.filter_alt_rounded,
                      color: Color(0xFFFEC20C),
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: BlocBuilder<FallsCubit, List<WaterfallModel>>(
              builder: (context, waterfalls) {
                final filtered =
                    _activeCategories.isEmpty
                        ? waterfalls
                        : waterfalls.where((w) {
                          final lowerCats =
                              w.categories.map((e) => e.toLowerCase()).toList();
                          return lowerCats.any(
                            (cat) => _activeCategories.contains(cat),
                          );
                        }).toList();

                return ListView(
                  padding: const EdgeInsets.only(bottom: 100),
                  children:
                      filtered.map((w) => WaterfallCard(model: w)).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet(
    BuildContext context,
    List<String> selectedCategories,
    Function(List<String>) onApply,
  ) {
    final options = ['Popular', 'Secluded Waterfalls', 'Hidden'];
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
                    'Time filter',
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
                              checked!
                                  ? selected.add(category)
                                  : selected.remove(category);
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

class WaterfallCard extends StatelessWidget {
  final WaterfallModel model;

  const WaterfallCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WaterfallDetailScreen(waterfall: model),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF2B7A52),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset(
                model.images.first,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.categories.join(', ').toLowerCase(),
                    style: const TextStyle(
                      color: Color(0xFFFEC20C),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xFFFEC20C),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    model.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    model.description,
                    maxLines: 3,
                    style: const TextStyle(color: Colors.white, fontSize: 12.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
