import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_reservation_app/room_list_page.dart';
import 'package:hotel_reservation_app/room_type.dart';

Future<void> pumpRooms(WidgetTester tester) async{
  tester.view.physicalSize = const Size(800, 2400);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    const MaterialApp(
      home: RoomListPage(
        preferred: RoomPreference.family,
        guests: 4,
        checkIn: '20/11/2026',
      ),
    ),
  );
}
List<ExpansionPanel>panels(WidgetTester tester){
  return tester
  .widget<ExpansionPanelList>(find.byType(ExpansionPanelList))
  .children;
}
void main(){
  testWidgets('the preferred room starts open',(tester) async{
    await pumpRooms(tester);
    expect(panels(tester).map((p)=>p.isExpanded), [false, false, true]);
  });
  testWidgets('tapping a collapsed header opens that panel', (tester) async {
    await pumpRooms(tester);
    await tester.tap(find.text('Single Room'));
    await tester.pumpAndSettle();

    expect(panels(tester).map((p) => p.isExpanded), [true, false, true]);
  });
}