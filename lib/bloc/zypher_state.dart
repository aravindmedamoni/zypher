import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:zypher/models/category.dart';

abstract class ZypherState extends Equatable {
  const ZypherState();
}

class InitialZypherState extends ZypherState {
  const InitialZypherState();
  @override
  List<Object> get props => [];
}

class ZypherStateLoading extends ZypherState{

  const ZypherStateLoading();
  @override
  List<Object> get props => [];

}

class ZypherStateLoaded extends ZypherState{
  final List<Category> categories;
  const ZypherStateLoaded({@required this.categories});

  @override
  List<Object> get props => [categories];
}

class ZypherStateError extends ZypherState{
  final String message;
  ZypherStateError({this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
