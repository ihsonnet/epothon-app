import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  @override
  Widget build(BuildContext context) {

    var screenWidth = MediaQuery.of(context).size.width;

    File? imageFile;

    void _cropImage(filePath) async {
      File? croppedImage = await ImageCropper().cropImage(
          sourcePath: filePath, maxWidth: 1080, maxHeight: 1080);
      if(croppedImage != null){
        setState((){
          imageFile = croppedImage;
        });
      }
    }

    void _getFromGallery() async {
      PickedFile? pickedFile = await ImagePicker().getImage(source: ImageSource.gallery,maxHeight: 1080, maxWidth: 1080);
      _cropImage(pickedFile!.path);
    }

    void _getFromCamera() async {
      PickedFile? pickedFile = await ImagePicker().getImage(source: ImageSource.camera,maxHeight: 1080, maxWidth: 1080);
      _cropImage(pickedFile!.path);
    }

    return Scaffold(
        appBar: AppBar(
        elevation: 0.0,
        backgroundColor:  Colors.blueGrey[900],
        title: const Text("Scan any Page"),
      ),
      body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
              Container(
                  height: 500,
                  width: screenWidth,
                  padding: const EdgeInsets.all(15.0),
                  child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: (300 / (screenWidth / 2)),
                      children: [
                        Card(
                          elevation: 3,
                          color: Colors.white,
                          child: InkWell(
                            onTap: (){
                              _getFromCamera();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.camera_enhance_sharp,
                                    size: 50,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text("Via Camera",
                                      style: GoogleFonts.comfortaa(
                                          fontSize: 18, fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 3,
                          color: Colors.white,
                          child: InkWell(
                            onTap: (){
                              _getFromGallery();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.photo_album_rounded,
                                    size: 50,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text("From Gallery",
                                      style: GoogleFonts.comfortaa(
                                          fontSize: 18, fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ])
              ),
              Row(
              children: [
                const SizedBox(height: 10,),
                if (imageFile != null) const Text("Image Found") else const Text("Image Not Found!")
              ],
            ),
          ],)
      ),

    );
  }
}


