import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/services/db_provider.dart';

class ScansProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  Future<ScanModel> nuevoScan(String valor) async {
    final nuevoScan = new ScanModel(valor: valor);
    //insertar en bd
    final id = await DBProvider.dbProvider.nuevoScan(nuevoScan);

    nuevoScan.id = id;

    //Para visualizar en la vista
    if (this.tipoSeleccionado == nuevoScan.tipo) {
      this.scans.add(nuevoScan);
      notifyListeners();
    }

    return nuevoScan;
  }

  obtenerTodosLosScans() async {
    final scans = await DBProvider.dbProvider.getScans();
    this.scans = [...scans!];
    notifyListeners();
  }

  obtenerScansPorTipo(String tipo) async {
    final scans = await DBProvider.dbProvider.getScanByType(tipo);
    this.scans = [...scans];
    this.tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarTodosLosScans() async {
    await DBProvider.dbProvider.deleteScans();
    this.scans = [...scans];
    notifyListeners();
  }

  borrarScansPorId(int id) async {
    await DBProvider.dbProvider.deleteScanById(id);
    //obtenerScansPorTipo(this.tipoSeleccionado);
  }
}
