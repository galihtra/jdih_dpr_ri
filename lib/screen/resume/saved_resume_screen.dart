import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/model/resume.dart';
import '../../data/services/api_service.dart';
import 'resume_detail_screen.dart';

class SavedResumeScreen extends StatefulWidget {
  @override
  _SavedResumeScreenState createState() => _SavedResumeScreenState();
}

class _SavedResumeScreenState extends State<SavedResumeScreen> {
  List<Resume> _savedResumes = [];

  @override
  void initState() {
    super.initState();
    _loadSavedResumes();
  }

  // Memuat resume yang disimpan dari SharedPreferences
  void _loadSavedResumes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedIds = prefs.getStringList('savedResumes');
    if (savedIds != null) {
      List<Resume> resumes = await ApiService().fetchResumeData(); // Ambil semua data resume
      setState(() {
        _savedResumes = resumes.where((resume) => savedIds.contains(resume.id)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Tersimpan'),
        backgroundColor: const Color(0xFFFFFDF3), 
      ),
      body: Container(
        color: const Color(0xFFFFFDF3), 
        child: _savedResumes.isEmpty
            ? const Center(child: Text('No saved resumes'))
            : ListView.builder(
                itemCount: _savedResumes.length,
                itemBuilder: (context, index) {
                  final resume = _savedResumes[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResumeDetailScreen(resume: resume),
                        ),
                      );
                    },
                    child: Container(
                      height: 180,
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFE0E0E0)),
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white, 
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  resume.judul,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Penerbit: ${resume.penerbit}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(resume.gambarSampul),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
