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
  InputElement timeNumberInput;
  InputElement dateTimeInput;

  static write2Digits(StringBuffer sb, int value) {
    String text = value.toString();
    for (int i = text.length; i < 2; i++) {
      sb.write('0');
    }
    sb.write(text);
  }
  void updateDateTimeInput(DateTime dateTime) {
    StringBuffer sb = new StringBuffer();
    sb.write(dateTime.year);
    sb.write('-');
    write2Digits(sb, dateTime.month);
    sb.write('-');
    write2Digits(sb, dateTime.day);
    sb.write('T');
    write2Digits(sb, dateTime.hour);
    sb.write(':');
    write2Digits(sb, dateTime.minute);
    //    sb.write(':');
    //    write2Digits(sb, dateTime.second);

    String text = sb.toString();
    print(text);
    dateTimeInput.value = text;
    //int year = dateTime...getFullYear();
    /*
      month = now.getMonth().toString().length === 1 ? '0' + (now.getMonth() + 1).toString() : now.getMonth() + 1;
      date = now.getDate().toString().length === 1 ? '0' + (now.getDate()).toString() : now.getDate();
      hours = now.getHours().toString().length === 1 ? '0' + now.getHours().toString() : now.getHours();
      minutes = now.getMinutes().toString().length === 1 ? '0' + now.getMinutes().toString() : now.getMinutes();
      seconds = now.getSeconds().toString().length === 1 ? '0' + now.getSeconds().toString() : now.getSeconds();
      * */

  }
  @override
  void onShow() {
    devPrint('onShow');
    DateTime dateTime = new DateTime.now();
    timeNumberInput = ($['time_number_input'] as InputElement);
    timeNumberInput.valueAsNumber = dateTime.millisecondsSinceEpoch;
    dateTimeInput = $['datetime_input'] as InputElement;
    updateDateTimeInput(dateTime);

    onTimeNumberInputChange(_) {
      print('changing number input ${timeNumberInput.value}');
      try {
        int ms = timeNumberInput.valueAsNumber.toInt();
        DateTime dateTime = new DateTime.fromMillisecondsSinceEpoch(ms);
        updateDateTimeInput(dateTime);
        $['error'].innerHtml = '';
      } catch (e, st) {
        print("$e $st");
        $['error'].innerHtml = 'invalid number';
      }

    }
    timeNumberInput.onChange.listen(onTimeNumberInputChange);
    timeNumberInput.onInput.listen(onTimeNumberInputChange);

    onDateTimeInputChange(_) {
      print('changing datetime input ${dateTimeInput.value}');
      try {
        //print('changing input ${dateTimeInput.value} ${dateTimeInput.valueAsDate} ${dateTimeInput.valueAsNumber}');
        int ms = dateTimeInput.valueAsNumber.toInt();
        DateTime dateTime = new DateTime.fromMillisecondsSinceEpoch(ms);
        timeNumberInput.valueAsNumber = dateTime.millisecondsSinceEpoch;
        $['error'].innerHtml = '';
      } catch (e, st) {
        // For firefox handle string
        try {
          //print('changing input ${dateTimeInput.value} ${dateTimeInput.valueAsDate} ${dateTimeInput.valueAsNumber}');
          DateTime dateTime = DateTime.parse(dateTimeInput.value);
          timeNumberInput.valueAsNumber = dateTime.millisecondsSinceEpoch;
          $['error'].innerHtml = '';
        } catch (e, st) {
          // For firefox handle string

          print("$e $st");
          $['error'].innerHtml = 'invalid date';
        }
      }

    }


    dateTimeInput.onInput.listen(onDateTimeInputChange);
    dateTimeInput.onChange.listen(onDateTimeInputChange);

    //    timer = new Timer.periodic(new Duration(seconds: 1), (_) {
    //      DateTime dateTime = new DateTime.now();
    //      int ms = dateTime.millisecondsSinceEpoch;
    //      $['current_epoch_time'].innerHtml = ms.toString();
    //      $['current_time_text'].innerHtml = dateTime.toString();
    //      // print(new DateTime.now().millisecondsSinceEpoch);
    //    });
  }

  @override
  void onHide() {
    if (timer != null) {
      timer.cancel();
      timer = null;
    }
  }
}
