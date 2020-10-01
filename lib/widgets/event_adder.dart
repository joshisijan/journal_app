import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/model/event_model.dart';
import 'package:journal_app/providers/event_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EventAdder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(vertical: 40.0),
      child: Column(
        children: [
              Align(
                child: Container(
                  width: 200.0,
                  child: MaterialButton(
                    color: Theme.of(context).buttonColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text('Add new event'),
                      ],
                    ),
                    onPressed: () {
                      context.read<EventProvider>().insertTodayEvent(
                            EventModel(
                              year: DateTime.now().year,
                              month: DateTime.now().month,
                              day: DateTime.now().day,
                              hour: TimeOfDay.now().hour,
                              minute: TimeOfDay.now().minute,
                              description: 'new',
                            ),
                          );
                    },
                  ),
                ),
              ),
            ]
      ),
    );
  }
}
