import 'dart:typed_data';

import 'package:epothon_app/model/SliderModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
// import 'package:just_audio/just_audio.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:typed_data';


class SliderCard extends StatefulWidget {

  final SliderModel sliderModel;
  const SliderCard(
      {Key? key, required this.sliderModel})
      : super(key: key);

  @override
  State<SliderCard> createState() => _SliderCardState();
}

class _SliderCardState extends State<SliderCard> {
  @override
  void initState(){
    super.initState();
    generateToken();
  }

  String token = "";
  AudioPlayer thePlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();
  IconData? btnIcon = Icons.play_circle_fill;


  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        playAudio(widget.sliderModel.language, widget.sliderModel.textFile);
      },
      child: Card(
        color: Colors.blueGrey[200],
        elevation: 2,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Stack(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.network(
                        widget.sliderModel.imageFile!,
                        height: 100,
                        width: 80,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Container(
                    width: screenWidth/2-10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("C programming using pp", style: GoogleFonts.comfortaa(
                          fontSize: 16,fontWeight: FontWeight.bold,)),
                        const SizedBox(height: 10,),
                        Text("Type: Public", style: GoogleFonts.comfortaa(
                          fontSize: 14,)),
                        Text("Line: 14", style: GoogleFonts.comfortaa(
                          fontSize: 14,)),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    width: screenWidth * 3 / 4,
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      color: Colors.black12,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 6, bottom: 6, left: 10, right: 10),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Text(
                            "cardTitle",
                            style: GoogleFonts.comfortaa(
                              fontSize: 16,
                            ),
                          ),
                          Positioned(
                              right: -20,
                              child: MaterialButton(child: Icon(
                                  btnIcon,
                                  color: Colors.red,
                                  size: 35,
                                ),
                                onPressed: () {
                                  playAudio(widget.sliderModel.language, widget.sliderModel.textFile);
                                },
                                color: Colors.white,
                                shape: CircleBorder(),)
                          )
                        ],
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  void playAudio(String? language, String? textFile) async{
      if(btnIcon == Icons.pause_circle_filled){
        setState(() {
          thePlayer.stop();
          btnIcon = Icons.play_circle_fill;
        });
      }

      else {
        setState(() {
          btnIcon = Icons.downloading_rounded;
        });
        debugPrint(textFile.toString());
        String data = "<speak version='1.0' xml:lang='bn-BD'><voice xml:lang='bn-BD' xml:gender='Female' name='bn-BD-NabanitaNeural'>"+textFile!+"</voice></speak>";

        if(token.isEmpty){
          generateToken();
        }
        final response = await http.post(Uri.parse('https://southeastasia.tts.speech.microsoft.com/cognitiveservices/v1'),
            body: data,
            headers: { 'Authorization':token,
              'Content-type': 'application/ssml+xml',
              'Ocp-Apim-Subscription-Key': 'd1d347ce4c7d4d8a9d961c7ac998658d',
              'X-Microsoft-OutputFormat':'riff-24khz-16bit-mono-pcm',
              'User-Agent':'epothonTTS'});
        if (response.statusCode == 200) {
          setState(() {
            Uint8List audio_data = response.bodyBytes;
            void letsPlay() async {
              thePlayer = await audioCache.playBytes(audio_data);
            }
            letsPlay();
            btnIcon = Icons.pause_circle_filled;
          });
        } else {
          throw Exception('Unable to fetch Audio from the REST API');
        }
      }
  }

  void generateToken() async{
    final response = await http.post(Uri.parse('https://southeastasia.api.cognitive.microsoft.com/sts/v1.0/issueToken'),
        headers: { 'Content-type': 'application/json',
          'Ocp-Apim-Subscription-Key': 'd1d347ce4c7d4d8a9d961c7ac998658d'});
    if (response.statusCode == 200) {
      setState(() {
        token = "Bearer "+response.body.toString();
        debugPrint(token);
      });
    } else {
      throw Exception('Unable to fetch SliderModels from the REST API');
    }
  }
}