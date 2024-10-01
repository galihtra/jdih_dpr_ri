import 'package:flutter/material.dart';

import '../../data/model/resume.dart';

class ResumeDetailScreen extends StatelessWidget {
  final Resume resume;

  ResumeDetailScreen({required this.resume});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Resume'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar Sampul
              Center(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      resume.gambarSampul,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Judul
              Text(
                resume.judul,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),

              // Informasi Umum
              _buildInfoRow(Icons.article, 'Jenis: ${resume.jenis}'),
              _buildInfoRow(Icons.date_range, 'Tahun Pengundangan: ${resume.tahunPengundangan}'),
              _buildInfoRow(Icons.location_on, 'Tempat Terbit: ${resume.tempatTerbit}'),
              _buildInfoRow(Icons.person, 'Penerbit: ${resume.penerbit}'),
              _buildInfoRow(Icons.language, 'Bahasa: ${resume.bahasa}'),
              _buildInfoRow(Icons.book, 'Bidang Hukum: ${resume.bidangHukum}'),
              _buildInfoRow(Icons.subject, 'Subjek: ${resume.subjek}'),
              _buildInfoRow(Icons.file_download, 'File Download: ${resume.fileDownload}'),
              SizedBox(height: 20),

              // Deskripsi
              Text(
                'Deskripsi:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Resume ini menjelaskan tentang: ${resume.deskripsiFisik}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              // Tombol untuk Mengunduh File
              ElevatedButton(
                onPressed: () {
                  // Implementasi untuk mengunduh file
                  // Misalnya, membuka urlDownload di browser
                  // launch(resume.urlDownload);
                },
                child: Text('Download Resume'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue),
        SizedBox(width: 8),
        Expanded(child: Text(text, style: TextStyle(fontSize: 16))),
      ],
    );
  }
}
