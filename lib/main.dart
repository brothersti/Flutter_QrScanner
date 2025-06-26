import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/home.dart';
import 'package:qr_reader/pages/mapa.dart';
import 'package:qr_reader/services/scans_provider.dart';
import 'package:qr_reader/services/ui_provider.dart';
import 'package:qr_reader/utils/color_palette.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ScansProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Qr reader',
        initialRoute: 'home',
        routes: {
          'home': (_) => HomePage(),
          'mapa': (_) => MapaPage(),
        },
        theme: ThemeData(
          primarySwatch: Palette.kToDark,
        ),
      ),
    );
  }
}
