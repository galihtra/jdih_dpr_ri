class Resume {
  final String id;
  final String idJenisDokumen;
  final String idDokumen;
  final String idData;
  final String tahunPengundangan;
  final String? tanggalPengundangan; // Nullable jika bisa null
  final String jenis;
  final String? noPeraturan; // Nullable
  final String judul;
  final String noPanggil;
  final String? singkatanJenis; // Nullable
  final String tempatTerbit;
  final String penerbit;
  final String deskripsiFisik;
  final String? sumber; // Nullable
  final String subjek;
  final String isbn;
  final String? status; // Nullable
  final String bahasa;
  final String bidangHukum;
  final String teuBadan;
  final String? nomorIndukBuku; // Nullable
  final String fileDownload;
  final String urlDownload;
  final String urlDetailPeraturan;
  final String gambarSampul;
  final String? operasi; // Nullable
  final String? display; // Nullable
  final String statusProduk;
  final String userInput;
  final DateTime tanggalInput;
  final String userUpdate;
  final DateTime tanggalUpdate;
  final String tahun;

  Resume({
    required this.id,
    required this.idJenisDokumen,
    required this.idDokumen,
    required this.idData,
    required this.tahunPengundangan,
    this.tanggalPengundangan,
    required this.jenis,
    this.noPeraturan,
    required this.judul,
    required this.noPanggil,
    this.singkatanJenis,
    required this.tempatTerbit,
    required this.penerbit,
    required this.deskripsiFisik,
    this.sumber,
    required this.subjek,
    required this.isbn,
    this.status,
    required this.bahasa,
    required this.bidangHukum,
    required this.teuBadan,
    this.nomorIndukBuku,
    required this.fileDownload,
    required this.urlDownload,
    required this.urlDetailPeraturan,
    required this.gambarSampul,
    this.operasi,
    this.display,
    required this.statusProduk,
    required this.userInput,
    required this.tanggalInput,
    required this.userUpdate,
    required this.tanggalUpdate,
    required this.tahun,
  });

  factory Resume.fromJson(Map<String, dynamic> json) {
    return Resume(
      id: json['id'],
      idJenisDokumen: json['id_jenis_dokumen'],
      idDokumen: json['id_dokumen'],
      idData: json['idData'],
      tahunPengundangan: json['tahun_pengundangan'],
      tanggalPengundangan: json['tanggal_pengundangan'],
      jenis: json['jenis'],
      noPeraturan: json['noPeraturan'],
      judul: json['judul'],
      noPanggil: json['noPanggil'],
      singkatanJenis: json['singkatanJenis'],
      tempatTerbit: json['tempatTerbit'],
      penerbit: json['penerbit'],
      deskripsiFisik: json['deskripsiFisik'],
      sumber: json['sumber'],
      subjek: json['subjek'],
      isbn: json['isbn'],
      status: json['status'],
      bahasa: json['bahasa'],
      bidangHukum: json['bidangHukum'],
      teuBadan: json['teuBadan'],
      nomorIndukBuku: json['nomorIndukBuku'],
      fileDownload: json['fileDownload'],
      urlDownload: json['urlDownload'],
      urlDetailPeraturan: json['urlDetailPeraturan'],
      gambarSampul: json['gambarSampul'],
      operasi: json['operasi'],
      display: json['display'],
      statusProduk: json['status_produk'],
      userInput: json['user_input'],
      tanggalInput: DateTime.parse(json['tanggal_input']),
      userUpdate: json['user_update'],
      tanggalUpdate: DateTime.parse(json['tanggal_update']),
      tahun: json['tahun'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_jenis_dokumen': idJenisDokumen,
      'id_dokumen': idDokumen,
      'idData': idData,
      'tahun_pengundangan': tahunPengundangan,
      'tanggal_pengundangan': tanggalPengundangan,
      'jenis': jenis,
      'noPeraturan': noPeraturan,
      'judul': judul,
      'noPanggil': noPanggil,
      'singkatanJenis': singkatanJenis,
      'tempatTerbit': tempatTerbit,
      'penerbit': penerbit,
      'deskripsiFisik': deskripsiFisik,
      'sumber': sumber,
      'subjek': subjek,
      'isbn': isbn,
      'status': status,
      'bahasa': bahasa,
      'bidangHukum': bidangHukum,
      'teuBadan': teuBadan,
      'nomorIndukBuku': nomorIndukBuku,
      'fileDownload': fileDownload,
      'urlDownload': urlDownload,
      'urlDetailPeraturan': urlDetailPeraturan,
      'gambarSampul': gambarSampul,
      'operasi': operasi,
      'display': display,
      'status_produk': statusProduk,
      'user_input': userInput,
      'tanggal_input': tanggalInput.toIso8601String(),
      'user_update': userUpdate,
      'tanggal_update': tanggalUpdate.toIso8601String(),
      'tahun': tahun,
    };
  }
}
