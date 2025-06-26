# 📱 QR Scanner GeoApp

Una aplicación Flutter que permite escanear códigos QR y visualizar coordenadas geográficas (latitud y longitud) en pantalla.

## 🚀 Funcionalidades

- 📷 Escaneo de códigos QR en tiempo real.
- 🌍 Visualización clara de coordenadas extraídas.
- 🧭 Compatible con enlaces geográficos tipo `geo:lat,long`.
- 🗺️ Posibilidad de abrir las coordenadas en Google Maps (opcional).

## 🛠 Tecnologías usadas

- Flutter 3.x
- Dart 3.x
- [qr_code_scanner](https://pub.dev/packages/qr_code_scanner)
- [url_launcher](https://pub.dev/packages/url_launcher) (opcional, para abrir en mapas)

## 📦 Instalación

```bash
git clone https://github.com/TU_USUARIO/qr-geo-scanner.git
cd qr-geo-scanner
flutter pub get
flutter run
