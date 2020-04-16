import 'package:flutter/material.dart';
import 'package:langvider/src/interactor/common/exception/mapper/exception_mapper.dart';

class BaseRepository {
  final _exceptionMapper = ExceptionMapper();

  @protected
  T handleExecute<T>(T Function() executedBlock) {
    try {
      return executedBlock();
    } on Exception catch (e) {
      throw _exceptionMapper.mapCommonError(e);
    }
  }
}
