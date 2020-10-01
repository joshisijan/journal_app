import 'package:flutter/material.dart';
import 'package:journal_app/model/event_model.dart';
import 'package:journal_app/services/database.dart';

class EventProvider extends ChangeNotifier {

  EventProvider(){
    setTodayEvents();
  }

  //today's events
  List<EventModel> _todayEvent = [];
  //total today's events
  int _todayTotal = 0;

  // limit and page
  int _limit = 20;
  int _todayPage = 1;

  //getters
  List<EventModel> get getTodayEvents => _todayEvent;
  int get getTodayTotal => _todayTotal;

  //setters
  setTodayEvents() async {
    try {
      _todayTotal = await AppDatabase().getTodayEventsTotal();
      if(_todayEvent.length == _todayTotal && _todayPage != 1) return;
      if(_todayPage == 1) _todayEvent = [];
      _todayEvent = _todayEvent + await AppDatabase().getTodayEvents(_limit, _todayPage);
      if(_todayEvent.length < _todayTotal){
        _todayPage = _todayPage + 1;
      }
      notifyListeners();
    } catch (e) {
      print('error from set today event\n' + e.toString());
    }
  }

  insertTodayEvent(EventModel eventModel) async {
    try {
      _todayPage = 1;
      await AppDatabase().insertEvent(eventModel);
      setTodayEvents();
    } catch (e) {
      print('error from insert event\n' + e.toString());
    }
  }
}
