import 'package:flutter/material.dart';
import '../../data/model/resume.dart';
import '../../data/services/api_service.dart';
import '../components/sidebar.dart';
import 'resume_detail_screen.dart';
import 'resume_search_delegate.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResumeListScreen extends StatefulWidget {
  @override
  _ResumeListScreenState createState() => _ResumeListScreenState();
}

class _ResumeListScreenState extends State<ResumeListScreen> {
  late Future<List<Resume>> futureResumeList;
  List<Resume> _filteredResumes = [];
  Set<String> _savedResumeIds = {};

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var _menuItems;

  @override
  void initState() {
    super.initState();
    futureResumeList = ApiService().fetchResumeData();
    futureResumeList.then((resumeList) {
      setState(() {
        _filteredResumes = resumeList;
      });
    });
    _loadSavedResumes();
  }

  // Memuat resume yang disimpan dari SharedPreferences
  void _loadSavedResumes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedResumeIds = prefs.getStringList('savedResumes')?.toSet() ?? {};
    });
  }

  // Menyimpan ID resume ke SharedPreferences
  void _saveResume(String resumeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedResumeIds.add(resumeId);
      prefs.setStringList('savedResumes', _savedResumeIds.toList());
    });
  }

  // Menghapus ID resume dari SharedPreferences
  void _removeResume(String resumeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedResumeIds.remove(resumeId);
      prefs.setStringList('savedResumes', _savedResumeIds.toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width > 800;

    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFFDF3),
          elevation: 0,
          titleSpacing: 0,
          leading: isLargeScreen
              ? null
              : IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  child: Image.asset(
                    "assets/images/logo_dpr.png",
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  "SETJEN DPR-RI",
                  style: TextStyle(
                    color: Color.fromARGB(255, 224, 208, 130),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 16),
                if (isLargeScreen) Expanded(child: _navBarItems()),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: ResumeSearchDelegate(_filteredResumes),
                );
              },
            ),
          ],
        ),
        drawer: isLargeScreen
            ? null
            : SideBar(
                scaffoldKey:
                    _scaffoldKey), 
        body: Container(
          color: const Color(0xFFFFFDF3),
          child: Row(
            children: [
              if (isLargeScreen)
                SideBar(scaffoldKey: _scaffoldKey), 
              Expanded(
                child: FutureBuilder<List<Resume>>(
                  future: futureResumeList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No data available'));
                    } else {
                      return _buildResumeList();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navBarItems() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _menuItems
            .map(
              (item) => InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 24.0, horizontal: 16),
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            )
            .toList(),
      );

  Widget _buildResumeList() {
    return ListView.builder(
      itemCount: _filteredResumes.length,
      itemBuilder: (context, index) {
        final resume = _filteredResumes[index];
        final bool isSaved = _savedResumeIds.contains(resume.id);

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
                      const SizedBox(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              isSaved
                                  ? Icons.bookmark
                                  : Icons.bookmark_border_rounded,
                              size: 20,
                              color: isSaved ? Colors.blue : Colors.black,
                            ),
                            onPressed: () {
                              if (isSaved) {
                                _removeResume(resume.id);
                              } else {
                                _saveResume(resume.id);
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.share, size: 20),
                            onPressed: () {
                              Share.share(
                                  'Check out this resume: ${resume.urlDownload}');
                            },
                          ),
                        ],
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
    );
  }
}
