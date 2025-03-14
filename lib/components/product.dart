class Product{
  //Class for the products presented in the Home page
  final String imageUrl;
  final String owner;
  final String summary;
  final int likes;
  final double price;

  Product({
    required this.imageUrl,
    required this.owner,
    required this.summary,
    required this.likes,
    required this.price,
  });
}