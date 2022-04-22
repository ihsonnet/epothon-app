class SliderModel {
  String? id;
  String? imageFile;
  String? audioFile;
  String? language;
  String? textFile;

  SliderModel(
      {this.id, this.imageFile, this.audioFile, this.language, this.textFile});

  SliderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageFile = json['imageFile'];
    audioFile = json['audioFile'];
    language = json['language'];
    textFile = json['textFile'];
  }

  factory SliderModel.fromMap(Map<String, dynamic> json) {
    return SliderModel(
      id: json['id'],
      imageFile: json['imageFile'],
      audioFile: json['audioFile'],
      language: json['language'],
      textFile: json['textFile'],
    );
  }

  toJson() {}
}
