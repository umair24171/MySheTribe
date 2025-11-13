import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Uuid _uuid = Uuid();

  // Upload profile image
  Future<String> uploadProfileImage(File imageFile, String userId) async {
    try {
      String fileName = '${_uuid.v4()}.jpg';
      Reference ref = _storage.ref().child('profile_images/$userId/$fileName');

      UploadTask uploadTask = ref.putFile(
        imageFile,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload profile image: $e');
    }
  }

  // Upload verification document
  Future<String> uploadVerificationDocument(File docFile, String userId) async {
    try {
      String fileName = '${_uuid.v4()}_verification.jpg';
      Reference ref = _storage.ref().child('verification_docs/$userId/$fileName');

      UploadTask uploadTask = ref.putFile(
        docFile,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload verification document: $e');
    }
  }

  // Upload event image
  Future<String> uploadEventImage(File imageFile, String eventId) async {
    try {
      String fileName = '${_uuid.v4()}.jpg';
      Reference ref = _storage.ref().child('event_images/$eventId/$fileName');

      UploadTask uploadTask = ref.putFile(
        imageFile,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload event image: $e');
    }
  }

  // Upload tribe image
  Future<String> uploadTribeImage(File imageFile, String tribeId) async {
    try {
      String fileName = '${_uuid.v4()}.jpg';
      Reference ref = _storage.ref().child('tribe_images/$tribeId/$fileName');

      UploadTask uploadTask = ref.putFile(
        imageFile,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload tribe image: $e');
    }
  }

  // Upload partnership offer image
  Future<String> uploadPartnershipImage(File imageFile, String offerId) async {
    try {
      String fileName = '${_uuid.v4()}.jpg';
      Reference ref = _storage.ref().child('partnership_images/$offerId/$fileName');

      UploadTask uploadTask = ref.putFile(
        imageFile,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload partnership image: $e');
    }
  }

  // Delete file from storage
  Future<void> deleteFile(String fileUrl) async {
    try {
      Reference ref = _storage.refFromURL(fileUrl);
      await ref.delete();
    } catch (e) {
      // Silently fail if file doesn't exist
      print('Failed to delete file: $e');
    }
  }

  // Get file download URL
  Future<String> getDownloadUrl(String filePath) async {
    try {
      Reference ref = _storage.ref().child(filePath);
      return await ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to get download URL: $e');
    }
  }

  // Upload file with progress tracking
  Stream<double> uploadFileWithProgress(File file, String path) {
    Reference ref = _storage.ref().child(path);
    UploadTask uploadTask = ref.putFile(file);

    return uploadTask.snapshotEvents.map((snapshot) {
      return snapshot.bytesTransferred / snapshot.totalBytes;
    });
  }
}
