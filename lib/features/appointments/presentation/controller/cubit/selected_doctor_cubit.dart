//
//
//
//
//
// import 'package:hydrated_bloc/hydrated_bloc.dart' show Cubit;
// import 'package:medora/core/enum/gender_type.dart' show GenderType;
// import 'package:medora/core/enum/payment_gateways_types.dart' show PaymentGatewaysTypes;
// import 'package:medora/features/appointments/presentation/controller/states/selected_doctor_state.dart' show SelectedDoctorState;
// import 'package:medora/features/appointments/presentation/data/selected_doctor_data.dart' show SelectedDoctorData;
//
// class SelectedDoctorCubit extends Cubit<SelectedDoctorState> {
//   SelectedDoctorCubit() : super(const SelectedDoctorState());
//
//   void cacheSelectedDoctor(SelectedDoctorData selectedDoctor) =>
//       emit(state.copyWith(selectedDoctor: selectedDoctor));
//
//   void onChangeSelectedGenderIndex(int index) {
//     final genderType = index == 0 ? GenderType.male : GenderType.female;
//     emit(state.copyWith(genderType: genderType));
//   }
//
//   void onChangePaymentMethod(PaymentGatewaysTypes paymentMethod) =>
//       emit(state.copyWith(selectedPaymentMethod: paymentMethod));
//
//   void markAsValidated() =>
//       emit(state.copyWith(hasValidatedBefore: true));
// }