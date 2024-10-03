import 'package:flutter/material.dart';
import '../../data/model/resume.dart';
import '../../data/services/api_service.dart';
import 'resume_detail_screen.dart';

class ResumeListScreen extends StatefulWidget {
  @override
  _ResumeListScreenState createState() => _ResumeListScreenState();
}

class _ResumeListScreenState extends State<ResumeListScreen> {
  late Future<List<Resume>> futureResumeList;

  @override
  void initState() {
    super.initState();
    futureResumeList = ApiService().fetchResumeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Resume'),
      ),
      body: FutureBuilder<List<Resume>>(
        future: futureResumeList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            final resumeList = snapshot.data!;
            return ListView.builder(
              itemCount: resumeList.length,
              itemBuilder: (context, index) {
                final resume = resumeList[index];
                return ListTile(
                  leading: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.asset(
                      'assets/images/logo_dpr.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(resume.judul),
                  subtitle: Text('Penerbit: ${resume.penerbit}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ResumeDetailScreen(resume: resume),
                      ),
                    );  
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
