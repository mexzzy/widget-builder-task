// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:widget_builder_demo/components/dialog_container.dart';
import 'package:widget_builder_demo/cubits/color_theme_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Portal(
      child: MaterialApp(
        title: 'Flutter Demo',
        home: BlocProvider(
          create: (context) => ColorThemeCubit(),
          child: DialogContainer(
            title: 'Color Pallet',
            onClosePressed: () {},
          ),
        ),
      ),
    );
  }
}