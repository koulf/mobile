import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:pract_dos/models/todo_reminder.dart';

import '../../models/todo_reminder.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  
  Box _reminderBox = Hive.box('Remainder');

  HomeBloc() : super(HomeInitialState());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is OnLoadRemindersEvent) {
      try {
        List<TodoRemainder> _existingReminders = _loadReminders();
        yield LoadedRemindersState(todosList: _existingReminders);
      } catch (EmptyDatabase)  {
        yield NoRemindersState();
      }
    }
    if (event is OnAddElementEvent) {
      _saveTodoReminder(event.todoReminder);
      yield NewReminderState(todo: event.todoReminder);
    }
    if (event is OnReminderAddedEvent) {
      yield AwaitingEventsState();
    }
    if (event is OnRemoveElementEvent) {
      _removeTodoReminder(event.removedAtIndex);
      if (_reminderBox.isEmpty)
        yield NoRemindersState();
    }
  }

  List<TodoRemainder> _loadReminders() {
    if (_reminderBox.isEmpty)
      throw EmptyDatabase();
    else {
      List<TodoRemainder> remainders = List<TodoRemainder>.from(_reminderBox.values);
      if (remainders.length == 0)
        throw EmptyDatabase();
      else
        return remainders;
    }
  }

  void _saveTodoReminder(TodoRemainder todoReminder) {
    _reminderBox.add(todoReminder);
  }

  void _removeTodoReminder(int removedAtIndex) {
    _reminderBox.deleteAt(removedAtIndex);
  }
}

class EmptyDatabase implements Exception {}
