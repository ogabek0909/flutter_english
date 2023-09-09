import 'package:flutter/material.dart';
import 'package:flutter_english/src/presentation/views/vocabulary/vocabularies_list.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  static const routeName = 'categories-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          'IMPROVE YOUR ENGLISH',
          style: GoogleFonts.abhayaLibre(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  context.goNamed(VocabulariesListScreen.routeName);
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  height:
                      ((MediaQuery.of(context).size.width - 50) / 2) * (11 / 8),
                  decoration: BoxDecoration(
                    color: Colors.lightGreen[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'English Vocabulary',
                          style: GoogleFonts.zenAntique(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  CategoryWidget(
                    categoryColor: Colors.teal[400],
                    categoryName: 'English Books',
                  ),
                  const SizedBox(width: 10),
                  CategoryWidget(
                    categoryColor: Colors.red[300],
                    categoryName: 'English Musics',
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  CategoryWidget(
                    categoryColor: Colors.indigo[400],
                    categoryName: 'English Movies',
                  ),
                  const SizedBox(width: 10),
                  CategoryWidget(
                    categoryColor: Colors.purple[300],
                    categoryName: 'English Podcasts',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final String categoryName;
  final Color? categoryColor;
  final double? categoryWidth;
  final void Function()? onTap;
  const CategoryWidget({
    super.key,
    required this.categoryColor,
    required this.categoryName,
    this.onTap,
    this.categoryWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: ((MediaQuery.of(context).size.width - 50) / 2) * (11 / 8),
          // width: categoryWidth ?? ((MediaQuery.of(context).size.width - 50) / 2),
          decoration: BoxDecoration(
            color: categoryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                categoryName,
                style: GoogleFonts.zenAntique(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/*
Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3 / 4,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.teal[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'English Books',
                          style: GoogleFonts.zenAntique(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red[300],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'English Vocabulary',
                          style: GoogleFonts.zenAntique(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.indigo[400],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'English Movies',
                          style: GoogleFonts.zenAntique(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.purple[300],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'English Podcasts',
                          style: GoogleFonts.zenAntique(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

                */