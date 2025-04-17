import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_fl_n_niagarafalls_3424/cubit/favourite_songs_cubit/favourite_sounds_cubit.dart';
import 'package:ios_fl_n_niagarafalls_3424/pages/sounds/favourite_sounds_screen.dart';
import 'package:just_audio/just_audio.dart';

class SoundsScreen extends StatefulWidget {
  const SoundsScreen({super.key});

  @override
  State<SoundsScreen> createState() => _SoundsScreenState();
}

class _SoundsScreenState extends State<SoundsScreen> {
  final List<List<String>> soundGroups = [
    ['1', '2', '3'],
    ['4', '5'],
    ['6', '7'],
  ];

  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Text(
          'Collection of\nwaterfall sounds',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => FavouriteSoundsScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite_border,
                  color: Color(0xFFFFB300),
                  size: 24,
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              children: List.generate(3, (index) {
                final isSelected = selectedTabIndex == index;
                final labels = [
                  'Quiet stream',
                  'Rushing stream',
                  'Falling water',
                ];
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: index != 2 ? 8.0 : 0),
                    child: GestureDetector(
                      onTap: () => setState(() => selectedTabIndex = index),
                      child: Container(
                        height: 42,

                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? Colors.white
                                  : const Color(0xFF2B7A52),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          labels[index],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color:
                                isSelected
                                    ? const Color(0xFF1B593B)
                                    : Color(0xFFBABABA),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: soundGroups[selectedTabIndex].length,
        itemBuilder: (context, index) {
          final soundId = soundGroups[selectedTabIndex][index];
          final assetPath = 'assets/waterfalls_sounds/$soundId.mp3';
          return _SoundCard(assetPath: assetPath);
        },
      ),
    );
  }
}

class _SoundCard extends StatefulWidget {
  final String assetPath;

  const _SoundCard({required this.assetPath});

  @override
  State<_SoundCard> createState() => _SoundCardState();
}

class _SoundCardState extends State<_SoundCard> {
  late final AudioPlayer player;
  bool isPlaying = false;
  Duration? duration;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    _loadDuration();
  }

  Future<void> _loadDuration() async {
    try {
      await player.setAsset(widget.assetPath);
      final dur = player.duration;
      if (dur != null) {
        setState(() => duration = dur);
      }
    } catch (e) {
      debugPrint('Failed to load duration: $e');
    }
  }

  void _togglePlay() async {
    if (isPlaying) {
      await player.stop();
    } else {
      await player.setAsset(widget.assetPath);
      await player.play();
    }

    setState(() => isPlaying = !isPlaying);
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayDuration =
        duration != null
            ? '${duration!.inMinutes.toString().padLeft(2, '0')}:${(duration!.inSeconds % 60).toString().padLeft(2, '0')}'
            : '--:--';
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF337B55),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: _togglePlay,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Image.asset('assets/images/play_icon.png', width: 40),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(child: SizedBox(height: 32)),
          const SizedBox(width: 16),
          Text(
            displayDuration,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 16),
          BlocBuilder<FavouriteSoundsCubit, Set<String>>(
            builder: (context, favourites) {
              final isFav = favourites.contains(widget.assetPath);
              return GestureDetector(
                onTap: () {
                  context.read<FavouriteSoundsCubit>().toggle(widget.assetPath);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: const Color(0xFFFFB300),
                    size: 24,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
