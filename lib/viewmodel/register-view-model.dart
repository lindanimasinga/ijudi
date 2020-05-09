import 'package:ijudi/model/profile.dart';
import 'package:ijudi/view/register-view.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class RegisterViewModel extends BaseViewModel<RegisterView> {
  
  String _id = "";

  String get id => _id;
  set id(String id) {
    _id = id;
     notifyChanged();
  }

  String _name = "";

  String get name => _name;
  set name(String name) {
    _name = name;
     notifyChanged();
  }

  String _lastname = "";

  String get lastname => _lastname;
  set lastname(String lastname) {
    _lastname = lastname;
     notifyChanged();
  }

  String _description = "";

  String get description => _description;
  set description(String description) {
    _description = description;
     notifyChanged();
  }

  int _yearsInService = 0;

  int get yearsInService => _yearsInService;
  set yearsInService(int yearsInService) {
    _yearsInService = yearsInService;
    notifyChanged();
  }

  String _address = "";

  String get address => _address;
  set address(String address) {
    _address = address;
  }

  String _imageUrl = "";

  String get imageUrl => _imageUrl;
  set imageUrl(String imageUrl) {
    _imageUrl = imageUrl;
  }

  int _likes = 0;

  int get likes => _likes;
  set likes(int likes) {
    _likes = likes;
  }

  int _servicesCompleted = 0;

  int get servicesCompleted => _servicesCompleted;
  set servicesCompleted(int servicesCompleted) {
    _servicesCompleted = servicesCompleted;
    notifyChanged();
  }

  int _badges = 0;

  int get badges => _badges;
  set badges(int badges) {
    _badges = badges;
     notifyChanged();
  }

  String _mobileNumber = "";

  String get mobileNumber => _mobileNumber;
  set mobileNumber(String mobileNumber) {
    _mobileNumber = mobileNumber;
     notifyChanged();
  }

  String _role = "";

  String get role => _role;
  set role(String role) {
    _role = role;
     notifyChanged();
  }

  int _responseTimeMinutes = 0;

  int get responseTimeMinutes => _responseTimeMinutes;
  set responseTimeMinutes(int responseTimeMinutes) {
    _responseTimeMinutes = responseTimeMinutes;
     notifyChanged();
  }

  String _password;

  String get password => _password;
  set password(String password) {
    _password = password;
     notifyChanged();
  }

  String _passwordConfirm;

  String get passwordConfirm => _passwordConfirm;
  set passwordConfirm(String passwordConfirm) {
    _passwordConfirm = passwordConfirm;
     notifyChanged();
  }

  bool _hasUkheshe = false;

  bool get hasUkheshe => _hasUkheshe;
  set hasUkheshe(bool hasUkheshe) {
    _hasUkheshe = hasUkheshe;
     notifyChanged();
  }

  Bank bank = Bank(name: null, account: null, type: null);
}
