import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:petnity/model/user_models/order_lists.dart';
import 'package:petnity/ui/widgets/modals.dart';

import '../../res/app_colors.dart';
import '../../res/app_strings.dart';
import '../../res/enum.dart';
import '../service_provider_models/all_agent_orders.dart';
import '../user_models/agent_services_lists.dart';
import '../user_models/order.dart';
import '../user_models/shop_order.dart';
import '../user_models/vet_orders.dart';
import 'base_viewmodel.dart';

class ServiceProviderInAppViewModel extends BaseViewModel {
  ServiceProviderInAppViewModel() {
    filterBankList = _banksAndInstitutions;
  }
  int _selectedIndex = -1;
  int _orderPageNumber = 1;
  String _withDrawableBalance = '0';
  int _currentPage = 1;
  File? _imageURl;
  File? _imageURl1;
  List<ShopOrders> _orders = [];

  List<Orders> _availableServices = [];
  List<VetOrders> _vetOrders = [];

  final List<int> _serviceSelectedIndexes = [];
  final List<int> _contactSelectedIndexes = [];
  String _amountController = '';

  final List<String> _servicesType = [];
  final List<int> _servicesIndex = [];

  final List<String> _contactType = [];
  final List<int> _contactIndex = [];

  List<Map<String, dynamic>> filterBankList = [];
  List<String> mediumIds = [];

  var addProductImage = [
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  addServiceType(int index, var item, var image) {
    if (_servicesType.length > 3) {
      _serviceSelectedIndexes.clear();
      _servicesType.clear();
      _servicesIndex.clear();
    } else {
      String serviceKey = '${item['name'][index]}-${image[index]}';

      if (_serviceSelectedIndexes.contains(index)) {
        _serviceSelectedIndexes.remove(index);
        mediumIds.add(item['name'][index]);


        _servicesType.remove(serviceKey);

        _servicesIndex.remove(index + 1);
      } else {
        _serviceSelectedIndexes.add(index);

        _servicesType.add(serviceKey);
        _servicesIndex.add(index + 1);
      }
    }
    setViewState(ViewState.success);
  }

  addContactType(int index, var item, var image) {
    if (contactType.length > 3) {
      _contactSelectedIndexes.clear();
      _contactType.clear();
      _contactIndex.clear();
    } else {
      String contactKey = '${item[index]}-${image[index]}';

      if (_contactSelectedIndexes.contains(index)) {
        _contactSelectedIndexes.remove(index);

        _contactType.remove(contactKey);

        _contactIndex.remove(index + 1);
      } else {
        _contactSelectedIndexes.add(index);

        _contactType.add(contactKey);
        _contactIndex.add(index + 1);
      }
    }
    setViewState(ViewState.success);
  }

  setWithdrawableBalance(String balance) {
    _withDrawableBalance = balance;
    setViewState(ViewState.success);
  }

  updateAmountController(String amount) {
    _amountController = amount;

    setViewState(ViewState.success);
  }

  resetBankList() {
    filterBankList = _banksAndInstitutions;

    setViewState(ViewState.success);
  }

  resetImage() {
    _imageURl1 = null;
    _imageURl = null;

    setViewState(ViewState.success);
  }

  setOrderPageIndex(int pageIndex) {
    _currentPage = pageIndex;

    setViewState(ViewState.success);
  }

 void searchBank(String query) {
  filterBankList = _banksAndInstitutions.where((bank) =>
    bank['name'].toLowerCase().contains(query.toLowerCase())).toList();
  setViewState(ViewState.success);
}


  setPackageLevelSelectedIndex({required int selectedIndex}) {
    _selectedIndex = selectedIndex;
    setViewState(ViewState.success);
  }

  setAgentOrdersList(AgentsOrderRequests orders) {
    _orders = orders.shopOrders ?? [];
    _orderPageNumber = orders.numPages ?? 1;

    setViewState(ViewState.success);
  }

  setAgentServicesList(AgentServicesList orders) {
    _availableServices = orders.data?.orders?.reversed.toList() ?? [];
    _vetOrders = orders.data?.vetOrders?.reversed.toList() ?? [];
    // _orderPageNumber = orders.numPages ?? 1;

    setViewState(ViewState.success);
  }

  removeImageFromList(int index) {
    addProductImage[index] = '';
    setViewState(ViewState.success);
  }

  loadImage(
      {required BuildContext context,
      bool isProfile = false,
      int index = 0}) async {
    await showModalBottomSheet<dynamic>(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
        builder: (BuildContext bc) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, right: 8.0, top: 8.0, bottom: 8.0),
                child: Text('Select the images source',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        color: AppColors.lightSecondary,
                        fontWeight: FontWeight.w700)),
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_camera,
                  size: 35.0,
                  color: AppColors.lightSecondary,
                ),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.pop(context);

