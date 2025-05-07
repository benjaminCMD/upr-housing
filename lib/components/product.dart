class Product{
  //Class for the products presented in the Home page
  // String imageUrl;
  List<String> imageUrl;
  String title;
  String summary;
  int likes;
  String price;
  String uID;
  String town;
  String gender;


  Product({
    required this.imageUrl,
    required this.title,
    required this.summary,
    required this.likes,
    required this.price,
    required this.uID,
    required this.gender,
    required this.town
  });

  
}