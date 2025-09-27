// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:widget_builder_demo/color_pallet/components/dialog_container.dart';
import 'package:widget_builder_demo/color_pallet/cubits/color_theme_cubit.dart';
import 'package:widget_builder_demo/onboarding/components/onboarding.dart';
import 'package:widget_builder_demo/onboarding/cubit/step_walkthrough_cubit.dart';
import 'package:widget_builder_demo/re_editor/re_editor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return Portal(
    //   child: MaterialApp(
    //     title: 'Flutter Demo',
    //     home: BlocProvider(
    //       create: (context) => ColorThemeCubit(),
    //       child: DialogContainer(
    //         title: 'Color Pallet',
    //         onClosePressed: () {},
    //       ),
    //     ),
    //   ),
    // );

    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   home: BlocProvider(
    //     create: (context) => OnboardingCubit(),
    //     child: const OnBoardingScreen(),
    //   ),
    // );

    return MaterialApp(
      title: 'Dart Code Editor',
      theme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF2196F3),
          surface: Color(0xFF1E1E1E),
        ),
        scaffoldBackgroundColor: const Color(0xFF0D1117),
      ),
      home: const DartCodeEditor(),
    );
  }
}
