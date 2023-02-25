import 'package:chat_app/base.dart';
import 'package:chat_app/models/my_user.dart';
import 'package:flutter/cupertino.dart';

abstract class CreateAccountConnector extends BaseConnector{
    goToHome(MyUser user);
}