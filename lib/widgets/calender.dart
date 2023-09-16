import '../shared/exports.dart';

class EventCalendarScreen extends StatefulWidget {
  final Map<DateTime, List<GenericInvestmentHiveData?>> mySelectedEvents;

  const EventCalendarScreen({Key? key, required this.mySelectedEvents})
      : super(key: key);

  @override
  State<EventCalendarScreen> createState() => _EventCalendarScreenState();
}

class _EventCalendarScreenState extends State<EventCalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;
  Map<DateTime, List<GenericInvestmentHiveData?>> mySelectedEvents = {
    // DateTime(2023, 9, 14): [
    //   {"policyNo": "11", "name": "111"},
    //   {"policyNo": "22", "name": "22"}
    // ],
  };

  final titleController = TextEditingController();
  final descpController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = _focusedDay;

    loadPreviousEvents();
  }

  loadPreviousEvents() {
    mySelectedEvents = widget.mySelectedEvents;
  }

  List<GenericInvestmentHiveData?> _listOfDayEvents(DateTime dateTime) {
    List<GenericInvestmentHiveData?> events = [];
    mySelectedEvents.forEach((key, value) {
      if (isSameDay(dateTime, key)) {
        events.addAll(value);
      }
    });
    return events;
  }

  // _showAddEventDialog() async {
  //   await showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text(
  //         'Add New Event',
  //         textAlign: TextAlign.center,
  //       ),
  //       content: Column(
  //         crossAxisAlignment: CrossAxisAlignment.stretch,
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           TextField(
  //             controller: titleController,
  //             textCapitalization: TextCapitalization.words,
  //             decoration: const InputDecoration(
  //               labelText: 'Title',
  //             ),
  //           ),
  //           TextField(
  //             controller: descpController,
  //             textCapitalization: TextCapitalization.words,
  //             decoration: const InputDecoration(labelText: 'Description'),
  //           ),
  //         ],
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text('Cancel'),
  //         ),
  //         TextButton(
  //           child: const Text('Add Event'),
  //           onPressed: () {
  //             if (titleController.text.isEmpty &&
  //                 descpController.text.isEmpty) {
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 const SnackBar(
  //                   content: Text('Required title and description'),
  //                   duration: Duration(seconds: 2),
  //                 ),
  //               );
  //               //Navigator.pop(context);
  //               return;
  //             } else {
  //               print(titleController.text);
  //               print(descpController.text);

  //               // setState(() {
  //               //   if (mySelectedEvents[_selectedDate!] != null) {
  //               //     mySelectedEvents[_selectedDate!]?.add({
  //               //       "name": titleController.text,
  //               //       "policyNo": descpController.text,
  //               //     });
  //               //   } else {
  //               //     mySelectedEvents[_selectedDate!] = [
  //               //       {
  //               //         "name": titleController.text,
  //               //         "policyNo": descpController.text,
  //               //       }
  //               //     ];
  //               //   }
  //               //   print(mySelectedEvents.toString());
  //               // });

  //               // print(
  //               //     "New Event for backend developer ${json.encode(mySelectedEvents)}");
  //               titleController.clear();
  //               descpController.clear();

  //               Navigator.pop(context);
  //               return;
  //             }
  //           },
  //         )
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext contexmt) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: heading("Renewal Calender", 25),
          ),
          TableCalendar(
            // weekNumbersVisible: true,
//  headerVisible: ,
            calendarStyle: CalendarStyle(
              rangeHighlightColor: Colors.red,
            ),
            // dayHitTestBehavior: HitTestBehavior.translucent,
            firstDay: DateTime(2015),
            lastDay: DateTime(2042),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDate, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  _selectedDate = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              _focusedDay = focusedDay;
            },
            eventLoader: _listOfDayEvents,
          ),
          _listOfDayEvents(_selectedDate!).isEmpty
              ? Container(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: heading1("No renewals on this date", 18),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _listOfDayEvents(_selectedDate!).length,
                  itemBuilder: (context, index) {
                    return eventTile(_listOfDayEvents(_selectedDate!)[index]);
                  }),
          // _listOfDayEvents(_selectedDate!).isEmpty
          //     ? Container()
          //     : Container(
          //         child: _listOfDayEvents(_selectedDate!).map(
          //           (myEvents) => eventTile(myEvents),
          // ),
          // ),
        ],
      ),
    );
  }

  Widget eventTile(GenericInvestmentHiveData? myEvents) {
    return renderTile(myEvents, context);
    // HealthTile(model: myEvents as PolicyHiveModel, context: context);
  }
}
