import 'package:flutter/services.dart';
import 'package:langvider/src/interactor/common/exception/login_exception.dart';

const _loginErrorCode = 'sign_in_failed';

class ExceptionMapper {
  Exception mapCommonError(Exception e) {
    if (e is PlatformException) {
      if (e.code == _loginErrorCode) {
        return LoginException();
      }
    }

    return e;
  }
}
