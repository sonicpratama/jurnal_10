// widgets/tab_riwayat.dart

import 'package:flutter/material.dart';
import '../models/tiket_antrean.dart';

class TabRiwayat extends StatelessWidget {
  final List<TiketAntrean> daftarRiwayat;
  final void Function(TiketAntrean) onBatalTiket;

  const TabRiwayat({
    super.key,
    required this.daftarRiwayat,
    required this.onBatalTiket,
  });

  @override
  Widget build(BuildContext context) {
    if (daftarRiwayat.isEmpty) {
      return const Center(
        child: Text('Belum Ada Riwayat Antrean'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: daftarRiwayat.length,
      itemBuilder: (context, index) {
        final tiket = daftarRiwayat[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tiket.nomorAntrean,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F766E),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: tiket.aktif
                            ? Colors.green.withOpacity(0.15)
                            : Colors.red.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tiket.aktif ? 'Aktif' : 'Dibatalkan',
                        style: TextStyle(
                          color: tiket.aktif
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Icon(
                      Icons.local_hospital,
                      color: Colors.grey[700],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      tiket.poli,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.grey[700],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${tiket.tanggalKunjungan.day}/'
                      '${tiket.tanggalKunjungan.month}/'
                      '${tiket.tanggalKunjungan.year}',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),

                if (tiket.aktif) ...[
                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.cancel_outlined),
                      label: const Text('Batalkan Antrean'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                      onPressed: () {
                        onBatalTiket(tiket);
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
