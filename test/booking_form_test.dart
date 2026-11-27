import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_reservation_app/booking_form_page.dart';

Future<void> pumpForm(WidgetTester tester)async{
  tester.view.physicalSize = const Size(800,2400);
  tester.view.devicePixelRatio=1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const MaterialApp (home: BookingFormPage()));

}
Finder field(String label)=> find.widgetWithText(TextFormField, label);
void main(){
  testWidgets('AC1: empty form shows an error for every required field',(tester)async{
    await pumpForm(tester);
    await tester.tap(find.text('Reserve'));
    await tester.pump();

    expect(find.text('Please enter your name'), findsOneWidget);
    expect(find.text('Please enter your phone number'), findsOneWidget);
    expect(find.text('Choose a check-in date'), findsOneWidget);
    expect(find.text('Please accept the hotel policy'), findsOneWidget);
  });
  testWidgets('AC2: phone number with fewer than 10 digits is rejected',
      (tester) async {
    await pumpForm(tester);

    await tester.enterText(field('Phone number'), '12345');
    await tester.tap(find.text('Reserve'));
    await tester.pump();

    expect(find.text('Use 10 or 11 digits, numbers only'), findsOneWidget);
  });
  testWidgets('AC3: name shorter than 3 characters is rejected',
      (tester) async {
    await pumpForm(tester);

    await tester.enterText(field('Guest name'), 'Al');
    await tester.tap(find.text('Reserve'));
    await tester.pump();

    expect(find.text('Name must have at least 3 characters'), findsOneWidget);
  });
  testWidgets('AC4: valid booking opens the Choose Your Room screen',
      (tester) async {
    await pumpForm(tester);

    await tester.enterText(field('Guest name'), 'Ali Hassan');
    await tester.enterText(field('Phone number'), '0123456789');
    await tester.tap(find.text('Choose check-in date'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(CheckboxListTile));
    await tester.pump();
    await tester.tap(find.text('Reserve'));
    await tester.pumpAndSettle();

    expect(find.text('Choose Your Room'), findsOneWidget);
  });
  testWidgets('AC5: typing a valid name removes the name error',
      (tester) async {
    await pumpForm(tester);

    await tester.tap(find.text('Reserve'));
    await tester.pump();
    expect(find.text('Please enter your name'), findsOneWidget);

    await tester.enterText(field('Guest name'), 'Ali Hassan');
    await tester.pump();

    expect(find.text('Please enter your name'), findsNothing);
  });
}