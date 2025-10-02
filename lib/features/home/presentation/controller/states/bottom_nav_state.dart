import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavState extends Equatable {
  final int index;
  final bool isFabHidden;

  const BottomNavState({
    required this.index,
    this.isFabHidden = false,
  });

  BottomNavState copyWith({
    int? index,
    bool? isFabHidden,
  }) {
    return BottomNavState(
      index: index ?? this.index,
      isFabHidden: isFabHidden ?? this.isFabHidden,
    );
  }

  @override
  List<Object?> get props => [index, isFabHidden];
}



