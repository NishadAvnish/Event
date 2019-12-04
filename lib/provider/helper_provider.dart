import 'package:flutter/material.dart';

class LoadingData with ChangeNotifier{
  bool _isRebuildReq=true;
  bool get isRebuildReg{
    return _isRebuildReq;
  }

  set isRebuild(bool data){
      _isRebuildReq=false;
  }
}