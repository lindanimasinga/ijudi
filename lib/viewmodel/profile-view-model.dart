import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/api/ukheshe/ukheshe-service.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class ProfileViewModel  extends BaseViewModel {
  
  UserProfile _userProfile;

  final ApiService apiService;
  final UkhesheService ukhesheService;

  ProfileViewModel({this.apiService, this.ukhesheService});

  @override
  void initialize() {
    apiService.findUserByPhone(apiService.currentUserPhone)
    .asStream()
    .map((resp) => userProfile = resp)
    .asyncExpand((resp) => ukhesheService.getAccountInformation().asStream())
    .listen((wallet) { 
      userProfile.bank = wallet;
    }, onError: (e) {
      showError(error: e);
      });
  }

  UserProfile get userProfile => _userProfile;

  set userProfile(UserProfile userProfile) {
    _userProfile = userProfile;
    notifyChanged();
  }

  
  
}