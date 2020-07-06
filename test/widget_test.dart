// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:medicpucp/Screens/login.dart';
import 'package:medicpucp/main.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // https://medium.com/flutter-community/testing-flutter-ui-with-flutter-driver-c1583681e337
  // #https://github.com/DK15/flutter-driver-demo/blob/master/test/widget_test.dart

   testWidgets('Ingresar usuario', (WidgetTester tester) async {

    MyApp loginScreen = new MyApp();

    // await tester.pumpWidget(loginScreen);

    // Finder hintText = find.byKey(Key('emailField'));
    // await tester.pump();

    // await tester.tap(hintText);
    // await tester.enterText(hintText, 'example');
    // expect(hintText.toString().length>0,true);

  });
}
