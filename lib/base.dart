import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
abstract class BaseConnector{
  void showLoading( String message , {bool isDismissible });
  void showMessage( String Message , String posActionButton,{VoidCallback? posAction});
  void hideDialog();
}
class BaseViewModel<C extends BaseConnector> extends ChangeNotifier{
  C ?connector=null;
}

abstract class BaseView<VM extends BaseViewModel,T extends StatefulWidget> extends State<T> implements BaseConnector{
  late VM viewModel;
  VM initViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = initViewModel();
  }
  @override
  void hideDialog() {
    // TODO: implement hideDialog
    Navigator.pop(context);
  }

  @override
  void showLoading( String message,
      {bool isDismissible = true}) {
    showDialog(context: context, builder: (buildContext) {
      return AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 12),
            Text(message),
          ],
        ),
      );
    },
      barrierDismissible: isDismissible,
    );
  }

  @override
  void showMessage( String Message, String posActionButton,
      {VoidCallback? posAction}) {
    // TODO: implement showMessage
    List<Widget>actions = [];
    if (posActionButton != null) {
      actions.add(TextButton(
        child: Text(posActionButton),
        onPressed: () {
          Navigator.pop(context);
          if (posAction != null) {
            posAction();
          }
        },
      ));
    }
    showDialog(context: context, builder: (BuildContext) {
      barrierDismissible:
      true;
      return AlertDialog(
        content: Text(Message),
        actions: actions,
      );
    });
  }

}