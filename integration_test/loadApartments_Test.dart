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
  testWidgets('Apartments should load under 5s', (tester) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: 'Jimmy24@gmail.com',
    password: '12345678',
  );

  final timer = TestTimer('Apartment Load');

  for (int i = 0; i < 10; i++) {
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
