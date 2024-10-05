import 'package:flutter/material.dart';
import '../../data/model/resume.dart';
import 'resume_detail_screen.dart';

class ResumeSearchDelegate extends SearchDelegate {
  final List<Resume> resumes;

  ResumeSearchDelegate(this.resumes);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = resumes.where((resume) {
      return resume.judul.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return Container(
      color: const Color(0xFFFFFDF3),
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final resume = results[index];
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = resumes.where((resume) {
      return resume.judul.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return Container(
      color: const Color(0xFFFFFDF3), 
      child: ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final resume = suggestions[index];
          return ListTile(
            title: Text(resume.judul),
            onTap: () {
              query = resume.judul;
              showResults(context);
            },
          );
        },
      ),
    );
  }
}
