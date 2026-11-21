// models/tiket_antrean.dart

class TiketAntrean {
  String nomorAntrean;
  String poli;
  DateTime tanggalKunjungan;
  bool aktif;

  TiketAntrean({
    required this.nomorAntrean,
    required this.poli,
    required this.tanggalKunjungan,
    required this.aktif,
  });
}