                  final image = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                      imageQuality: 80,
                      maxHeight: 1000,
                      maxWidth: 1000);
                  if (isProfile) {
                    _imageURl1 = File(image!.path);
                  } else {
                    _imageURl = File(image!.path);

                    addProductImage[index] = _imageURl!.path;
                  }

                  setViewState(ViewState.success);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.photo,
                  size: 35.0,
                  color: AppColors.lightSecondary,
                ),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  final image = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 80,
                      maxHeight: 1000,
                      maxWidth: 1000);
                  if (isProfile) {
                    _imageURl1 = File(image!.path);
                  } else {
                    _imageURl = File(image!.path);

                    addProductImage[index] = _imageURl!.path;
                  }
                  setViewState(ViewState.success);
                },
              ),
            ],
          );
        });
  }

  Future<String> uploadImage(String imageUrl, String uploadPreset) async {
    final url = Uri.parse(AppStrings.getCloudinaryUrl);

    String image = '';

    try {
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = uploadPreset
        ..files.add(await http.MultipartFile.fromPath('file', imageUrl));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final resPonseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(resPonseString);

        Modals.showToast('saved');

        image = jsonMap['url'];

        return image;
      }else{
        Modals.showToast('not saved');

      }
    } catch (e) {}

    return image;
  }

  int get selectedIndex => _selectedIndex;
  File? get imageURl => _imageURl;
  File? get imageURl1 => _imageURl1;

  String get withdrawableBalance => _withDrawableBalance;

  List<String> get servicesType => _servicesType;
  List<int> get servicesIndex => _servicesIndex;
  List<int> get serviceSelectedIndexes => _serviceSelectedIndexes;

  List<String> get contactType => _contactType;
  List<int> get contactIndex => _contactIndex;
  List<int> get contactSelectedIndexes => _contactSelectedIndexes;

  String get amountController => _amountController;

  List<ShopOrders> get order => _orders;
  List<Orders> get availableServices => _availableServices;
  List<VetOrders> get vetOrders => _vetOrders;

  List<Map<String, dynamic>> _banksAndInstitutions = [
  {
    "name": "Access Bank",
    "slug": "access-bank",
    "code": "044",
    "ussd": "*901#",
    "logo": "https://nigerianbanks.xyz/logo/access-bank.png"
  },
  {
    "name": "Access Bank (Diamond)",
    "slug": "access-bank-diamond",
    "code": "063",
    "ussd": "*426#",
    "logo": "https://nigerianbanks.xyz/logo/access-bank-diamond.png"
  },
  {
    "name": "ALAT by WEMA",
    "slug": "alat-by-wema",
    "code": "035A",
    "ussd": "*945*100#",
    "logo": "https://nigerianbanks.xyz/logo/alat-by-wema.png"
  },
  {
    "name": "ASO Savings and Loans",
    "slug": "asosavings",
    "code": "401",
    "ussd": "",
    "logo": "https://nigerianbanks.xyz/logo/asosavings.png"
  },
  {
    "name": "Bowen Microfinance Bank",
    "slug": "bowen-microfinance-bank",
    "code": "50931",
    "ussd": "",
    "logo": "https://nigerianbanks.xyz/logo/default-image.png"
  },
  {
    "name": "CEMCS Microfinance Bank",
    "slug": "cemcs-microfinance-bank",
    "code": "50823",
    "ussd": "",
    "logo": "https://nigerianbanks.xyz/logo/cemcs-microfinance-bank.png"
  },
  {
    "name": "Citibank Nigeria",
    "slug": "citibank-nigeria",
    "code": "023",
    "ussd": "",
    "logo": "https://nigerianbanks.xyz/logo/citibank-nigeria.png"
  },
  {
    "name": "Ecobank Nigeria",
    "slug": "ecobank-nigeria",
    "code": "050",
    "ussd": "*326#",
    "logo": "https://nigerianbanks.xyz/logo/ecobank-nigeria.png"
  },
  {
    "name": "Ekondo Microfinance Bank",
    "slug": "ekondo-microfinance-bank",
    "code": "562",
    "ussd": "*540*178#",
    "logo": "https://nigerianbanks.xyz/logo/ekondo-microfinance-bank.png"
  },
  {
    "name": "Fidelity Bank",
    "slug": "fidelity-bank",
    "code": "070",
    "ussd": "*770#",
    "logo": "https://nigerianbanks.xyz/logo/fidelity-bank.png"
  },
  {
    "name": "First Bank of Nigeria",
    "slug": "first-bank-of-nigeria",
    "code": "011",
    "ussd": "*894#",
    "logo": "https://nigerianbanks.xyz/logo/first-bank-of-nigeria.png"
  },
  {
    "name": "First City Monument Bank",
    "slug": "first-city-monument-bank",
    "code": "214",
    "ussd": "*329#",
    "logo": "https://nigerianbanks.xyz/logo/first-city-monument-bank.png"
  },
  {
    "name": "Globus Bank",
    "slug": "globus-bank",
    "code": "00103",
    "ussd": "*989#",
    "logo": "https://nigerianbanks.xyz/logo/globus-bank.png"
  },
  {
    "name": "Guaranty Trust Bank",
    "slug": "guaranty-trust-bank",
    "code": "058",
    "ussd": "*737#",
    "logo": "https://nigerianbanks.xyz/logo/guaranty-trust-bank.png"
  },
  {
    "name": "Hasal Microfinance Bank",
    "slug": "hasal-microfinance-bank",
    "code": "50383",
    "ussd": "*322*127#",
    "logo": "https://nigerianbanks.xyz/logo/default-image.png"
  },
  {
    "name": "Heritage Bank",
    "slug": "heritage-bank",
    "code": "030",
    "ussd": "*322#",
    "logo": "https://nigerianbanks.xyz/logo/heritage-bank.png"
  },
  {
    "name": "Jaiz Bank",
    "slug": "jaiz-bank",
    "code": "301",
    "ussd": "*389*301#",
    "logo": "https://nigerianbanks.xyz/logo/default-image.png"
  },
  {
    "name": "Keystone Bank",
    "slug": "keystone-bank",
    "code": "082",
    "ussd": "*7111#",
    "logo": "https://nigerianbanks.xyz/logo/keystone-bank.png"
  },
  {
    "name": "Kuda Bank",
    "slug": "kuda-bank",
    "code": "50211",
    "ussd": "",
    "logo": "https://nigerianbanks.xyz/logo/kuda-bank.png"
  },
  {
    "name": "One Finance",
    "slug": "one-finance",
    "code": "565",
    "ussd": "*1303#",
    "logo": "https://nigerianbanks.xyz/logo/default-image.png"
  },
  {
    "name": "Paga",
    "slug": "paga",
    "code": "327",
    "ussd": "",
    "logo": "https://nigerianbanks.xyz/logo/paga.png"
  },
  {
    "name": "Parallex Bank",
    "slug": "parallex-bank",
    "code": "526",
    "ussd": "*322*318*0#",
    "logo": "https://nigerianbanks.xyz/logo/default-image.png"
  },
  {
    "name": "PayCom",
    "slug": "paycom",
    "code": "100004",
    "ussd": "*955#",
    "logo": "https://nigerianbanks.xyz/logo/default-image.png"
  },
  {
    "name": "Polaris Bank",
    "slug": "polaris-bank",
    "code": "076",
    "ussd": "*833#",
    "logo": "https://nigerianbanks.xyz/logo/polaris-bank.png"
  },
  {
    "name": "Providus Bank",
    "slug": "providus-bank",
    "code": "101",
    "ussd": "",
    "logo": "https://nigerianbanks.xyz/logo/default-image.png"
  },
  {
    "name": "Rubies MFB",
    "slug": "rubies-mfb",
    "code": "125",
    "ussd": "*7797#",
    "logo": "https://nigerianbanks.xyz/logo/default-image.png"
  },
  {
    "name": "Sparkle Microfinance Bank",
    "slug": "sparkle-microfinance-bank",
    "code": "51310",
    "ussd": "",
    "logo": "https://nigerianbanks.xyz/logo/sparkle-microfinance-bank.png"
  },
  {
    "name": "Stanbic IBTC Bank",
    "slug": "stanbic-ibtc-bank",
    "code": "221",
    "ussd": "*909#",
    "logo": "https://nigerianbanks.xyz/logo/stanbic-ibtc-bank.png"
  },
  {
    "name": "Standard Chartered Bank",
    "slug": "standard-chartered-bank",
    "code": "068",
    "ussd": "",
    "logo": "https://nigerianbanks.xyz/logo/standard-chartered-bank.png"
  },
  {
    "name": "Sterling Bank",
    "slug": "sterling-bank",
    "code": "232",
    "ussd": "*822#",
    "logo": "https://nigerianbanks.xyz/logo/sterling-bank.png"
  },
  {
    "name": "Suntrust Bank",
    "slug": "suntrust-bank",
    "code": "100",
    "ussd": "*5230#",
    "logo": "https://nigerianbanks.xyz/logo/default-image.png"
  },
  {
    "name": "TAJ Bank",
    "slug": "taj-bank",
    "code": "302",
    "ussd": "*898#",
    "logo": "https://nigerianbanks.xyz/logo/taj-bank.png"
  },
  {
    "name": "TCF MFB",
    "slug": "tcf-mfb",
    "code": "51211",
    "ussd": "*908#",
    "logo": "https://nigerianbanks.xyz/logo/default-image.png"
  },
  {
    "name": "Titan Trust Bank",
    "slug": "titan-trust-bank",
    "code": "102",
    "ussd": "*922#",
    "logo": "https://nigerianbanks.xyz/logo/default-image.png"
  },
  {
    "name": "Union Bank of Nigeria",
    "slug": "union-bank-of-nigeria",
    "code": "032",
    "ussd": "*826#",
    "logo": "https://nigerianbanks.xyz/logo/union-bank-of-nigeria.png"
  },
  {
    "name": "United Bank For Africa",
    "slug": "united-bank-for-africa",
    "code": "033",
    "ussd": "*919#",
    "logo": "https://nigerianbanks.xyz/logo/united-bank-for-africa.png"
  },
  {
    "name": "Unity Bank",
    "slug": "unity-bank",
    "code": "215",
    "ussd": "*7799#",
    "logo": "https://nigerianbanks.xyz/logo/default-image.png"
  },
  {
    "name": "VFD",
    "slug": "vfd",
    "code": "566",
    "ussd": "",
    "logo": "https://nigerianbanks.xyz/logo/default-image.png"
  },
  {
    "name": "Wema Bank",
    "slug": "wema-bank",
    "code": "035",
    "ussd": "*945#",
    "logo": "https://nigerianbanks.xyz/logo/wema-bank.png"
  },
  {
    "name": "Zenith Bank",
    "slug": "zenith-bank",
    "code": "057",
    "ussd": "*966#",
    "logo": "https://nigerianbanks.xyz/logo/zenith-bank.png"
  }
];



  int get pageIndex => _orderPageNumber;
  int get currentPage => _currentPage;

  List<Orders> get onGoingOrdersList => onGoingServices();

  List<VetOrders> get vetOnGoingOrdersList => vetOnGoingOrdersServices();

  List<Orders> onGoingServices() {
    List<Orders> list = [];

    for (var order in _availableServices) {
      if (order.isOngoing == true && order.isCompleted != true) {
        list.add(order);
      }
    }

    return list;
  }

  List<VetOrders> vetOnGoingOrdersServices() {
    List<VetOrders> list = [];

    for (var order in _vetOrders) {
      if (order.isOngoing == true && order.isCompleted != true) {
        list.add(order);
      }
    }

    return list;
  }
}
