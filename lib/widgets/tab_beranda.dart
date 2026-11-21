
import 'package:flutter/material.dart';

class TabBeranda extends StatelessWidget {
  final String? poliDipilih;
  final DateTime? tanggalKunjungan;
  final VoidCallback onPilihPoli;
  final VoidCallback onPilihTanggal;
  final VoidCallback onSubmit;

  TabBeranda({
    required this.poliDipilih,
    required this.tanggalKunjungan,
    required this.onPilihPoli,
    required this.onPilihTanggal,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final tanggalStr = tanggalKunjungan != null
        ? '${tanggalKunjungan!.day}/${tanggalKunjungan!.month}/${tanggalKunjungan!.year}'
        : 'Belum ditentukan';

    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // Informasi Puskesmas
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFF0F766E).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Color(0xFF0F766E).withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.local_hospital,
                size: 40,
                color: Color(0xFF0F766E),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'UPTD Puskesmas Kota Bandung',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF0F766E),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Layanan pendaftaran antrean berobat online cepat & tertib.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 16),

        // Formulir Registrasi
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Formulir Registrasi Antrean',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 16),

                // Pilihan Poli
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFF0F766E)
                        .withValues(alpha: 0.15),
                    child: Icon(
                      Icons.local_hospital,
                      color: Color(0xFF0F766E),
                    ),
                  ),
                  title: Text(
                    'Poli Tujuan',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                  subtitle: Text(
                    poliDipilih ?? 'Belum dipilih',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: poliDipilih != null
                          ? Color(0xFF0F766E)
                          : Colors.grey[800],
                    ),
                  ),
                  trailing: OutlinedButton(
                    onPressed: onPilihPoli,
                    child: Text('Pilih'),
                  ),
                ),

                Divider(height: 20),

                // Pilihan Tanggal
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue
                        .withValues(alpha: 0.15),
                    child: Icon(
                      Icons.event,
                      color: Colors.blue,
                    ),
                  ),
                  title: Text(
                    'Tanggal Kunjungan Berobat',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                  subtitle: Text(
                    tanggalStr,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: tanggalKunjungan != null
                          ? Colors.blue[900]
                          : Colors.grey[800],
                    ),
                  ),
                  trailing: OutlinedButton(
                    onPressed: onPilihTanggal,
                    child: Text('Pilih'),
                  ),
                ),

                SizedBox(height: 20),

                // Tombol Pendaftaran
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.confirmation_number),
                    label: Text('Ambil Nomor Antrean Poli'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0F766E),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: onSubmit,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
