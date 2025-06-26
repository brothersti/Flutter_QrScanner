import 'package:flutter/material.dart';
import 'package:qr_reader/widgets/scan_tile.dart';

class MapasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScanTile(tipo: 'http');
  }
}
