class Product{
  //Class for the products presented in the Home page
  String imageUrl;
  String owner;
  String summary;
  int likes;
  double price;

  Product({
    required this.imageUrl,
    required this.owner,
    required this.summary,
    required this.likes,
    required this.price,
  });
}