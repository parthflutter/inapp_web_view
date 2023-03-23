import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Inapp_view_provider extends ChangeNotifier{

double progessweb=0;
InAppWebViewController ? inAppWebViewController;


void changeprogress(double ps)
{
  progessweb=ps;
  notifyListeners();
}
}