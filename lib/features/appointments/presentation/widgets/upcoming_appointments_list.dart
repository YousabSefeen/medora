import 'package:cloud_firestore/cloud_firestore.dart'
    show Timestamp, FirebaseFirestore;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/upcoming_appointments_cubit.dart'
    show UpcomingAppointmentsCubit;
import 'package:medora/features/appointments/presentation/controller/states/upcoming_appointments_state.dart'
    show UpcomingAppointmentsState;
import 'package:medora/features/shared/presentation/screens/pagination_screen_mixin.dart'
    show PaginationScreenMixin;

import '../../../../core/enum/appointment_status.dart';
import 'appointment_card.dart';
// features/appointments/presentation/screens/upcoming_appointments_list.dart

class UpcomingAppointmentsList extends StatefulWidget {
  const UpcomingAppointmentsList({super.key});

  @override
  State<UpcomingAppointmentsList> createState() =>
      _UpcomingAppointmentsListState();
}

class _UpcomingAppointmentsListState extends State<UpcomingAppointmentsList>
    with
        PaginationScreenMixin<
          ClientAppointmentsEntity,
          UpcomingAppointmentsState,
          UpcomingAppointmentsCubit,
          UpcomingAppointmentsList
        > {
  Timestamp? _time;

  void testDateTime() {
    try {
      final date = '17/01/2026';
      final time = '11:00 AM'; // ✅ تأكد من وجود مسافة

      // تحقق من المسافة
      if (!time.contains(' ')) {
        print('⚠️ الوقت يحتاج مسافة قبل AM/PM');
        // أصلحه تلقائياً
        final fixedTime = time.replaceAllMapped(
          RegExp(r'(\d{1,2}:\d{2})(AM|PM)', caseSensitive: false),
          (match) => '${match.group(1)} ${match.group(2)}',
        );
        print('🔄 الوقت المصلح: $fixedTime');
      }

      final Timestamp timestamp = Timestamp.fromDate(
        DateFormat('dd/MM/yyyy hh:mm a').parse('$date $time'),
      );
      _time = Timestamp.fromDate(
        DateFormat('dd/MM/yyyy hh:mm a').parse('$date $time'),
      );
      print('✅ Timestamp: $timestamp');
      print(DateFormat('dd/MM/yyyy hh:mm a').format(timestamp.toDate()));
    } catch (e) {
      print('❌ Error: $e');
    }
  }
  void debugCollection() async {
    try {
      // 1. جلب كل الوثائق لفحصها
      final allDocs = await FirebaseFirestore.instance
          .collection('xxxx')
          .get();

      print('📊 Total documents: ${allDocs.docs.length}');

      // 2. عرض كل وثيقة مع تفاصيل الحقل time
      for (var doc in allDocs.docs) {
        final data = doc.data();
        final timeField = data['time'];

        print('\n📄 Document ID: ${doc.id}');
        print('📝 Full data: $data');

        if (timeField != null) {
          print('⏰ time field type: ${timeField.runtimeType}');
          print('⏰ time field value: $timeField');

          // تحقق إذا كان Timestamp
          if (timeField is Timestamp) {
            print('✅ Is Timestamp: true');
            print('📅 Parsed date: ${timeField.toDate()}');
            print('🔍 Is before now: ${timeField.toDate().isBefore(DateTime.now())}');
          } else {
            print('❌ Is Timestamp: false');

            // حاول التحويل إذا كان String
            if (timeField is String) {
              print('⚠️ time is String, trying to parse...');
              try {
                final date = DateTime.parse(timeField);
                print('📅 Parsed from String: $date');
              } catch (e) {
                print('❌ Cannot parse String: $e');
              }
            }
          }
        } else {
          print('⚠️ time field is null or missing');
        }
      }

      // 3. تجربة query مختلفة
      print('\n🔍 Testing different queries...');

      // أ) جلب كل الوثائق مع time field
      final docsWithTime = await FirebaseFirestore.instance
          .collection('xxxx')
          .where('time', isNull: false)
          .get();

      print('📊 Documents with time field: ${docsWithTime.docs.length}');

      // ب) جلب وثائق بمستقبل
      final futureDocs = await FirebaseFirestore.instance
          .collection('xxxx')
          .where('time', isGreaterThan: Timestamp.now())
          .get();

      print('📊 Documents with future time: ${futureDocs.docs.length}');

      // ج) جلب وثائق بماضي
      final pastDocs = await FirebaseFirestore.instance
          .collection('xxxx')
          .where('time', isLessThan: Timestamp.now())
          .get();

      print('📊 Documents with past time: ${pastDocs.docs.length}');

      if (pastDocs.docs.isEmpty) {
        print('❌ No past documents found. Possible issues:');
        print('   1. All times are in the future');
        print('   2. time field is not Timestamp type');
        print('   3. No time field exists');
        print('   4. Index missing for the query');
      }

    } catch (e, s) {
      print('❌ Error debugging collection: $e');
      print('📜 Stack trace: $s');
    }
  }
  @override
  Widget buildDataCard(ClientAppointmentsEntity appointment) {
    return GestureDetector(
      onTap: () async {
       // debugCollection();
        //   Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) =>
        //         AppointmentDetailsScreen(appointment: appointment),
        //   ),
        // );

        //  testDateTime();

        //   final c = await FirebaseFirestore.instance.collection('xxxx').doc('DBebCrh6knjcZLXyahm7').get();

       /* final snapShot = await FirebaseFirestore.instance
            .collection('xxxx')
            .where('time', isLessThan: Timestamp.now())
            .get();
       // snapShot.docs.map((e) => print('e ${e.data()}'));
        snapShot.docs.map((e) => print('e ${e.data()}')).toList();*/


        final date = '17/01/2026';
        final time = '12:00 AM'; // ✅ تأكد من وجود مسافة
        final Timestamp timestamp = Timestamp.fromDate(
          DateFormat('dd/MM/yyyy hh:mm a').parse('$date $time'),
        );

        firebaseSet(timestamp);
        print('timestamp $timestamp');
      },
      child: AppointmentCard(
        appointmentStatus: AppointmentStatus.confirmed,
        appointment: appointment,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpcomingAppointmentsCubit, UpcomingAppointmentsState>(
      builder: (context, state) => buildPaginationBody(context, state),
    );
  }

  void firebaseSet(Timestamp timestamp) async{
    await FirebaseFirestore.instance.collection('xxxx').add({

      'time':timestamp,

    });
  }
}

/*class UpcomingAppointmentsList extends StatefulWidget {
  const UpcomingAppointmentsList({super.key});

  @override
  State<UpcomingAppointmentsList> createState() =>
      _UpcomingAppointmentsListState();
}

class _UpcomingAppointmentsListState extends State<UpcomingAppointmentsList> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();

    // 🛑 التعديل: استخدام الاسم الموحد في الـ BaseCubit
    _fetchInitialList();

    scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _fetchInitialList() {
     context.read<UpcomingAppointmentsCubit>().fetchInitialList();
  }

  @override
  void dispose() {
    scrollController.dispose(); // أفضل من مجرد removeListener
    super.dispose();
  }

  void _scrollListener() {
    // 🛑 التعديل: ترك هامش بسيط (مثل 100 بكسل) لتحسين تجربة المستخدم
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100) {
      context.read<UpcomingAppointmentsCubit>().loadMore();
    }
  }

  // 🛑 التعديل: استخدام dataList بدلاً من appointments
  int _calculateItemCount(UpcomingAppointmentsState state) {
    int count = state.dataList.length;
    if (state.isLoadingMore || (!state.hasMore && state.dataList.isNotEmpty)) {
      count += 1;
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpcomingAppointmentsCubit, UpcomingAppointmentsState>(
      builder: (context, state) {
        // 🛑 التعديل: استخدام dataList و requestState الموحدة
        if (state.requestState == RequestState.loading && state.dataList.isEmpty) {
          return const LoadingList(height: 150);
        }

        if (state.requestState == RequestState.error && state.dataList.isEmpty) {
          return _buildErrorRetryWidget(state.failureMessage);
        }

        return ListView.builder(
          controller: scrollController,
          itemCount: _calculateItemCount(state),
          itemBuilder: (context, index) => _buildListItem(context, index, state),
        );
      },
    );
  }

  Widget _buildListItem(
      BuildContext context,
      int index,
      UpcomingAppointmentsState state,
      ) {
    if (index >= state.dataList.length) {
      return _buildFooterWidget(state);
    }
    return _buildAppointmentCard(state.dataList[index]);
  }

  Widget _buildFooterWidget(UpcomingAppointmentsState state) {
    return PaginationFooterWidget(
      isLoadingMore: state.isLoadingMore,
      hasMore: state.hasMore,
      doctorsList: state.dataList, // أو تمرير dataList حسب تعريف الـ Widget
    );
  }

  Widget _buildErrorRetryWidget(String failureMessage) => ErrorRetryWidget(
    errorMessage: failureMessage,
    retryButtonText: AppStrings.reloadDoctors,
    onRetry: () async => await context
        .read<UpcomingAppointmentsCubit>()
        .fetchInitialList(),
  );

  Widget _buildAppointmentCard(ClientAppointmentsEntity appointment) {
    return GestureDetector(
      onTap: () => _navigateToAppointmentDetails(context, appointment),
      child: AppointmentCard(
        appointmentStatus: AppointmentStatus.confirmed,
        appointment: appointment,
      ),
    );
  }

  void _navigateToAppointmentDetails(
      BuildContext context,
      ClientAppointmentsEntity appointment,
      ) => Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) =>
          AppointmentDetailsScreen(appointment: appointment),
    ),
  );
}*/
