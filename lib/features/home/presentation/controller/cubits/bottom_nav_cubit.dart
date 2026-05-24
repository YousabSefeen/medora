import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:medora/features/home/presentation/controller/states/bottom_nav_state.dart'
    show BottomNavState;

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(const BottomNavState(index: 0));

  void changeTabIndex(int newIndex) => emit(state.copyWith(index: newIndex));
}
