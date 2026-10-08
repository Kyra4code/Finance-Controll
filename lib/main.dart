import 'package:flutter/material.dart';

import 'dart:ui';

import './pages/main_page.dart';
import './pages/month_manager.dart';

main() {
  // runApp(const MaterialApp(home: MainPage())); /*Tela principal */
  runApp(const MaterialApp(home: MonthManager())); /* Tela de gerenciamento mensal dos gastos*/
}
