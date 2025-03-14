
//Class for the products presented in the Home page
class Product{
  final String imageUrl;
  final String Owner;
  final String summary;
  final int likes;
  final double price;

  Product({
    required this.imageUrl,
    required this.Owner,
    required this.summary,
    required this.likes,
    required this.price,
  });
}