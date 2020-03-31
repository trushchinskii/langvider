import 'package:langvider/src/interactor/common/exception/mapper/exception_mapper.dart';

class BaseRepository {
  final _exceptionMapper = ExceptionMapper();

  void handleCommonException(Exception e) {
    final Exception mappedException = _exceptionMapper.mapCommonError(e);
    throw mappedException;
  }
}
