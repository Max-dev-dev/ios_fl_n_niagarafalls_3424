import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ios_fl_n_niagarafalls_3424/pages/custom_waterfall/custom_waterfall_screen.dart';
import 'package:ios_fl_n_niagarafalls_3424/pages/game/game_screen.dart';
import 'package:ios_fl_n_niagarafalls_3424/pages/settings/settings_screen.dart';
import 'package:ios_fl_n_niagarafalls_3424/pages/sounds/sounds_screen.dart';
import 'package:ios_fl_n_niagarafalls_3424/pages/waterfall_screen/waterfall_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    WaterfallHomeScreen(),
    CustomWaterfallScreen(),
    SoundsScreen(),
    GameScreen(),
    SettingsScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<IconData> _icons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.penNib,
    FontAwesomeIcons.music,
    FontAwesomeIcons.gamepad,
    FontAwesomeIcons.gear,
  ];

  final List<String> _labels = [
    'Home',
    'Journal',
    'Sounds',
    'Game',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: const BoxDecoration(
          color: Color(0xFF2B7A52),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_icons.length, (index) {
            final bool isSelected = _selectedIndex == index;
            return GestureDetector(
              onTap: () => _onTabTapped(index),
              child: Container(
                width: 70,
                height: 90,
                decoration: BoxDecoration(
                  color:
                      isSelected ? const Color(0xFF3F8F59) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    if (isSelected)
                      Container(
                        height: 4,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFEC20C),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(4),
                          ),
                        ),
                      )
                    else
                      const SizedBox(height: 4),
                    const Spacer(),
                    FaIcon(
                      _icons[index],
                      color:
                          isSelected
                              ? const Color(0xFFFEC20C)
                              : const Color(0xFFBABABA),
                      size: 26,
                    ),
                    const SizedBox(height: 6),
                    isSelected
                        ? Text(
                          _labels[index],
                          style: const TextStyle(
                            color: Color(0xFFFEC20C),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        )
                        : const SizedBox.shrink(),
                    const Spacer(),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
