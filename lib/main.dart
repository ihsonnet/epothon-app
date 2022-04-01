import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'common/menu-card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.redAccent[200],
        child: const Icon(
          Icons.play_arrow,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: Image.asset(
          "images/logo.png",
          fit: BoxFit.cover,
          width: screenWidth / 3.5,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.document_scanner),
            color: Colors.black,
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: const [
            Greetings(),
            Menus(),
          ],
        ),
      ),
    );
  }
}

class Greetings extends StatelessWidget {
  const Greetings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 100,
      width: screenWidth,
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Good Afternoon , Sonnet",
            style: GoogleFonts.comfortaa(
                color: Colors.blueGrey[900],
                fontSize: 20,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(
            width: 10,
          ),
          Icon(
            Icons.wb_sunny,
            color: Colors.amber[800],
          )
        ],
      ),
    );
  }
}

class Menus extends StatelessWidget {
  const Menus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 1000,
      width: screenWidth,
      padding: const EdgeInsets.all(15.0),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: (300 / (screenWidth / 2)),
        children: [
          MenuCard(
            color: Colors.amber.shade400,
            icon: Icons.document_scanner,
            title: "Page Scanner",
          ),
          MenuCard(
            color: Colors.green.shade400,
            icon: Icons.playlist_play,
            title: "Book Player",
          ),
          MenuCard(
            color: Colors.blueGrey.shade400,
            icon: Icons.audio_file,
            title: "Audio Books",
          ),
          MenuCard(
            color: Colors.redAccent.shade200,
            icon: Icons.video_file,
            title: "Video Books",
          ),
          MenuCard(
            color: Colors.purple.shade400,
            icon: Icons.library_books,
            title: "PDF eBooks",
          ),
          MenuCard(
            color: Colors.blue.shade400,
            icon: Icons.local_library_outlined,
            title: "Publisher List",
          ),

        ],
      ),
    );
  }
}
