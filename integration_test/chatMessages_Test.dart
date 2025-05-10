import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:integration_test/integration_test.dart';
import 'package:upr_housing/firebase_options.dart';
import 'package:upr_housing/pages/userChatPage.dart';
import 'helpers/test_timer.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Chat send-to-receive timing only', (tester) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'Jimmy24@gmail.com',
      password: '12345678',
    );
    final currentUID = FirebaseAuth.instance.currentUser!.uid;

    final receiverSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isNotEqualTo: currentUID)
        .get();
    final receiverData = receiverSnapshot.docs.first.data();

    await tester.pumpWidget(MaterialApp(
      home: userChatPageApp(
        receiverUsername: receiverData['username'],
        receiverUserID: receiverData['uid'],
      ),
    ));
    await tester.pumpAndSettle();

    final timer = TestTimer('Chat Message Send -> UI Receive');

    for (int i = 0; i < 10; i++) {
      final message = 'Test $i at ${DateTime.now()}';

      // Type message
      await tester.enterText(find.byType(TextField), message);
      await tester.pump();

      await timer.run(() async {
        await tester.tap(find.byIcon(Icons.arrow_upward));
        await tester.pump();

        // Poll every 250ms up to 5s for the message to appear
        final start = DateTime.now();
        bool found = false;

        while (DateTime.now().difference(start).inMilliseconds < 5000) {
          await tester.pump(const Duration(milliseconds: 250));
          if (find.text(message).evaluate().isNotEmpty) {
            found = true;
            break;
          }
        }

        expect(found, isTrue, reason: 'Message "$message" was not received in UI');
      });
    }

    expect(timer.averageTime, lessThan(5000), reason: 'Message delivery is too slow');

    timer.printSummary();
    timer.printSummaryAndCopy();
  });
}
