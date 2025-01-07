import 'package:book_talk/src/feature/room_detail/model/file_image.dart';
import 'package:image_picker/image_picker.dart';

abstract interface class RoomImageRepository {
  Future<FileImage?> pickImageFromGallery();
}

final class RoomImageRepositoryImpl implements RoomImageRepository {
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Future<FileImage?> pickImageFromGallery() async {
    final file = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) return null;

    return FileImage(
      path: file.path,
      name: file.name,
      lastModified: await file.lastModified(),
    );
  }
}
