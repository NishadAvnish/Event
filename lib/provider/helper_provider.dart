import 'package:flutter/material.dart';

class ReLoadingData with ChangeNotifier{
  bool _isRebuildReq=true;
  bool get isRebuildReg{
    return _isRebuildReq;
  }

  set setRebuildReq(bool data){
      _isRebuildReq=false;
  }
}