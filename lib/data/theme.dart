import 'package:flutter/material.dart';
import 'colors.dart';

// 화이트 테마
ThemeData appThemeLight = ThemeData(
  brightness: Brightness.light, // 밝기 설정
  primaryColor: blue1, // 기본 색상: 검정
  scaffoldBackgroundColor: white1, // 배경 색상: 흰색
  appBarTheme: AppBarTheme(
    backgroundColor: white1, // 배경 색상: 흰색
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: blue1, // 배경 색상: 파랑
      foregroundColor: white1), // 플로팅 버튼 색상
  textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: blue1, // 커서 색상
  ), // 텍스트인풋선택시색상설정
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0), // 둥근 테두리 적용
      borderSide: BorderSide(color: blue1, width: 2.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0), // 둥근 테두리 적용
      borderSide: BorderSide(color: blue1, width: 2.0), // 포커스 시 테두리 색상 변경
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0), // 둥근 테두리 적용
      borderSide: BorderSide(color: Colors.grey, width: 1.0), // 기본 테두리 색상
    ),
    hintStyle: TextStyle(color: gray1), // 플레이스홀더 색상 변경
  ), // 텍스트인풋설정
);

// 다크테마
ThemeData appThemeDark = ThemeData.dark().copyWith(
  primaryColor: white1,
  colorScheme: ColorScheme.dark(primary: blue1),
);
