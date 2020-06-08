import 'package:equatable/equatable.dart';

abstract class ZypherEvent extends Equatable {
  const ZypherEvent();
}

class GetCategoryInfo extends ZypherEvent{
  const GetCategoryInfo();
  @override
  List<Object> get props => [];
}
