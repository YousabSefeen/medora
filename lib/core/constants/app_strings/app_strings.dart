import 'package:medora/core/enum/payment_gateways_types.dart'
    show PaymentGatewaysTypes;

import '../../../generated/assets.dart';

class AppStrings {
  static List<String> images = [
    //boy
    'https://as1.ftcdn.net/v2/jpg/02/95/51/80/1000_F_295518052_aO5d9CqRhPnjlNDTRDjKLZHNftqfsxzI.jpg',
    //girl
    'https://i.pinimg.com/736x/62/44/97/624497ea5ae28be78867dafce4834e1c.jpg',
    //boy
    'https://i.pinimg.com/736x/6c/6e/d7/6c6ed7f4011b7f926b3f1505475aba16.jpg',

    //girl
    'https://i.pinimg.com/736x/20/f0/3d/20f03d2dc59c8f04ddcb6d6b602a0ebb.jpg',
    //boy
    'https://i.pinimg.com/736x/f2/f1/fa/f2f1fa3a611dfb4f4be81396ebca56eb.jpg',
    //girl
    'https://i.pinimg.com/736x/96/6a/ac/966aacaf096747852a12f9e33f926b96.jpg',
  ];

  // Titles
  static const String login = 'Login';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String register = 'Register';
  static const String registerNow = '$register now';
  static const String emailAlreadyInUseError =
      'This email address is already in use. If it’s your account, try logging in.';
  static const String unknownError = 'Unknown error occurred.';
  static const String doctorProfileTitle = 'Doctor Profile';

  // Labels
  static const String nameLabel = 'Name';
  static const String medicalSpecialtiesLabel = 'Medical Specialties';
  static const String bioLabel = 'Bio';
  static const String locationLabel = 'Location';
  static const String weeklySchedule = 'Weekly Schedule:';
  static const String workingDays = 'Working Days';
  static const String defaultHint = 'Tap to select';
  static const String workingDaysHint = ' $defaultHint days';
  static const String specialtiesHint = ' $defaultHint specialties';
  static const String workHoursHint = ' $defaultHint hours';
  static const String workingDaysDialogTitle = 'Select your working days';
  static const String specialtyHintMessage =
      'Choose your primary specialty, and you can add other related specialties.';

