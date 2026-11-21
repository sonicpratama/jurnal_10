import 'package:flutter/material.dart';
import 'screens/halaman_layanan.dart';

void main() {
  runApp(AplikasiPuskesmasBandung());
}

class AplikasiPuskesmasBandung extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Puskesmas Kota Bandung',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF0F766E),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Color(0xFFF8FAFC),
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: false,
        ),
      ),
      home: HalamanLayanan(),
    );
  }
}
