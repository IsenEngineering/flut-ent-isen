import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:flut/screens/calendar_screen.dart';
import 'package:flut/services/api_service.dart';
// import 'package:flut/model/calendar_event.dart';

// --- MOCKS ---

class MockApiService extends Mock implements ApiService {}

void main() {
  // late MockApiService mockApi;

  setUpAll(() async {
    registerFallbackValue(DateTime(2000)); // fallback for DateTime args
    await initializeDateFormatting('fr_FR', '');
  });

  setUp(() {
    // mockApi = MockApiService();
  });

  group('CalendarScreenState - date helpers', () {
    final state = CalendarScreen().createState();

    test('isOnSelectedDay returns true for event during selected day', () {
      state.selectedDay = DateTime(2025, 9, 14);
      final eventDate = DateTime(2025, 9, 14, 15, 0);
      expect(state.isOnSelectedDay(eventDate), isTrue);
    });

    test('isOnSelectedDay returns false for previous day', () {
      state.selectedDay = DateTime(2025, 9, 14);
      final eventDate = DateTime(2025, 9, 13, 23, 59);
      expect(state.isOnSelectedDay(eventDate), isFalse);
    });

/*
Disabling this test as it fails from 22h00 to 23h59
    test('isToday returns true for later today', () {
      final now = DateTime.now();
      final laterToday = now.add(const Duration(hours: 2));
      expect(state.isToday(laterToday), isTrue);
    });
 */

    test('isToday returns false for tomorrow', () {
      final tomorrow = DateTime.now().add(const Duration(days: 1));
      expect(state.isToday(tomorrow), isFalse);
    });

    test('isThisWeek returns true for +3 days', () {
      final in3 = DateTime.now().add(const Duration(days: 3));
      expect(state.isThisWeek(in3), isTrue);
    });

    test('isThisWeek returns false for +10 days', () {
      final in10 = DateTime.now().add(const Duration(days: 10));
      expect(state.isThisWeek(in10), isFalse);
    });

    test('isWithinSelectedWeek true if inside same week', () {
      state.selectedDay = DateTime(2025, 9, 17); // Wednesday
      final thursday = DateTime(2025, 9, 18);
      expect(state.isWithinSelectedWeek(thursday), isTrue);
    });

    test('isWithinSelectedWeek false if next week', () {
      state.selectedDay = DateTime(2025, 9, 17);
      final nextWeek = DateTime(2025, 9, 25);
      expect(state.isWithinSelectedWeek(nextWeek), isFalse);
    });
  });
  /*
  group('CalendarScreen widget + apiService', () {
    testWidgets('shows loading then DayView with events', (tester) async {
      final fakeEvent = CalendarEvent(
        id: '1',
        title: '08:00 - 10:00 - Mocked class name - Teacher name - Teacher surname - Location - Class Type - Class duration -  - ID',
        start: DateTime.now().add(const Duration(hours: 1)),
        end: DateTime.now().add(const Duration(hours: 2)),
        allDay: false,
        editable: false,
        className: 'CT',
      );
      when(() => mockApi.fetchCalendar(any(), any(), any()))
          .thenAnswer((_) async => [fakeEvent]);

      await tester.pumpWidget(MaterialApp(
        home: CalendarScreen(apiService: mockApi, token: 'fake-token'),
      ));

      // First frame = waiting
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pump(Duration(seconds: 1));

      // After future completes we should see DayView
      expect(find.text('Mocked class name'), findsOneWidget);

      verify(() => mockApi.fetchCalendar(any(), any(), any())).called(greaterThan(0));
    });

    testWidgets('shows error if apiService throws', (tester) async {
      when(() => mockApi.fetchCalendar(any(), any(), any()))
          .thenThrow(Exception('network down'));

      await tester.pumpWidget(MaterialApp(
        home: CalendarScreen(apiService: mockApi, token: 'fake-token'),
      ));

      await tester.pump(Duration(seconds: 1));

      expect(find.textContaining('Error:'), findsOneWidget);
    });
  });
   */
}
