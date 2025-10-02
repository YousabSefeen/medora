import 'package:flutter/material.dart';

import '../../../../../core/base/disposable.dart';

class DoctorFieldsControllers implements Disposable {


  final  formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  final bioController = TextEditingController();
  final locationController = TextEditingController();
  final feesController = TextEditingController();

  @override
  void dispose(){

    nameController.dispose();

    bioController.dispose();
    locationController.dispose();
    feesController.dispose();
  }
}
