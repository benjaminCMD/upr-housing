import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:upr_housing/components/product.dart';
import 'package:upr_housing/firebase_options.dart';
import 'package:upr_housing/pages/chatPage.dart';
import 'package:upr_housing/pages/focus_apartment.dart';
import 'package:upr_housing/pages/home_page.dart';
import 'package:upr_housing/pages/posting_Apt.dart';
import 'package:upr_housing/pages/login.dart';
import 'package:upr_housing/pages/signup.dart';
import 'package:upr_housing/pages/userChatPage.dart';
import 'helpers/test_timer.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Measure load time of all app pages under network conditions', (tester) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'Jimmy24@gmail.com',
      password: '12345678',
    );

    final loginTimer = TestTimer('Login Page Load');
    final signupTimer = TestTimer('Signup Page Load');
    final homeTimer = TestTimer('Home Page Load');
    final postTimer = TestTimer('Posting Page Load');
    final focusTimer = TestTimer('Apartment Detail Load');
    final chatTimer = TestTimer('Chat list Load');
    final individualChatTimer = TestTimer('Individual Chat Load');


    for (int i = 0; i < 10; i++) {
      // 1. Login Page
      await loginTimer.run(() async {
        await tester.pumpWidget(MaterialApp(home: LoginPage()));
        await tester.pumpAndSettle();
        expect(find.text('Sign In'), findsOneWidget);
      });

      // 2. Signup Page
      await signupTimer.run(() async {
        await tester.pumpWidget(MaterialApp(home: SignupPage()));
        await tester.pumpAndSettle();
        expect(find.text('Sign up'), findsOneWidget);
      });

      // 3. Home Page
      await homeTimer.run(() async {
        await tester.pumpWidget(const MaterialApp(home: HomePageApp()));
        await tester.pumpAndSettle();
        expect(find.byType(ListView), findsWidgets);
      });

      // 4. Posting Page
      await postTimer.run(() async {
        await tester.pumpWidget(const MaterialApp(home: PostingAptApp()));
        await tester.pumpAndSettle();
        expect(find.text('New Apartment'), findsOneWidget);
      });

      // 5. Apartment Detail Page
      await focusTimer.run(() async {
        final collection = FirebaseFirestore.instance.collection('Apartments');
        final snapshot = await collection.get();
        final data = snapshot.docs.first.data();

        final realProduct = Product(
          imageUrl: data['ImageUrl'] is List
              ? List<String>.from(data['ImageUrl'])
              : (data['ImageUrl'] is String
                  ? [data['ImageUrl']]
                  : ['https://w7.pngwing.com/pngs/575/378/png-transparent-easter-bunny-hare-cottontail-rabbit-domestic-rabbit-european-rabbit-rabbit-mammal-image-file-formats-animals-thumbnail.png']),
          summary: data['Summary'] ?? 'No summary available',
          likes: data['Likes'],
          price: data['Price'],
          title: data['Title'] ?? 'Unknown',
          uID: data['uID'],
          gender: data['Gender'],
          town: data['Town'],
        );

        await tester.pumpWidget(MaterialApp(home: FocusApartment(product: realProduct)));
        await tester.pumpAndSettle();
        expect(find.textContaining('Description'), findsWidgets);
      });
      // 6. Chat list page
      await chatTimer.run(() async {
        await tester.pumpWidget(const MaterialApp(home: chatPageApp()));
        await tester.pumpAndSettle();
        expect(find.text('Chat'), findsOneWidget);
      });
      // 5. Individual chat
      await individualChatTimer.run(() async {
        final collection = FirebaseFirestore.instance.collection('users');
        final snapshot = await collection.get();
        final data = snapshot.docs.first.data();

        await tester.pumpWidget(MaterialApp(home: userChatPageApp(receiverUsername: data['username'], receiverUserID: data['uid'])));
        await tester.pumpAndSettle();
        expect(find.textContaining('Enter Message'), findsWidgets);
      });
    }

    // ✅ Print results
    loginTimer.printSummaryAndCopy();
    signupTimer.printSummaryAndCopy();
    homeTimer.printSummaryAndCopy();
    postTimer.printSummaryAndCopy();
    focusTimer.printSummaryAndCopy();
    chatTimer.printSummaryAndCopy();
    individualChatTimer.printSummaryAndCopy();

    // ❌ Fail test if too slow
    expect(loginTimer.averageTime, lessThan(2000), reason: 'Login page should be in under 2 seconds');
    expect(signupTimer.averageTime, lessThan(2000), reason: 'Signup page should be in under 2 seconds');
    expect(homeTimer.averageTime, lessThan(2000), reason: 'Home page should be in under 2 seconds');
    expect(postTimer.averageTime, lessThan(2000), reason: 'Posting page should be in under 2 seconds');
    expect(focusTimer.averageTime, lessThan(2000), reason: 'Focus page should be in under 2 seconds');
    expect(chatTimer.averageTime, lessThan(2000), reason: 'Chat list should be in under 2 seconds');
    expect(individualChatTimer.averageTime, lessThan(2000), reason: 'Individual chat page should be in under 2 seconds');
  });
}

