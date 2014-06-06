import 'package:polymer/polymer.dart';

import 'dart:js';
import 'dart:html';
import 'dart:async';
import 'package:tekartik_jqm/jquerymobile.dart';
import 'package:tekartik_jqm/jqm_page.dart';
import 'package:tekartik_jqm/jqm_pagecontainer.dart';
import 'package:tekartik_utils/js_utils.dart';
import 'package:tekartik_utils/dev_utils.dart';
import 'package:tekartik_utils/polymer_utils.dart';
import 'package:tekartik_jquery/jquery.dart' as jq;
/**
 * A Polymer click counter element.
 */
@CustomTag('epoch-converter-page')
class EpochConverterPage extends JqmPage with PageHandleOnShow, PageHandleOnHide {

  JPageElement jPageElement;
  EpochConverterPage.created() : super.created() {
    print('EpochConverterPage created');

  }
  
  

  ready() {
    print('EpochConverterPage ready');
  }
  attached() {
     super.attached();
    print("EpochConverterPage attached id '$id'");
    //jPageElement.
 
  }
  //This enables the bootstrap javascript to see the elements
  //  @override
  //  Node shadowFromTemplate(Element template) {
  //    var dom = instanceTemplate(template);
  //    append(dom);
  //    shadowRootReady(this, template);
  //    return null; // no shadow here, it's all bright and shiny
  //  }

  //This enables the styling via bootstrap.css
  // bool get applyAuthorStyles => true;

  Timer timer;
  @override
  void onShow() {
    timer = new Timer.periodic(new Duration(seconds: 1), (_) {
      DateTime dateTime = new DateTime.now();
      int ms = dateTime.millisecondsSinceEpoch;
      $['current_epoch_time'].innerHtml = ms.toString();
      $['current_time_text'].innerHtml = dateTime.toString();
      print(new DateTime.now().millisecondsSinceEpoch);
    });
  }
  
  @override
   void onHide() {
     if (timer != null) {
       timer.cancel();
       timer = null;
     }
   }
}
