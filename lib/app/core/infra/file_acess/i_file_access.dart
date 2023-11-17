import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:mensageiro/app/core/errors/errors.dart';

abstract class IFileAccess {
  Future<Either<Failure, String?>> captureImageBase64(
      {int? imageQuality, double? maxWidth, double? maxHeight});
  Future<Either<Failure, String?>> captureImagePath(
      {int? imageQuality, double? maxWidth, double? maxHeight});
  Future<Either<Failure, String?>> pickImageBase64(
      {int? imageQuality, double? maxWidth, double? maxHeight});
  Future<Either<Failure, String?>> pickImagePath(
      {int? imageQuality, double? maxWidth, double? maxHeight});
  Future<Either<Failure, String?>> document();
  Future<Either<Failure, Uint8List?>> pickAudio();
  Future<Either<Failure, Uint8List?>> pickDocument();
}