  static const String doctorSpecialtyHintSearchField =
      'Search for a medical specialty...';
  static const String specialtyLimitMessage =
      'You can select a maximum of 3 specialties.';
  static const List<String> weekDays = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];
  static const List<String> allMedicalSpecialties = [
    'General Practice',
    'Family Medicine',
    'Dentistry',
    'Dermatology',
    'Cosmetic Medicine',
    'Pediatrics',
    'Ophthalmology',
    'Obstetrics and Gynecology',
    'Cardiology',
    'Gastroenterology',
    'Nephrology',
    'Pulmonology',
    'Endocrinology',
    'Rheumatology',
    'Neurology',
    'Psychiatry',
    'Orthopedics',
    'Urology',
    'ENT (Otolaryngology)',
    'Plastic Surgery',
    'Neurosurgery',
    'General Surgery',
    'Cardiothoracic Surgery',
    'Vascular Surgery',
    'Anesthesiology',
    'Radiology',
    'Oncology',
    'Hematology',
    'Pathology',
    'Allergy and Immunology',
    'Physical Therapy',
    'Clinical Nutrition',
    'Geriatrics',
    'Infectious Diseases',
    'Emergency Medicine',
    'Internal Medicine',
  ];
  static const String confirm = 'Confirm';
  static const String workHours = 'Work Hours';
  static const String from = 'FROM';
  static const String to = 'TO';

  static const String availableFrom = 'Available From';

  static const String availableTo = 'Available To';
  static const String hintSelectTime = 'Select time';
  static const String requiredField = 'required field';
  static const String feesLabel = 'Fees';
  static const String fee = 'Fee';
  static const String waitingTime = 'Waiting time';
  static const String min_15 = '15 min';
  static const String egyptianCurrency = 'EGP';

  // Hint texts
  static const String nameHint = 'Enter your full name';

  static const String bioHint =
      'Write a short bio about your experience and expertise';
  static const String locationHint = 'Enter your clinic or hospital location';
  static const String feesHint = 'Enter your consultation fees';

  // Validation messages
  static const String nameValidationMessage = 'Please enter your name';
  static const String specialtiesValidationMessage =
      'Please enter your medical Specialties';
  static const String bioValidationMessage =
      'Please enter a short bio about yourself';
  static const String locationValidationMessage =
      'Please enter your clinic or workplace location';
  static const String feeValidationMessage =
      'Please enter your consultation fee';
  static const String feeInvalidMessage = 'Fee must be a valid integer number';

  // Button text
  static const String reloadFavorites = 'Reload Favorites';
  static const String saveButtonText = 'Save';

  static const String dR = 'Dr. ';
  static const String successMessage = 'Book Appointment Successfully';

  static const List<String> doctorNotAvailableMessage = [
    'Doctor is not available on the selected day. Please check the ',
    '"Working Days"',
    ' section\n to view the doctor\'s availability.',
  ];

  static List<String> specialtyNotFoundMessage({String? searchTerm}) => [
    'Sorry, we couldn\'t find any results for ',
    '"$searchTerm"',
    ' Please check your spelling, or try searching for a different specialty.',
  ];
  static const String searchNoResultsPrefix =
      'Sorry, we couldn\'t find any results for ';

  static const String searchNoResultsSuffix =
      '\n Please check your spelling, or try searching for a different specialty.';
  static const String imageNotFound =
      'Incorrect image URLs or changes in the image file\'s location';
  static const String noAppointmentsAvailableToday =
      'There are no appointments available today. Please choose another day.';

  static const String noBookingsMessage =
      'You have no bookings at the moment. Start by making a new appointment or check back later.';

  static const String oops = 'Oops! something is wrong!';
  static const String tryAgain = 'TRY AGAIN';
  static const String tryAgainNormal = 'Try Again';

  //Error
  static const String errorDisplayTitle = 'An error occurred while displaying';
  static const String errorMessageLabel = 'Error Message: ';
  static const String pastDateBookingError =
      'Appointments cannot be scheduled for past dates. '
      'Please select today\'s date or a future date.';

  static const String toggleFavoriteErrorMsg = 'Failed to update favorites';

  // static String noInternetConnection='No Internet Connection';
  // static const String kNoInternetBookingErrorMessage =
  //     'Booking an appointment requires an active internet connection to confirm and secure your reservation.\n'
  //     'Please check your connection and try again.';

  static const String noInternetConnectionErrorMsg =
      'Booking an appointment requires an active internet connection to confirm and secure your reservation.\n'
      'Please check your connection and try again.';
  static const String bookAppointment = 'Book Appointment';
  static const String next = 'Next';
  static const String payNow = 'Pay Now';

  //TODO Patient Screen
  static const String patientDetails = 'Patient Details';

  static const String fullNameLabel = 'Full Name';
  static const String male = 'Male';
  static const String female = 'Female';
  static const String fullNameHint = 'Please enter your name';
  static const String ageLabel = 'Your Age';
  static const String ageHint = 'Please enter your age';
  static const String problemLabel = 'Write your problem';
  static const String problemHint = 'Briefly describe your health concern...';

  static const String _payment = 'Payment';
  static const String paymobPayment = 'Paymob $_payment';
  static const String paypalPayment = 'Paypal $_payment';
  static const String stripePayment = 'Stripe $_payment';

  static const String paymentMethod = 'Payment Method';
  static const String noMatchingDoctorsFoundMessage =
      'No doctors found matching your search.';
  static const String searchEmptyMessage =
      'Find doctors by name, specialty, or location.\n Use filters for more options.';
  static const String searchHint = 'Search...';
  static const String appointmentSuccessDialogTitle = 'Congratulations!';
  static const String appointmentSuccessDialogMessage =
      'Appointment Successfully booked\n'
      'You will receive a notification and the doctor you selected will contact you';

  static const String viewAppointment = 'view Appointment';
  static const String cancel = 'Cancel';
  static const String cancelAppointment = '$cancel Appointment';
  static const String cancelAppointmentConfirmation =
      'Are you sure want to cancel your appointment';

  static const String partialRefundPolicyNote =
      'Only 80% of the money can you can refund from your payment according to our policy';
  static const String yesContinue = 'Yes, Continue';
  static const String confirmCancellation = 'Confirm Cancellation';
  static const String cancelAppointmentSuccess = '$cancelAppointment Success';
  static const String cancellationFeedbackDescription =
      'Help Us Improve Your Experience!\n'
      "Cancelling appointments affects our doctors' schedules and other patients.\n"
      'Your reason helps us:\n'
      '• Offer better availability\n'
      '• Improve our services\n'
      '• Reduce wait times for everyone';
  static const List<String> reasonsForCancellingList = [
    'I want to change the doctor',
    'I found another doctor with earlier availability',
    'I have a scheduling conflict',
    'Insurance doesn’t cover this visit / Cost is too high',
    'Need to postpone due to recovery from a procedure',
    'Other',
  ];
  static const String appointmentCancelledSuccessfully =
      'Your medical appointment has been canceled successfully. ';

  // 'If you need further assistance, feel free to contact us';
  static const String reschedule = 'Reschedule';
  static const String editBookingAppointment = 'Edit Booking Appointment';
  static const String rescheduleSuccessMessage =
      'Appointment rescheduled successfully!';
  static const String yourAppointment = 'Your appointment\nhas been updated!!';
  static const String done = 'Done';
  static const String confirmReschedule = 'Confirm Reschedule';
  static const List<String> appointmentsListTitles = [
    'Upcoming',
    'Completed',
    'Cancelled',
  ];
  static const String bookAgain = 'Book Again';
  static const String leaveAReview = 'Leave a Review';
  static const String emptyUpcomingAppointmentsMessage =
      'No upcoming appointments.\nSchedule your next visit when you’re ready.';

  static const String emptyCompletedAppointmentsMessage =
      'No completed appointments yet.\nYour past visits will show up here.';

  static const String emptyCancelledAppointmentsMessage =
      'No cancelled appointments.\nAny cancelled visits will appear here.';

  //TODO payment_gateways

  static const String stripe = 'Stripe';
  static const String stripeSub = 'Visa - MasterCard - American Express';
  static const String payPal = 'PayPal';
  static const String onlineCard = 'Online Card';
  static const String onlineCardSub = 'Visa - MasterCard - Meeza';
  static const String mobileWallets = 'Mobile Wallets';

  static const String enterPhoneNumberError = 'Please enter your phone number';

  static const String invalidPhoneNumberError = 'Invalid phone number';

  static final List<PaymentMethod> paymentOptions = [
    PaymentMethod(
      value: PaymentGatewaysTypes.paymobCard,
      name: onlineCard,
      subtitle: 'Visa - MasterCard - Meeza',
      logo: Assets.imagesOnlineCard,
    ),
    PaymentMethod(
      value: PaymentGatewaysTypes.paymobMobileWallets,
      name: mobileWallets,
      subtitle: '',
      logo: Assets.imagesMobileWalletsLogo,
    ),
    PaymentMethod(
      value: PaymentGatewaysTypes.stripe,
      name: stripe,
      subtitle: 'Visa - MasterCard - American Express',
      logo: Assets.imagesStripe,
    ),
    PaymentMethod(
      value: PaymentGatewaysTypes.payPal,
      name: payPal,
      subtitle: '',
      logo: Assets.imagesPayPal,
    ),
  ];

  static String messageBack =
      'You have canceled the payment, and the transaction was not completed.';

  // Errors
  static const paymentCancelledError = 'Payment cancelled by user.';
  static const paymentCancelledMsg = 'Payment cancelled. Please try again';

  static const String paymentFailedDescription =
      "We couldn't process your payment. Please:\n"
      '• Check your payment details\n'
      '• Try another payment method\n'
      '• Ensure sufficient balance';

  static const String paymentFailedError = 'Payment failed. Please try again.';

  static const String specialties = 'Specialties';
  static const String apply = 'Apply';
  static const String reset = 'Reset';
  static const String searchScreenTitle = 'Let\'s Find Your\nDoctor';

  static const String filterSearch = 'Filter Search';
  static const String reloadDoctors = 'Reload Doctors';

  static const String noMoreDoctorsMsg = 'No more doctors to load...';
}

class PaymentMethod {
  final PaymentGatewaysTypes value;
  final String name;
  final String subtitle;
  final String logo;

  PaymentMethod({
    required this.value,
    required this.name,
    required this.subtitle,
    required this.logo,
  });
}
