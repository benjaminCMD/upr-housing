import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:upr_housing/firebase_options.dart';
import 'package:upr_housing/main.dart'; // make sure this points to MyApp
import 'package:upr_housing/pages/home_page.dart';
import 'helpers/test_timer.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // testWidgets('Measure apartment UI load time', (tester) async {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );

  //   await FirebaseAuth.instance.signInWithEmailAndPassword(
  //     email: 'Jimmy24@gmail.com',
  //     password: '12345678',
  //   );

  //   // Wait until currentUser is actually available
  //   while (FirebaseAuth.instance.currentUser == null) {
  //     await Future.delayed(const Duration(milliseconds: 100));
  //   }

  //   print("✅ Signed in as: ${FirebaseAuth.instance.currentUser!.email}");

  //   final timer = TestTimer('Apartment UI Load');

  //   for (int i = 0; i < 2; i++) {
  //     await timer.run(() async {
  //       runApp(const MyApp()); // ⏱️ Load full app
  //       await tester.pumpAndSettle(); // Wait for animations/data

  //       // OPTIONAL: allow UI to fully settle
  //       await Future.delayed(const Duration(seconds: 1));

  //       // Check if apartment list loaded
  //       expect(find.byType(ListView), findsWidgets);
  //     });
  //   }

  //   timer.printSummary();
  //   timer.printSummaryAndCopy();
  // });
  testWidgets('Apartments should load under 5s', (tester) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: 'Jimmy24@gmail.com',
    password: '12345678',
  );

  final timer = TestTimer('Apartment Load');

  for (int i = 0; i < 2; i++) {
    await timer.run(() async {
      await tester.pumpWidget(const MaterialApp(home: HomePageApp()));
      await tester.pumpAndSettle();
      expect(find.byType(ListView), findsWidgets); // confirm data loaded
    });
  }

  // ✅ Show in Test Results panel
  expect(timer.averageTime, lessThan(5000), reason: 'Apartment loading should be fast');

  // ✅ Optional: Print result in console
  timer.printSummary();
  timer.printSummaryAndCopy();
});

}
