import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../builder/viewModel_listener.dart';

final splashViewModel = StateNotifierProvider<SplashPageNotifier, bool>((ref) => SplashPageNotifier());

class SplashPageNotifier extends StateNotifier<bool> implements ViewModelListener {

  PageListener? _listener;

  initdata(){
    print("SplashPageNotifier");
  }

  SplashPageNotifier() : super(false);

/*  Future<void> checkUserDetails() async {
    try {
      var userToken = AppPreference().loginToken;
      var sessionToken = AppPreference().sessionToken;
      logger.fine("SessionToken : $sessionToken \nLoginToken: $userToken");
      if (userToken.isNotEmpty || sessionToken.isNotEmpty) {
        await Future.delayed(const Duration(seconds: 2));
        AppNav.toNamed(AppRoutes.homePage);
      } else {
        var response = await _repository.getSessionToken();
        AppPreference().updateSessionToken(response.sessionToken);
        AppPreference().updateSessionRefreshToken(response.sessionRefresh);
        AppNav.toNamed(AppRoutes.homePage);
      }
    } catch (e) {
      logger.warning("SplashException: ${e.toString()}");
      if (mounted) {
        _listener?.showSnackBar(e.toString());
      }
    }
  }*/

  @override
  void setPageListener(PageListener listener) {
    _listener = listener;
  }

  @override
  void startLoader() {}

  @override
  void stopLoader() {}
}
