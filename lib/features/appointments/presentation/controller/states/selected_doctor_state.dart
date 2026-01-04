//
//
//
// import 'package:equatable/equatable.dart' show Equatable;
// import 'package:medora/core/enum/gender_type.dart' show GenderType;
// import 'package:medora/core/enum/payment_gateways_types.dart' show PaymentGatewaysTypes;
// import 'package:medora/features/appointments/presentation/data/selected_doctor_data.dart' show SelectedDoctorData;
//
// class SelectedDoctorState extends Equatable {
//   final SelectedDoctorData? selectedDoctor;
//   final bool hasValidatedBefore;
//   final GenderType genderType;
//   final PaymentGatewaysTypes selectedPaymentMethod;
//
//   const SelectedDoctorState({
//     this.selectedDoctor,
//     this.hasValidatedBefore = false,
//     this.genderType = GenderType.init,
//     this.selectedPaymentMethod = PaymentGatewaysTypes.none,
//   });
//
//   SelectedDoctorState copyWith({
//     SelectedDoctorData? selectedDoctor,
//     bool? hasValidatedBefore,
//     GenderType? genderType,
//     PaymentGatewaysTypes? selectedPaymentMethod,
//   }) {
//     return SelectedDoctorState(
//       selectedDoctor: selectedDoctor ?? this.selectedDoctor,
//       hasValidatedBefore: hasValidatedBefore ?? this.hasValidatedBefore,
//       genderType: genderType ?? this.genderType,
//       selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
//     );
//   }
//
//   @override
//   List<Object?> get props => [
//     selectedDoctor,
//     hasValidatedBefore,
//     genderType,
//     selectedPaymentMethod,
//   ];
// }
//
