import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastUtils {
  static void show(BuildContext context, String message,
      {bool isSuccess = true, int duration = 3}) {
    // isSuccess
    //     ? _showSuccess(context, message)
    //     : _showError(context, message);
    toastification.show(
      context: context,
      type: isSuccess ? ToastificationType.success : ToastificationType.error,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: Duration(seconds: duration),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSuccess ? Icons.check_circle : Icons.error,
            color: isSuccess ? Colors.green : Colors.red,
            size: 22,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              message,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 14,
                fontFamily: 'Chillax-medium',
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      alignment: Alignment.topCenter,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      icon: Icon(
        isSuccess ? Icons.check_circle : Icons.error,
        size: 0,
      ),
      primaryColor:Colors.white,
      backgroundColor: Colors.white,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      borderRadius: BorderRadius.circular(8),
      closeButtonShowType: CloseButtonShowType.onHover,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 10,
          spreadRadius: 2,
          offset: const Offset(0, 3),
        ),
      ],
      animationBuilder: (context, animation, alignment, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: const Offset(0, 0),
          ).animate(animation),
          child: child,
        );
      },
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: false,
      showProgressBar: false,
    );
  }

  static void showInternetError(BuildContext context, bool isSuccess) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.hideCurrentSnackBar();
    isSuccess
        ? scaffoldMessenger.showSnackBar(
            const SnackBar(
              content: Text(
                'Internet Connection Restored',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Chillax-medium'),
              ),
              backgroundColor: Colors.amber,
              duration: Duration(seconds: 3),
            ),
          )
        : scaffoldMessenger.showSnackBar(
            const SnackBar(
              content: Text(
                'No Internet Connection',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Chillax-medium'),
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
  }
}
