import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import '../../store/AppCacheManager.dart';
import '../../../page/home/WelcomeView.dart';
import '../../../page/home/view.dart';
import '../../../store/EventBus.dart';
import '../../../util/UpdateView.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../api/request/apis.dart';
import '../../api/request/request.dart';
import '../../api/request/request_client.dart';
import '../../util/FetchContacts.dart';
import '../../util/PagingMixin.dart';
import '../../util/UpdateVersion.dart';
import '../../style/theme.dart';
import '../../widgets/helpTools.dart';

class ToolGrid {
  String title;
  String describe;
  String img;
  int index;

  ToolGrid(this.title, this.describe, this.img, this.index);
}

List<ToolGrid> getHomeEndLessLists() {
  List<ToolGrid> tradeList = [];
  for (var i = 0; i < 15; i++) {
    String title = getRandomStr(false, 6);
    int startI = 2;
    int endI = 3; // (title.length / 2).round();
    String radTit =
        "${title.substring(0, startI)}***${title.substring(title.length - endI)}";

    String subTitle = i % 2 == 0
        ? i < 8
            ? getRandomStr(true, 2)
            : getRandomStr(true, 3)
        : i > 12
            ? getRandomStr(true, 1)
            : getRandomStr(true, 4);
    String subTitle1 = getRandomStr(true, 2);
    String radSubTit = subTitle + '.' + subTitle1;

    double finDoub = double.parse(radSubTit.toString()) * 0.03128;
    String finDoubStr = finDoub.toStringAsFixed(2);

    ToolGrid item = ToolGrid(radTit, radSubTit, getRandomAvator(), 0);
    tradeList.add(item);
  }

  return tradeList;
}

List<ToolGrid> getToolGrid() {
  List<ToolGrid> tradeList = <ToolGrid>[
    ToolGrid('A', "", "assets/images/home/homeTool00.png", 0),
    ToolGrid('B', "", "assets/images/home/homeTool01.png", 1),
    ToolGrid('C', "", "assets/images/home/homeTool02.png", 2),
    ToolGrid('D', "", "assets/images/home/homeTool03.png", 3),
    ToolGrid('E', "", "assets/images/home/homeTool04.png", 4),
    ToolGrid('F', "", "assets/images/home/homeTool05.png", 5),
    ToolGrid('G', "", "assets/images/home/homeTool06.png", 6),
    ToolGrid('H', "", "assets/images/home/homeTool07.png", 7),
    ToolGrid('A', "", "assets/images/home/homeTool00.png", 8),
    ToolGrid('B', "", "assets/images/home/homeTool01.png", 9),
    ToolGrid('C', "", "assets/images/home/homeTool02.png", 10),
    ToolGrid('D', "", "assets/images/home/homeTool03.png", 11),
  ];
  return tradeList;
}

