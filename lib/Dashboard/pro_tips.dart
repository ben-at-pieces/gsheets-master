class Image {
  String imageUrl;
  int width;
  int height;

  Image({
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  void display() {
    print('Displaying image from $imageUrl with dimensions $width x $height');
  }
}
