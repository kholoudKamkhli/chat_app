import 'package:chat_app/base.dart';
import 'package:chat_app/models/my_user.dart';

abstract class LoginConnector extends BaseConnector{
    goToHome(MyUser user);
}