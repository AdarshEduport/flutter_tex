String optionTileHtml({required String bgColor,required String text ,required String optionText,required double width ,required String borderColor}){

  return
  '''<div style="padding: 12px; background: $bgColor; border-radius: 12px; border: 1px $borderColor solid; justify-content: flex-start; align-items: center; gap: 8px; display: inline-flex ; width: ${width}px">
    <div style="width: 26px; height: 26px; position: relative; border-radius: 16px">
      <div style="width: 26px; height: 26px; position: absolute; opacity: 0.70; background: $bgColor; border-radius: 20px"></div>
      <div style="left: 8px; top: 6px; position: absolute; opacity: 0.70; text-align: center; color: #263047; font-size: 14px; font-family: Poppins; font-weight: 600;">$optionText</div>
    </div>
    <div style="flex: 1 1 0; color: #000000; font-size: 14px; font-family: Poppins; font-weight: 500; line-height: 21px; word-wrap: break-word">$text</div>
</div>''';
}


String chooseNAnswer({required String n}){

  return
  '''<div style="opacity: 0.70; text-align: center; color: #263047; font-size: 14px; font-family: Poppins; font-weight: 500; line-height: 21px; word-wrap: break-word">Choose $n </div>''';
}

String htmlSizedBox({required double height,required double width}){
return '''<div style="width: ${width}px; height: ${height}px;"></div>''';
}