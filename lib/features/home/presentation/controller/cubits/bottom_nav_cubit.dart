import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:medora/features/home/presentation/controller/states/bottom_nav_state.dart' show BottomNavState;

class BottomNavCubit extends Cubit<BottomNavState> {
  // الحالة الأولية لـ Cubit
  BottomNavCubit() : super(const BottomNavState(index: 0));

  // دالة لتغيير فهرس العنصر المحدد
  void changeTabIndex(int newIndex) => emit(state.copyWith(index: newIndex));

  // دالة لإخفاء الزر العائم
  void hideFab() => emit(state.copyWith(isFabHidden: true));

  // دالة لإظهار الزر العائم
  void showFab() => emit(state.copyWith(isFabHidden: false));
}
