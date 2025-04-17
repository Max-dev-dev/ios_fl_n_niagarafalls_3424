import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_fl_n_niagarafalls_3424/cubit/favourite_songs_cubit/favourite_sounds_cubit.dart';
import 'package:just_audio/just_audio.dart';

class FavouriteSoundsScreen extends StatelessWidget {
  const FavouriteSoundsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Color(0xFF0C0C09),
                size: 24,
              ),
            ),
          ),
        ),

        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          'Favourite sounds',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<FavouriteSoundsCubit, Set<String>>(
        builder: (context, favourites) {
          if (favourites.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/waterfall.png',
                      width: 200,
                      height: 100,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'You haven’t added any sounds yet',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final sounds = favourites.toList();

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: sounds.length,
            itemBuilder: (context, index) {
              return _SoundCard(assetPath: sounds[index]);
            },
          );
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
