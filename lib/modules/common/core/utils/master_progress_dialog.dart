import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../../../../config/master_colors.dart';

class MasterProgressDialog {
  MasterProgressDialog._();

  static ProgressDialog? _progressDialog;

  static Future<bool> showDialog(BuildContext context,
      {String? message}) async {
    if (_progressDialog == null) {
      _progressDialog = ProgressDialog(context,
          type: ProgressDialogType.normal,
          isDismissible: false,
          showLogs: true);

      _progressDialog!.style(
          message: message ?? 'loading',
          borderRadius: 5.0,
          backgroundColor: MasterColors.white,
          progressWidget: Container(
              padding: const EdgeInsets.all(10.0),
              child: const CircularProgressIndicator()),
          elevation: 10.0,
          insetAnimCurve: Curves.easeInOut,
          progress: 0.0,
          maxProgress: 100.0,
          progressTextStyle: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: MasterColors.textColor1),
          messageTextStyle: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: MasterColors.textColor1));
    }

    if (message != null) {
      _progressDialog!.update(message: message);
    }

    await _progressDialog!.show();

    return true;
  }

  static void dismissDialog() {
    if (_progressDialog != null) {
      _progressDialog!.hide();
      _progressDialog = null;
    }
  }

  static bool isShowing() {
    if (_progressDialog != null) {
      return _progressDialog!.isShowing();
    } else {
      return false;
    }
  }

  static void showDownloadDialog(BuildContext context, double progress,
      {String? message}) {
    if (_progressDialog == null) {
      _progressDialog = ProgressDialog(context,
          type: ProgressDialogType.download,
          isDismissible: false,
          showLogs: true);

      _progressDialog!.style(
          message: message ?? 'loading',
          borderRadius: 5.0,
          backgroundColor: MasterColors.white,
          progressWidget: Container(
              padding: const EdgeInsets.all(10.0),
              child: const CircularProgressIndicator()),
          elevation: 10.0,
          insetAnimCurve: Curves.easeInOut,
          progress: progress,
          maxProgress: 100.0,
          progressTextStyle: Theme.of(context).textTheme.bodyLarge,
          messageTextStyle: Theme.of(context).textTheme.bodyLarge);
    }

    _progressDialog!.update(message: message ?? 'loading', progress: progress);

    if (!_progressDialog!.isShowing()) {
      _progressDialog!.show();
    }
  }

  static void dismissDownloadDialog() {
    if (_progressDialog != null) {
      _progressDialog!.hide();
      _progressDialog = null;
    }
  }
}
