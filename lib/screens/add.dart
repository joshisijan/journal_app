import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journal_app/model/event_model.dart';
import 'package:journal_app/providers/event_provider.dart';
import 'package:journal_app/reuseables/event_row.dart';
import 'package:journal_app/widgets/add_image.dart';
import 'package:journal_app/widgets/event_adder.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

// ignore: must_be_immutable
class Add extends StatelessWidget {
  final PageController pageController;
  Add({
    Key key,
    @required this.pageController,
  }) : super(key: key);

  List<EventModel> events;
  int totalEvents;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => EventProvider(),
        builder: (context, child) {
          events = context.select(
              (EventProvider eventProvider) => eventProvider.getTodayEvents);
          totalEvents = context.select(
              (EventProvider eventProvider) => eventProvider.getTodayTotal);
          return Stack(
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                child: ListView(
                  children: [
                        SizedBox(
                          height: 80.0,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              AddImage(),
                              Container(
                                height: 160,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      DateTime.now().year.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Text(
                                      DateFormat('dd MMMM')
                                          .format(DateTime.now())
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        EventAdder(),
                        Align(
                          child: Text(
                            events.length > 0
                                ? 'Scroll to show all of today\'s events.'
                                : 'Add some events!',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                      ] +
                      List.generate(events.length, (i) {
                        return EventRow(
                          key: Key('event#${events[i].id}'),
                          time: TimeOfDay(
                            hour: events[i].hour,
                            minute: events[i].minute,
                          ),
                          text: events[i].id.toString() +
                              '__' +
                              events[i].description,
                        );
                      }) +
                      [
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          alignment: Alignment.center,
                          child: totalEvents == events.length
                              ? Text(
                                  'THE END',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                )
                              : events.length > 0 ? VisibilityDetector(
                            key: Key('today event load move visibility checker'),
                            onVisibilityChanged: (visibilityInfo){
                              if(visibilityInfo.visibleFraction > 0){
                                context.read<EventProvider>().setTodayEvents();
                              }
                            },
                            child: Text(
                              'Loading...',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimary,
                              ),
                            ),
                          ) : SizedBox.shrink(),
                        ),
                      ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 10.0,
                right: 15.0,
                child: Container(
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward),
                    color: Theme.of(context).colorScheme.onPrimary,
                    onPressed: () {
                      pageController.animateToPage(
                        1,
                        curve: Curves.decelerate,
                        duration: Duration(milliseconds: 350),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        });
  }
}
