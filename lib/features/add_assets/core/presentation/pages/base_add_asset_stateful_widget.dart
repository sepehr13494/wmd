import 'package:flutter/cupertino.dart';

abstract class BaseAddAssetStatefulWidget extends StatefulWidget{
  final bool edit;

  const BaseAddAssetStatefulWidget({Key? key, this.edit = false})
      : super(key: key);
}