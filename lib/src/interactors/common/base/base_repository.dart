import 'package:langvider/src/interactors/common/exception/mapper/exception_mapper.dart';

class BaseRepository {
  final _exceptionMapper = ExceptionMapper();

  void handleCommonException(Exception e) {
    Exception mappedException = _exceptionMapper.mapCommonError(e);

    throw mappedException;
  }
}
