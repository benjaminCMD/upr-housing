// import 'package:upr_housing/components/product.dart';
// import 'package:upr_housing/model/apartments.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// List<Product> p = [];


// Future<void> fetchApartments() async {
//   Apartment apt = Apartment();
//   QuerySnapshot querySnapshot = await apt.collection.get();

//   for (var doc in querySnapshot.docs) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

//     Product product = Product(
//       imageUrl: data['imageUrl'] ?? 'https://w7.pngwing.com/pngs/575/378/png-transparent-easter-bunny-hare-cottontail-rabbit-domestic-rabbit-european-rabbit-rabbit-mammal-image-file-formats-animals-thumbnail.png', // Default image if none is provided
//       summary: data['Summary'] ?? 'No summary available',
//       likes: data['Likes'] ?? 0,
//       price: data['Price'] ?? 0,
//       owner: data['Owner'] ?? 'Benjamin',
//     );

//     p.add(product);
//   }
// }




// List<Product> p = [
//     Product(imageUrl: 'https://w7.pngwing.com/pngs/575/378/png-transparent-easter-bunny-hare-cottontail-rabbit-domestic-rabbit-european-rabbit-rabbit-mammal-image-file-formats-animals-thumbnail.png',
//      summary: "Great Product!",
//       likes: 4500,
//        price: 500,
//        owner: "Humberto Sanchez Rivera"),
//     Product(imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOnWQ-PvcmDSpx5TknZ0jOPRra9HsJc3Vyew&s',
//      summary: "Great Product!",
//       likes: 400,
//       price: 200,
//       owner: "Benjamin"),
//     Product(imageUrl: 'https://w7.pngwing.com/pngs/575/378/png-transparent-easter-bunny-hare-cottontail-rabbit-domestic-rabbit-european-rabbit-rabbit-mammal-image-file-formats-animals-thumbnail.png',
//      summary: "Great Product!",
//       likes: 4000,
//       price: 700,
//       owner: "Jaime M Orta Santiago"),
//     Product(imageUrl: 'https://w7.pngwing.com/pngs/575/378/png-transparent-easter-bunny-hare-cottontail-rabbit-domestic-rabbit-european-rabbit-rabbit-mammal-image-file-formats-animals-thumbnail.png',
//      summary: "Great Product!",
//       likes: 2200,
//       price: 800,
//       owner: "Arnaldo"),
//     Product(imageUrl: 'https://w7.pngwing.com/pngs/575/378/png-transparent-easter-bunny-hare-cottontail-rabbit-domestic-rabbit-european-rabbit-rabbit-mammal-image-file-formats-animals-thumbnail.png',
//      summary: "Great Product!",
//       likes: 100,
//       price: 1300,
//       owner: "Enrique"),
//     Product(imageUrl: 'https://w7.pngwing.com/pngs/575/378/png-transparent-easter-bunny-hare-cottontail-rabbit-domestic-rabbit-european-rabbit-rabbit-mammal-image-file-formats-animals-thumbnail.png',
//      summary: "Great Product!",
//       likes: 2500,
//       price: 1100,
//       owner: "Sebastian"),
    
