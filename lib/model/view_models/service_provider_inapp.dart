
 
import '../../res/enum.dart';
import 'base_viewmodel.dart';

class ServiceProviderInAppViewModel extends BaseViewModel {
   
  int _selectedIndex = -1 ;


  setPackageLevelSelectedIndex({required int selectedIndex}){

    _selectedIndex = selectedIndex;
    setViewState(ViewState.success);

  }


  int get selectedIndex => _selectedIndex;

}
