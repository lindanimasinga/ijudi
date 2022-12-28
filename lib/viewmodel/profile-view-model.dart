import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class ProfileViewModel extends BaseViewModel {
  UserProfile? _userProfile;
  final ApiService? apiService;

  ProfileViewModel({this.apiService});

  @override
  void initialize() {
    apiService!.findUserByPhone(apiService!.currentUserPhone).asStream().listen(
        (resp) {
      userProfile = resp;
    }, onError: (e) {
      showError(error: e);
    });
  }

  UserProfile? get userProfile => _userProfile;

  set userProfile(UserProfile? userProfile) {
    _userProfile = userProfile;
    notifyChanged();
  }

  updareUser() {
    progressMv?.isBusy = true;
    apiService
        ?.updateUser(_userProfile!)
        .then((value) => {
          progressMv?.isBusy = false
        });
  }
}
