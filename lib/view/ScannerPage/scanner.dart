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

File? imageFile;
String imagePath = "";

class _ScannerPageState extends State<ScannerPage> {
  @override
  Widget build(BuildContext context) {

    var screenWidth = MediaQuery.of(context).size.width;


    void _cropImage(filePath) async {
      File? croppedImage = await ImageCropper().cropImage(
          sourcePath: filePath, aspectRatio: const CropAspectRatio(ratioX: 6, ratioY: 10));
      if(croppedImage != null){
        setState((){
          debugPrint("Crop Done");
          debugPrint(croppedImage.path);
          imageFile = croppedImage;
          imagePath = croppedImage.path;
        });
      }
    }

    void _getFromGallery() async {
      XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      _cropImage(pickedFile!.path);
    }

    void _getFromCamera() async {
      XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
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
                  height: 200,
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
                                    size: 40,
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
                                    size: 40,
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
              Column(
              children: [
                Image.file(imageFile!,width: 200,),
                MaterialButton(onPressed: () {
                  debugPrint(imagePath);
                },color: Colors.red,child: Text("Click"),),
                if(imagePath != "") Text("Image Found") else Text("Image Not Found"),
              ],
            ),
          ],)
      ),

    );
  }
}


