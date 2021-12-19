void drawOpenCloseRModule(Area area) {
  RModule module = RModule.OpenClose;
  Size size = moduleSize(module);

  int x = layoutGuideX(area);
  int y = layoutGuideY(area);
  int w = moduleWidth(size);
  int h = moduleHeight(size);
  
  image(rmoduleShadowImage(size), x-SHADOW_PADDING, y-SHADOW_PADDING);
  // 開店／閉店によって、異なる背景画像を描画する。
  if (isOpen) {
    image(openCloseBackgroundOpen, x, y, w, h);
  } else {
    image(openCloseBackgroundClose, x, y, w, h);
  }

  if (isUpdatedOpenClose) {
    // 開店／閉店によって、異なるテキストを描画する。
    if (isOpen) {
      drawText(LEFT, BASELINE, WHITE_COLOR, 128, "OPEN", x+50, y+50);
      drawText(LEFT, BASELINE, WHITE_COLOR, 32, "開店しています。", x+50, y+250);
    } else {
      drawText(LEFT, BASELINE, WHITE_COLOR, 128, "CLOSE", x+50, y+50);
      drawText(LEFT, BASELINE, WHITE_COLOR, 32, "閉店しています。\n14時から開店します。", x+50, y+250);
    }
  } else {
    // 値が取得できなかったとき、エラーメッセージを表示。
    fill(0, 0, 0, 50);
    noStroke();
    rect(x, y, w, h, MODULE_RECT_ROUND);

    drawText(CENTER, CENTER, WHITE_COLOR, 24, "OpenCloseModule\nデータを取得できません", x+w/2, y+h/2);
  }
}

boolean updateOpenClose() {
  try {
    if (GPIO.digitalRead(SWITCH_PIN) == GPIO.LOW) {
      isOpen = true;
    } else {
      isOpen = false;
    }
  } catch (Exception e) {
    return false;
  }

  return true;
}
