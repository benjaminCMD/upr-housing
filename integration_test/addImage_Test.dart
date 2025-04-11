import 'dart:io';


import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'helpers/test_timer.dart';
import 'package:upr_housing/model/images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:upr_housing/firebase_options.dart';

void main() {
  setUpAll(() async {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });

  testWidgets('Measure image uploading multiple times', (tester) async {
    final imageService = ImageService();
    final testImage = File('assets/images/google.png');


    expect(await testImage.exists(), isTrue, reason: 'Test image not found');

    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'test2@gmail.com',
      password: '12345678',
    );

    final timer = TestTimer('Image uploading to Firebase Storage');

    
    for (int i = 0; i < 2; i++) {
      await timer.run(() async{ 

        final testUrl = await imageService.addImage(testImage, 'testImage_aID_$i');

        expect(testUrl, isNotNull, reason: 'Download URL should not be null');
        expect(testUrl, contains('https://'), reason: 'Download URL should be valid');
        
        }
      
      );
    }

    timer.printSummary();

    timer.printSummaryAndCopy();
  });
}