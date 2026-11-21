// screens/halaman_layanan.dart

import 'package:flutter/material.dart';
import '../models/tiket_antrean.dart';
import '../widgets/tab_beranda.dart';
import '../widgets/tab_riwayat.dart';

class HalamanLayanan extends StatefulWidget {
  const HalamanLayanan({super.key});

  @override
  State<HalamanLayanan> createState() => _HalamanLayananState();
}

class _HalamanLayananState extends State<HalamanLayanan> {
  int _currentIndex = 0;
  String? _poliDipilih;
  DateTime? _tanggalKunjungan;

  final List<TiketAntrean> _daftarRiwayat = [];

  // Membuat nomor antrean
  String _buatNomorAntrean(String poli) {
    String prefix = 'A';

    if (poli.contains('Gigi')) {
      prefix = 'B';
    } else if (poli.contains('KIA')) {
      prefix = 'C';
    } else if (poli.contains('Lansia')) {
      prefix = 'D';
    }

    int urutan = _daftarRiwayat.length + 1;
    String nomorUrut = urutan.toString().padLeft(3, '0');

    return '$prefix-$nomorUrut';
  }

  // TODO 1-4: Memilih poli menggunakan BottomSheet
  Future<void> _bukaPilihanPoli() async {
    final String? hasil = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      isScrollControlled: false,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Pilih Poli',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              ...['Poli Umum', 'Poli Gigi', 'Poli KIA', 'Poli Lansia']
                  .map((poli) {
                return ListTile(
                  leading: const Icon(Icons.local_hospital),
                  title: Text(poli),
                  onTap: () {
                    Navigator.pop(context, poli);
                  },
                );
              }),
            ],
          ),
        );
      },
    );

    if (!mounted) return;

    if (hasil != null) {
      setState(() {
        _poliDipilih = hasil;
      });
    }
  }

  // TODO 5-8: Memilih tanggal kunjungan
  Future<void> _pilihTanggalKunjungan() async {
    final DateTime hariIni = DateTime.now();

    final DateTime? hasil = await showDatePicker(
      context: context,
      initialDate: hariIni.add(const Duration(days: 1)),
      firstDate: hariIni,
      lastDate: hariIni.add(const Duration(days: 14)),
    );

    if (!mounted) return;

    if (hasil != null) {
      setState(() {
        _tanggalKunjungan = hasil;
      });
    }
  }

  // TODO 9-11: Dialog konfirmasi pendaftaran
  Future<bool?> _tampilkanDialogKonfirmasi(String tanggalStr) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi Pendaftaran'),
          content: Text(
            'Apakah Anda yakin ingin mendaftar antrean '
            '$_poliDipilih pada tanggal $tanggalStr?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Ya, Daftar'),
            ),
          ],
        );
      },
    );
  }

  // TODO 12-15: Menampilkan SnackBar sukses
  void _tampilkanSnackBarSukses(TiketAntrean tiket) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Pendaftaran berhasil! Nomor antrean: ${tiket.nomorAntrean}',
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  // TODO 16-18: Memproses pendaftaran
  Future<void> _prosesPendaftaran() async {
    if (_poliDipilih == null || _tanggalKunjungan == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Silakan pilih poli dan tanggal terlebih dahulu.',
          ),
        ),
      );
      return;
    }

    String tanggalStr =
        '${_tanggalKunjungan!.day}/'
        '${_tanggalKunjungan!.month}/'
        '${_tanggalKunjungan!.year}';

    bool? konfirmasi =
        await _tampilkanDialogKonfirmasi(tanggalStr);

    if (!mounted || konfirmasi != true) return;

    final tiket = TiketAntrean(
      nomorAntrean: _buatNomorAntrean(_poliDipilih!),
      poli: _poliDipilih!,
      tanggalKunjungan: _tanggalKunjungan!,
      aktif: true,
    );

    setState(() {
      _daftarRiwayat.insert(0, tiket);
      _currentIndex = 1;
    });

    _tampilkanSnackBarSukses(tiket);
  }

  // TODO 19-21: Membatalkan tiket antrean
  Future<void> _konfirmasiBatalTiket(TiketAntrean tiket) async {
    bool? konfirmasi = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Batalkan Antrean'),
          content: const Text(
            'Apakah Anda yakin ingin membatalkan tiket ini?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Tidak'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Ya, Batalkan'),
            ),
          ],
        );
      },
    );

    if (!mounted) return;

    if (konfirmasi == true) {
      setState(() {
        tiket.aktif = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Antrean berhasil dibatalkan.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Puskesmas Kota Bandung'),
        backgroundColor: const Color(0xFF0F766E),
        foregroundColor: Colors.white,
      ),

      body: [
        TabBeranda(
          poliDipilih: _poliDipilih,
          tanggalKunjungan: _tanggalKunjungan,
          onPilihPoli: _bukaPilihanPoli,
          onPilihTanggal: _pilihTanggalKunjungan,
          onSubmit: _prosesPendaftaran,
        ),

        TabRiwayat(
          daftarRiwayat: _daftarRiwayat,
          onBatalTiket: _konfirmasiBatalTiket,
        ),
      ][_currentIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'Riwayat',
          ),
        ],
      ),
    );
  }
}
