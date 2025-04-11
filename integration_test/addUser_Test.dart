import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'helpers/test_timer.dart';
import 'package:upr_housing/model/users.dart';
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
  // If users already exist then tests will fail, as expected, delete them first from firebase
  testWidgets('Measure user creation multiple times', (tester) async {
    final user = Users();

    final timer = TestTimer('User Creation');

    for (int i = 0; i < 3; i++) {
      await timer.run(() async {
      final userCredential = await user.createUser('testUser_$i@gmail.com', '12345678');
        
      final uid = userCredential.user!.uid;

      await user.addUser('testUsername_$i', 'testUser_$i@gmail.com', '787-test_$i', uid);
      }
      
      );
    }

    timer.printSummary();

    timer.printSummaryAndCopy();
  });
}