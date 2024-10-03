import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Untuk membuka URL di browser
import '../../data/model/resume.dart';

class ResumeDetailScreen extends StatelessWidget {
  final Resume resume;

  ResumeDetailScreen({required this.resume});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF3),
      appBar: AppBar(
        title:
            const Text('Detail Resume', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return FullScreenImage(imageUrl: resume.gambarSampul);
                    }));
                  },
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(resume.gambarSampul),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 16,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return FullScreenImage(imageUrl: resume.gambarSampul);
                      }));
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.fullscreen, color: Colors.white, size: 28),
                        SizedBox(width: 8),
                        Text(
                          'Full Screen',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black45,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                resume.judul,
                style: const TextStyle(
                  fontSize:
                      18, // Ukuran teks yang disamakan dengan teks lainnya
                  fontWeight: FontWeight.normal,
                  color: Colors.black87,
                ),
              ),
            ),

            // Informasi Detail
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(
                    icon: Icons.article,
                    title: 'Jenis',
                    content: resume.jenis,
                  ),
                  _buildInfoCard(
                    icon: Icons.date_range,
                    title: 'Tahun Pengundangan',
                    content: resume.tahunPengundangan,
                  ),
                  _buildInfoCard(
                    icon: Icons.location_on,
                    title: 'Tempat Terbit',
                    content: resume.tempatTerbit,
                  ),
                  _buildInfoCard(
                    icon: Icons.person,
                    title: 'Penerbit',
                    content: resume.penerbit,
                  ),
                  _buildInfoCard(
                    icon: Icons.language,
                    title: 'Bahasa',
                    content: resume.bahasa,
                  ),
                  _buildInfoCard(
                    icon: Icons.book,
                    title: 'Bidang Hukum',
                    content: resume.bidangHukum,
                  ),
                  _buildInfoCard(
                    icon: Icons.subject,
                    title: 'Subjek',
                    content: resume.subjek,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: double
                          .infinity, // Membuat tombol melebar memenuhi lebar layar
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFE791),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            vertical:
                                14, // Ubah padding untuk ketinggian tombol
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.file_download, size: 20),
                        label: const Text(
                          'Download Resume',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () async {
                          final url = resume.urlDownload;
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      {required IconData icon,
      required String title,
      required String content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: const Color(0xFFFFF8E1),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xFFFFD541),
            child: Icon(icon, color: Colors.white),
          ),
          title:
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle:
              Text(content, style: const TextStyle(color: Colors.black87)),
        ),
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  FullScreenImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Image.network(imageUrl, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
