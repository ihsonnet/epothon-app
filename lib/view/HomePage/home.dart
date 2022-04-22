import 'dart:convert';

import 'package:epothon_app/widget/slider-card.dart';
import 'package:epothon_app/view/ScannerPage/scanner.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:epothon_app/widget/menu-card.dart';
import 'package:epothon_app/model/SliderModel.dart';
import 'package:http/http.dart' as http;


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
            onPressed: () {
                Navigator.push(
                context, MaterialPageRoute(builder: (context) => const ScannerPage()));
              },
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
            Slider(),
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

    String greetingText = "Night";
    IconData greetingIcon = Icons.nightlight;
    Color? iconColor = Colors.blueGrey[800];

    DateTime _now = DateTime.now();
    if(_now.hour >= 5 && _now.hour < 11){
      greetingText = "Morning";
      greetingIcon = Icons.sunny_snowing;
      iconColor = Colors.amber[800];
    }
    else if(_now.hour >= 11 && _now.hour < 17){
      greetingText = "Noon";
      greetingIcon = Icons.sunny;
      iconColor = Colors.amber[800];
    }
    else if(_now.hour >= 17 && _now.hour < 21){
      greetingText = "Afternoon";
      greetingIcon = Icons.nightlight_outlined;
      iconColor = Colors.blueGrey[800];
    }
    else {
      greetingText = "Night";
      greetingIcon = Icons.nightlight;
      iconColor = Colors.blueGrey[800];
    }

    return Container(
      height: 100,
      width: screenWidth,
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Good "+greetingText+" , Sonnet",
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
            greetingIcon,
            color: iconColor,
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
      height: 500,
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

class Slider extends StatefulWidget {
  const Slider({Key? key}) : super(key: key);

  @override
  State<Slider> createState() => _SliderState();
}

class _SliderState extends State<Slider> {

  @override
  void initState() {
    super.initState();
    fetchSliderModels();
  }

    List<SliderModel> parseSliderModels(String responseBody) {
      final parsed = json.decode(responseBody)['data'].cast<Map<String, dynamic>>();
      return parsed.map<SliderModel>((json) => SliderModel.fromJson(json)).toList();
    }
    fetchSliderModels() async {
      final response = await http.get(Uri.parse('http://192.168.0.104:8082/api/ocr/api/ocr'));
      if (response.statusCode == 200) {
        List<SliderModel> sliderList =  parseSliderModels(response.body);
        debugPrint(sliderList.toString());
        setState(() {
          items = sliderList;
        });
      } else {
        throw Exception('Unable to fetch SliderModels from the REST API');
      }
    }

  List<SliderModel> items = [
    SliderModel(
      id: "yghfrty557658768",
      audioFile: "",
      imageFile: "https://us.123rf.com/450wm/yehorlisnyi/yehorlisnyi2104/yehorlisnyi210400016/167492439-no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-comin.jpg",
      textFile: "অনেকদিন পর আজ আবার লেখা। এতদিন যে লেখা হয়নি, তার কারণ যে শুধু কাজ, তা বলব না। খানিকটা ক্লান্তিও তো থাকতে পারে, না? যাই হোক, লিখতে বসার কারণ আমার একটি প্রিয় গান যেই মানুষটি গেয়েছেন, তাঁর চলে যাওয়া। পাঠকদের মধ্যে যারা বাংলাদেশি, তারা নিশ্চই এন্ড্রু কিশোরের নাম জেনে থাকবেন। আর পশ্চিমবঙ্গের পাঠকগণও হয়তো তাঁর গাওয়া গান শুনেছেন। সেই এন্ড্রু কিশোর আমাদের ছেড়ে চলে গেছেন ক’দিন আগে। আর সেই কারণেই হয়তো তাঁর গলায় গাওয়া হায়রে মানুষ রঙ্গীন ফানুস গানটি মনে বেজে চলছে। আমাদের জীবনগুলো যে কতটা ক্ষণস্থায়ী, আর সেই উপলব্ধিটুকু মন থেকে সরিয়েই যে আমরা আমাদের দৈনন্দিন জীবনে মেতে থাকি, তা খুব সরল ও সুন্দরভাবে ব্যক্ত হয়েছে গানটিতে। গীতিকার সৈয়দ শামসুল হক ফানুসকে উপমা হিসেবে ব্যবহার করে আমাদের মনোহর অথচ অচির জীবনকে যেভাবে তুলে ধরেছেন, তা পাঠকের মনে দাগ কাটতে বাধ্য। প্রয়াত গায়ককে মনে রেখে তাই এই জনপ্রিয় গানটি পংক্তি ও ভিডিওসহ তুলে দিলাম। সৈয়দ শামসুল হকের লেখা আর এন্ড্রু কিশোরের গলায় হায়রে মানুষ রঙ্গীন ফানুস।",
      language: "ben"
    ),
    SliderModel(
      id: "yghfrty557658768",
      audioFile: "",
      imageFile: "https://us.123rf.com/450wm/yehorlisnyi/yehorlisnyi2104/yehorlisnyi210400016/167492439-no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-comin.jpg",
      textFile: "",
      language: "ben"
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        itemBuilder: (BuildContext context, int index) => SliderCard(sliderModel: items[index]),
        separatorBuilder: (BuildContext context, _) => const SizedBox(width: 10), itemCount: items.length,
      ),
    );
  }
}

