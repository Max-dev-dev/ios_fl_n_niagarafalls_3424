import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_fl_n_niagarafalls_3424/cubit/custom_waterfall/custom_waterfall_cubit.dart';
import 'package:ios_fl_n_niagarafalls_3424/cubit/favourite_songs_cubit/favourite_sounds_cubit.dart';
import 'package:ios_fl_n_niagarafalls_3424/cubit/waterfall_cubit/waterfall_cubit.dart';
import 'package:ios_fl_n_niagarafalls_3424/pages/splash/splash_screen.dart';
import 'package:ios_fl_n_niagarafalls_3424/services/audio_service.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final audioService = AudioService();

  @override
  void initState() {
    audioService.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mainAppColor = const Color(0xFF1D583A);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FallsCubit()),
        BlocProvider(create: (context) => CustomWaterfallEntryCubit()),
        BlocProvider(create: (context) => FavouriteSoundsCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: mainAppColor,
          appBarTheme: AppBarTheme(backgroundColor: mainAppColor),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
