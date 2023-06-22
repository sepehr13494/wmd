import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';

import 'base_add_asset_stateful_widget.dart';

abstract class BaseAddAssetState<T extends BaseAddAssetStatefulWidget> extends AppState<T>{

  final formKey = GlobalKey<FormBuilderState>();
  bool enableAddAssetButton = false;
  bool enableAddAssetButtonEdit = false;
  Map<String,dynamic> starterJson = {};

  @override
  void initState() {
    if(widget.edit){
      Future.delayed(const Duration(milliseconds: 500),(){
        starterJson = formKey.currentState!.instantValue;
        setState(() {});
      });
    }
    super.initState();
  }

  void checkFinalValid(value) async {
    await Future.delayed(const Duration(milliseconds: 100));
    bool finalValid = (formKey.currentState!.isValid);

    if (finalValid) {
      if (!enableAddAssetButton) {
        setState(() {
          enableAddAssetButton = true;
        });
      }
    } else {
      if (enableAddAssetButton) {
        setState(() {
          enableAddAssetButton = false;
        });
      }
    }
    if(widget.edit){
      setState(() {
        if(mapEquals(starterJson,formKey.currentState!.instantValue)){
          enableAddAssetButtonEdit = false;
        }else{
          enableAddAssetButtonEdit = true;
        }
      });
    }
  }

}