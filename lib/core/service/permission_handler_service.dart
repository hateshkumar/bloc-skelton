import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/subjects.dart';

import '../widgets/dialog/reliable_dialog.dart';

enum ReliablePermission { CONTACTS, LOCATION, STORAGE, PHOTO, NOTIFICATION }

enum ReliablePermissionStatus { GRANTED, DENIED, PERMANENTLYDENIED }

class PermissionHandlerService {
  static final PermissionHandlerService _instance =
      PermissionHandlerService._internal();
  final BehaviorSubject<ReliablePermissionStatus> notificaitonPermissionStatus$ =
      BehaviorSubject();
  factory PermissionHandlerService() => _instance;
  PermissionHandlerService._internal();

  // TODO split this into askContactsPermission and askStoragePermission -> cleaner
  Future<ReliablePermissionStatus> askPermission(
    ReliablePermission permission,
  ) async {
    PermissionStatus? permissionStatus;
    if (permission == ReliablePermission.CONTACTS)
      permissionStatus = await _getContactPermission();
    if (permission == ReliablePermission.STORAGE)
      permissionStatus = await _getStoragePermission();
    if (permission == ReliablePermission.PHOTO)
      permissionStatus = await _getPhotoPermission();
    if (permission == ReliablePermission.LOCATION)
      permissionStatus = await _getLocationPermission();
    if (permission == ReliablePermission.NOTIFICATION)
      permissionStatus = await _getNotificationPermission();
    if (permissionStatus != null) {
      final ReliableStatus =
          ReliablePermissionStatusFromPermissionStatus(permissionStatus);
      notificaitonPermissionStatus$.add(ReliableStatus);
    }
    if (permissionStatus != null && permissionStatus == PermissionStatus.denied)
      return ReliablePermissionStatus.DENIED;
    else if (permissionStatus != null &&
        permissionStatus == PermissionStatus.permanentlyDenied)
      return ReliablePermissionStatus.PERMANENTLYDENIED;
    return ReliablePermissionStatus.GRANTED;
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.permanentlyDenied &&
        permission != PermissionStatus.granted) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  Future<PermissionStatus> _getLocationPermission() async {
    PermissionStatus permission = await Permission.location.status;
    if (permission != PermissionStatus.permanentlyDenied &&
        permission != PermissionStatus.granted) {
      PermissionStatus permissionStatus = await Permission.location.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  Future<PermissionStatus> _getNotificationPermission() async {
    // if (Platform.isIOS) {
    //   final setting = await FirebaseNotifications().requestPermissionsIOS();
    //   if (setting.authorizationStatus == AuthorizationStatus.authorized)
    //     return PermissionStatus.granted;
    //   else
    //     return PermissionStatus.denied;
    // } else
    return Permission.notification.request();
  }

  Future<PermissionStatus> _getStoragePermission() async {
    PermissionStatus permission = await Permission.storage.status;

    // {Suggestion}, there is no need to check the status of permission
    // even if you call .request() method multiple time, it shows the permission dialog for once only
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      PermissionStatus permissionStatus = await Permission.storage.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  Future<PermissionStatus> _getPhotoPermission() async {
    if (Platform.isIOS)
      return Permission.photos.request();
    else
      return Permission.storage.request();
  }

  Future<ReliablePermissionStatus> checkPermissionStatus(
      ReliablePermission permission) async {
    PermissionStatus? permissionStatus;
    if (permission == ReliablePermission.CONTACTS) {
      permissionStatus = await Permission.contacts.status;
    }
    if (permission == ReliablePermission.STORAGE) {
      permissionStatus = await Permission.storage.status;
    }
    if (permission == ReliablePermission.NOTIFICATION) {
      // if (Platform.isIOS) {
      //   final status =
      //       await FirebaseNotifications().notificationPermissionStatus();
      //   if (status == AuthorizationStatus.authorized)
      //     permissionStatus = PermissionStatus.granted;
      //   else
      //     permissionStatus = PermissionStatus.denied;
      // } else
      permissionStatus = await Permission.notification.status;
      if (permissionStatus != null) {
        final ReliableStatus =
            ReliablePermissionStatusFromPermissionStatus(permissionStatus);
        notificaitonPermissionStatus$.add(ReliableStatus);
      }
    }
    if (permission == ReliablePermission.PHOTO) {
      if (Platform.isIOS)
        permissionStatus = await Permission.photos.status;
      else
        permissionStatus = await Permission.storage.status;
    }
    if (permission == ReliablePermission.LOCATION) {
      permissionStatus = await Permission.location.status;
    }
    // Denied or expired https://github.com/Baseflow/flutter-permission-handler/wiki/Changes-in-6.0.0
    return ReliablePermissionStatusFromPermissionStatus(permissionStatus);
  }

  ReliablePermissionStatus ReliablePermissionStatusFromPermissionStatus(
      PermissionStatus? permissionStatus) {
    if (permissionStatus == PermissionStatus.denied)
      return ReliablePermissionStatus.DENIED;
    else if (permissionStatus == PermissionStatus.permanentlyDenied ||
        permissionStatus == PermissionStatus.restricted)
      return ReliablePermissionStatus.PERMANENTLYDENIED;
    return ReliablePermissionStatus.GRANTED;
  }

  Future<void> showStorageDeniedPermissionDialog(BuildContext context) {
    if (Platform.isIOS)
      return permissionDialog(
        context,
        "Please allow us access to your Files on you device.\n\n"
        "You can change permissions any time in your phone's settings under \"Files\".",
      );
    else
      return permissionDialog(
        context,
        "Please allow us access to your Photos, Files and Media on you device.\n\n"
        "You can change permissions any time in your phone's settings under \"Storage\".",
      );
  }

  Future<void> showPhotosDeniedPermissionDialog(BuildContext context) {
    if (Platform.isIOS)
      return permissionDialog(
        context,
        "Please allow us access to your Photos on you device.\n\n"
        "You can change permissions any time in your phone's settings under \"Photos\".",
      );
    else
      return permissionDialog(
        context,
        "Please allow us access to your Photos, Files and Media on you device.\n\n"
        "You can change permissions any time in your phone's settings under \"Storage\".",
      );
  }

  Future<void> showNotificationDeniedPermissionDialog(BuildContext context) {
    return permissionDialog(
      context,
      "Please allow us access to Notifications on your device.\n\n"
      "You can change permissions any time in your phone's settings under \"Notifications\".",
    );
  }
  

  Future<void> permissionDialog(BuildContext context, String bodyContent) {
    return showDialog(
      context: context,
      builder: (context) {
        return ReliableInfoDialog(
          title: 'Permission',
          content: Text(bodyContent),
          actions: [
            ReliableDialogButton(
              label: 'GO TO SETTINGS',
              onPressed: () async {
                await openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }
}
