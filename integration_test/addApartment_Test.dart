import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'helpers/test_timer.dart';
import 'package:upr_housing/model/apartments.dart';
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
  test('Measure apartment creation multiple times', () async {
    final apt = Apartment();
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'test2@gmail.com',
      password: '12345678',
    );

        // String uid = userCredential.user!.uid;
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final timer = TestTimer('Apartment Creation');

    // Run the operation 3 times
    for (int i = 0; i < 4; i++) {
      await timer.run(() => apt.addApartment(
            'Test Title $i',
            'Test Town',
            '1000',
            'Test Neighborhood',
            'Studio',
            'Any',
            'Testing summary',
            uid,
          ));
    }

    timer.printSummary();

    timer.printSummaryAndCopy();
  });
}