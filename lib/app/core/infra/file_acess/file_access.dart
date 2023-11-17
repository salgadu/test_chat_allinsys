import 'dart:convert';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mensageiro/app/core/errors/errors.dart';
import 'package:mensageiro/app/core/infra/file_acess/i_file_access.dart';

class FileAccess implements IFileAccess {
  final ImagePicker _picker;
  final FilePicker _filePicker;

  FileAccess(this._picker, this._filePicker);

  @override
  Future<Either<Failure, String?>> captureImageBase64(
      {int? imageQuality, double? maxWidth, double? maxHeight}) async {
    try {
      final image = await _picker.pickImage(
          source: ImageSource.camera,
          preferredCameraDevice: CameraDevice.front,
          imageQuality: imageQuality,
          maxWidth: maxWidth,
          maxHeight: maxHeight);

      if (image == null) {
        return Right(null);
      }

      final imageBytes = await image.readAsBytes();
      String base64String = base64Encode(imageBytes);
      return Right(base64String);
    } catch (e) {
      return Left(FileException(message: 'Erro interno, por favor, tente mais tarde'));
    }
  }

  @override
  Future<Either<Failure, String?>> captureImagePath(
      {int? imageQuality, double? maxWidth, double? maxHeight}) async {
    try {
      final image = await _picker.pickImage(
          source: ImageSource.camera,
          preferredCameraDevice: CameraDevice.front,
          imageQuality: imageQuality,
          maxWidth: maxWidth,
          maxHeight: maxHeight);

      if (image == null) {
        return Right(null);
      }

      final imageBytes = await image.readAsBytes();
      String base64String = base64Encode(Uint8List.fromList(imageBytes));
      return Right(base64String);
    } catch (e) {
      return Left(FileException(message: 'Erro interno, por favor, tente mais tarde'));
    }
  }

  @override
  Future<Either<Failure, String?>> pickImageBase64(
      {int? imageQuality, double? maxWidth, double? maxHeight}) async {
    try {
      final image = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: imageQuality,
          maxWidth: maxWidth,
          maxHeight: maxHeight);

      if (image == null) {
        return Right(null);
      }

      final imageBytes = await image.readAsBytes();
      String base64String = base64Encode(Uint8List.fromList(imageBytes));
      return Right(base64String);
    } catch (e) {
      return Left(FileException(message: 'Erro interno, por favor, tente mais tarde'));
    }
  }

  @override
  Future<Either<Failure, String?>> pickImagePath(
      {int? imageQuality, double? maxWidth, double? maxHeight}) async {
    try {
      final image = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: imageQuality,
          maxWidth: maxWidth,
          maxHeight: maxHeight);

      if (image == null) {
        return Right(null);
      }

      return Right(image.path);
    } catch (e) {
      return Left(FileException(message: 'Erro interno, por favor, tente mais tarde'));
    }
  }

  @override
  Future<Either<Failure, Uint8List?>> pickDocument() async {
    try {
      final document = await _filePicker.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['pdf', 'doc']
      );

      if (document == null) {
        return Right(null);
      }

      return Right(document.files.first.bytes);
    } catch (e) {
      return Left(FileException(message: 'Erro interno, por favor, tente mais tarde'));
    }
  }

  @override
  Future<Either<Failure, Uint8List?>> pickAudio() async {
    try {
      final audio = await _filePicker.pickFiles(
        
        type: FileType.audio,
        allowMultiple: false,
      );

      if (audio == null) {
        return Right(null);
      }

      return Right(audio.files.first.bytes);
    } catch (e) {
      return Left(FileException(message: 'Erro interno, por favor, tente mais tarde'));
    }
  }
  
  @override
  Future<Either<Failure, String?>> document() {
    throw UnimplementedError();
  }
}
