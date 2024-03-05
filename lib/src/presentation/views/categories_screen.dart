import 'package:flutter/material.dart';
import 'package:flutter_english/src/presentation/views/music/musics_list_screen.dart';
import 'package:flutter_english/src/presentation/views/vocabulary/vocabularies_list_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
  static const routeName = 'categories-screen';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 11, 23, 80),
        centerTitle: true,
        title: Text(
          'IMPROVE YOUR ENGLISH',
          style: GoogleFonts.abhayaLibre(
            color: Colors.white,
            // fontWeight: FontWeight.bold,
            // fontSize: 25,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/astronomy.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    context.goNamed(VocabulariesListScreen.routeName);
                  },
                  child: Container(
                    height: ((MediaQuery.of(context).size.width - 50) / 2) *
                        (11 / 8),
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/images/english.jpeg'),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.lightGreen[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(color: Colors.black12),
                          BoxShadow(color: Colors.black12),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        // color: Colors.black12,
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
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    CategoryWidget(
                      categoryColor: Colors.teal[400],
                      categoryName: 'English Books',
                      imagePath: 'assets/images/book.webp',
                    ),
                    const SizedBox(width: 10),
                    CategoryWidget(
                      categoryColor: Colors.red[300],
                      categoryName: 'English Musics',
                      imagePath: "assets/images/music.jpeg",
                      onTap: () {
                        context.goNamed(MusicListScreen.routeName);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    CategoryWidget(
                      categoryColor: Colors.indigo[400],
                      categoryName: 'English Movies',
                      imagePath: 'assets/images/movie.jpeg',
                    ),
                    const SizedBox(width: 10),
                    CategoryWidget(
                      categoryColor: Colors.purple[300],
                      categoryName: 'English Podcasts',
                      imagePath: 'assets/images/podcast.jpeg',
                    ),
                  ],
                ),
              ],
            ),
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
  final String imagePath;
  final void Function()? onTap;
  const CategoryWidget({
    super.key,
    required this.categoryColor,
    required this.categoryName,
    required this.imagePath,
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
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(color: Colors.black12),
                BoxShadow(color: Colors.black12),
              ],
            ),
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