class HomeLogic extends GetxController
    with PagingMixin, GetTickerProviderStateMixin {
  final Duration duration = const Duration(milliseconds: 600);
  late AnimationController animationController;
  // late ScrollController scrollController;
  // late BuildContext context;
  // HomeLogic({required this.context});

  var barDatas = {}.obs;


  var tags = [].obs;
  var tagsCurrentIndex = 0;

  var banners = [].obs;
  var texts = [].obs;
  var lists = [].obs;
  var hdls = [].obs;
  var excels = [].obs;

  var listModel = {}.obs;

  var gridsSwiper = [].obs;
  var horScrollList1 = [].obs;
  var horScrollList2 = [].obs;

  var multiGrids = [].obs;

  var listDataFirst = [].obs;
  @override
  List get data => listDataFirst;

  var boolSafeword = 0.obs;
  String userWallet = '0';

  List<String> choseTypes = ['Today', 'Week', 'Month'];
  var choseId = 0.obs;

  var xparse = ''.obs;
  var y0parse = ''.obs;
  var y1parse = ''.obs;

  var finalChartString = ''.obs;

  @override
  void onInit() {
    animationController = AnimationController(vsync: this, duration: duration);

    barDatas.value = {
      'avatar': '',
      'name': 'select city',
    };

    tags.value  = [
      '0',
      'SDK',
      'Android Studio developer',
      'welcome to the jungle',
      '篝火营地',
    ];
    // scrollController= ScrollController();

    texts.value = [
      ' Stay Tuned ',
    ]; //or no scr

    for (int i = 0; i < 3; i++) {
      var vv = {'id': '$i', 'iconBig': '$i'};
      hdls.add(vv);
    }
    postCheckRequest();

    eventBus.on<GrabRefreshHomeEvent>().listen((event) {
      postRequest();
    });

    // FetchContacts().postUserInfo(context);

    // UpdateVersion().updateFun(context);

    choseId.value = 1;
    choseChartTypeData();
    update();

    super.onInit();
  }

  choseChartTypeData() {
    var x = choseId.value == 0
        ? ['8：00', '10：00', '12：00', '14：00', '18：00']
        : choseId.value == 1
            ? [
                '星期一',
                '星期二',
                '星期三',
                '星期四',
                '星期五',
                '星期六',
                '星期日',
              ]
            : [
                '11.1',
                '11.2',
                '11.3',
                '11.4',
                '11.5',
                '11.6',
                '11.7',
                '11.8',
                '11.9',
                '11.10',
                '11.11',
                '11.12',
                '11.13',
                '11.14',
                '11.15',
                '11.16',
                '11.17',
                '11.18',
                '11.19',
                '11.20',
                '11.21',
              ];
    var y0 = choseId.value == 0
        ? ['8', '8.67', '5', '16.33', '13.33']
        : choseId.value == 1
            ? ['7.4', '8', '8.67', '5', '16.33', '13.33', '19.4']
            : [
                '28',
                '8.67',
                '5',
                '16.33',
                '13.33',
                '17.4',
                '19.4',
                '28',
                '8.67',
                '5',
                '16.33',
                '13.33',
                '17.4',
                '19.4',
                '28',
                '8.67',
                '5',
                '16.33',
                '13.33',
                '17.4',
                '19.4'
              ];
    var y1 = choseId.value == 0
        ? ['3', '2.67', '3', '6.33', '3.33']
        : choseId.value == 1
            ? ['7.4', '8', '3', '2.67', '3', '6.33', '3.33']
            : ['28', '8.67', '3', '2.67', '6.33', '17.4', '19.4'];
    var y0Double = [];
    var y1Double = [];
    for (int i = 0; i < y0.length; i++) {
      y0Double.add(double.parse(y0[i]));
    }
    for (int i = 0; i < y1.length; i++) {
      y1Double.add(double.parse(y1[i]));
    }
    xparse.value = json.encode(x);
    y0parse.value = json.encode(y0Double);
    y1parse.value = json.encode(y1Double);

    setFinalStr();

    update();
  }

  setFinalStr() {
    String tit0 = 'a'.tr;
    String tit0Parse = json.encode(tit0);

    String tit1 = 'b'.tr;
    String tit1Parse = json.encode(tit1);

    // finalChartString.value = '';

    finalChartString.value = '''{
     exporting:{
     enabled : true,
     },
        chart: {
        events: {
				click: function (event) {
				return false;
				},
        },
        },
        
        tooltip: {
        enabled : true,
			backgroundColor: {
				linearGradient: [0, 0, 0, 60],
				stops: [
					[0, '#FFFFFF'],
					[1, '#E0E0E0']
				]
			},
			borderWidth: 1,
			borderColor: '#AAA'
		},
        plotLines:[{ 
    events:{
        click:function(){
             return false;
        },
         
    }
}],
        plotOptions: {
        
			series: {
			allowPointSelect: false,
				showInLegend: false,
				events: {
				click: function (event) {
				return false;
				},
					legendItemClick: function() {
						// return false 即可禁止图例点击响应
						return false;
					}
				}
			}
		},
		
      credits: {
    // enabled:true,                    // 默认值，如果想去掉版权信息，设置为false即可
    text: 'www.hcharts.cn',             // 显示的文字
    href: 'http://www.hcharts.cn',      // 链接地址
    position: {                         // 位置设置 
        align: 'left',
        x: 400,
        verticalAlign: 'bottom',
        y: -100
    },
    
    
    style: {                            // 样式设置
        cursor: 'pointer',
        color: 'red',
        fontSize: '30px'
    }
},  
      title: {
          text: ''
      },  
      
      yAxis: {
      title:{
       text:'',
      },},
        
      xAxis: {
   //    title:{
   //     text:'',
   // },
          categories:
          ${xparse} 
      },
      labels: {
          items: [{
              html: '',
              style: {
                  left: '50px',
                  top: '18px',
                  color: ( // theme
                      Highcharts.defaultOptions.title.style &&
                      Highcharts.defaultOptions.title.style.color
                  ) || 'black'
              }
          }]
      },
      series: [
       
      {
          type: 'spline',
          name: '',//${tit0Parse}
          data: ${y0parse},
          color:"#1652F0",
          marker: {
              lineWidth: 2,
              lineColor: '#1652F0',
              fillColor: 'white'
          }
      }, 
      {
          type: 'spline',
          name: '',//${tit1Parse}
          data: ${y1parse},
          color:"#FF065A",
          marker: {
              lineWidth: 2,
              lineColor: "#FF065A",
              fillColor: 'white'
          }
      },  
       
        ]
    }''';
  }

  @override
  void onClose() {
    // scrollController.dispose();
    super.onClose();
  }

  Future<void> postCheckRequest() async {
    if (AppCacheManager.instance.getUserToken().isEmpty) {
      return;
    }
      postRequest();
      requestData();
      // UpdateVersion().updateFun(Get.context,true);
      // FetchContacts().postUserInfo(Get.context);
      // Future.delayed(const Duration(seconds: 1)).then((value) {//once load
      //   Get.dialog(BonusView(
      //       '0', {'bonus': '0'},animationController),
      //       barrierDismissible: true);
      // });

      // Get.dialog(UpdateView('http://baidu.com', '1.0.2',
      //     "1.\n2.",
      //     'V2.0.0',true,true),barrierDismissible:false);

      // showDialog(
      //     context: Get.context! ,
      //     barrierDismissible: false,
      //     builder: (BuildContext context) {
      //       return UpdateView('http://baidu.com', '1.0.2',
      //           "1.\n2.",
      //           'V2.0.0',true,true);
      //     });

  }

  void postRequest() => request(() async {
        var data = await requestClient.post(APIS.home, data: {});
        listModel.value = data;
        banners.value = data['er'];
        List anns = data['n'] ?? [];
        if (anns.isNotEmpty) texts.value = data['n'];
        List lst = data['l'] ?? [];
        if (lst.isNotEmpty) lists.value = data['l'];
        hdls.value = data['l'];
        excels.value = data['l'];

        gridsSwiper.addAll(lst);
        horScrollList1.addAll(lst);
        horScrollList2.addAll(lst);
        multiGrids.addAll(lst);


        update();
      });

  void requestData() {
    // requestListData(true);
    dataRefresh();
  }

  @override
  Future dataRefresh() {
    page = 1;
    return requestListData(true);
  }

  @override
  Future loadMore() {
    page++;
    return requestListData(false);
  }

  Future requestListData(bool isRefresh) => request(() async {
        var params = {
          // 'pageNum': page.toString(),
          // 'pageSize':
          // // '5',
          // pageSize.toString(),
        };
        var data = await requestClient.post(APIS.home, data: params);

        List lst = data['l'] ?? []; //'pageList'

        if (isRefresh) {
          listDataFirst.value = lst;
        } else {
          listDataFirst.addAll(lst);
        }

        update();
      });

  void clickBottomIndex() {
    ///every request
  }
}
