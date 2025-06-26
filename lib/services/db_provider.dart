import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

export 'package:qr_reader/models/scan_model.dart';

class DBProvider {
  //-->Inicio singleton
  static Database? _database;
  static final DBProvider dbProvider = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  //---> Fin singleton

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
            CREATE TABLE Scans(
              id INTEGER PRIMARY KEY,
              tipo TEXT,
              valor TEXT
            )
          ''');
    });
  }

  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    final db = await database;
    final resp = await db.rawInsert('''
        INSERT INTO Scans(id, tipo, valor)
        VALUES($id, '$tipo', '$valor')
    ''');

    return resp;
  }

  Future<int> nuevoScan(ScanModel model) async {
    final db = await database;
    final resp = await db.insert('Scans', model.toJson());
    //retorna el ultimo id insertado
    return resp;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final resp = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    return resp.isNotEmpty ? ScanModel.fromJson(resp.first) : null;
  }

  Future<List<ScanModel>?> getScans() async {
    final db = await database;
    final resp = await db.query('Scans');
    return resp.isNotEmpty
        ? resp.map((e) => ScanModel.fromJson(e)).toList()
        : null;
  }

  Future<List<ScanModel>> getScanByType(String tipo) async {
    final db = await database;
    final resp = await db.query('Scans', where: 'tipo = ?', whereArgs: [tipo]);
    return resp.isNotEmpty
        ? resp.map((e) => ScanModel.fromJson(e)).toList()
        : [];
  }

  Future<int> updateScan(ScanModel model) async {
    final db = await database;
    final resp = await db
        .update('Scans', model.toJson(), where: 'id =?', whereArgs: [model.id]);
    //retorna el ultimo id insertado
    return resp;
  }

  Future<int> deleteScanById(int id) async {
    final db = await database;
    final resp = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return resp;
  }

  Future<int> deleteScans() async {
    final db = await database;
    final resp = await db.delete('Scans');
    return resp;
  }
}
