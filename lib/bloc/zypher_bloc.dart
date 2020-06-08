import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:zypher/data/zypher_repository.dart';
import 'package:zypher/models/category.dart';
import './bloc.dart';

class ZypherBloc extends Bloc<ZypherEvent, ZypherState> {
  final ZypherRepository repository;
  ZypherBloc({@required this.repository});
  @override
  ZypherState get initialState => InitialZypherState();

  @override
  Stream<ZypherState> mapEventToState(
    ZypherEvent event,
  ) async* {
    yield ZypherStateLoading();
    if(event is GetCategoryInfo){
      try {
        List<Category> categories = await repository.geCategoryInfo();
        yield ZypherStateLoaded(categories: categories);
      } catch (e) {
        print("EXCEPTION : ${e.toString()}");
        yield null;
      }
    }
  }
}
