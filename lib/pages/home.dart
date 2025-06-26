import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/direcciones_page.dart';
import 'package:qr_reader/pages/mapas_page.dart';
import 'package:qr_reader/services/scans_provider.dart';
import 'package:qr_reader/services/ui_provider.dart';
import 'package:qr_reader/widgets/custom_navigator_bar.dart';
import 'package:qr_reader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanProvider = Provider.of<ScansProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Historial'),
        actions: [
          IconButton(
            onPressed: () => {scanProvider.borrarTodosLosScans()},
            icon: Icon(Icons.delete_forever),
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final scanProvider = Provider.of<ScansProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    switch (currentIndex) {
      case 0:
        scanProvider.obtenerScansPorTipo('geo');
        return MapasPage();
      case 1:
        scanProvider.obtenerScansPorTipo('http');
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }
}
