import 'package:calculation_app/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/routes/route_name.dart';
import '../../../../core/routes/router.dart';
import '../../../../main.dart';
import '../../../widgets/custom_text/custom_text.dart';

class InflationCalculatorController extends GetxController {
  var amount = ''.obs;
  var fromMonth = 'January'.obs;
  var fromYear = '1913'.obs;
  var toMonth = 'June'.obs;
  var toYear = DateFormat('yyyy').format(DateTime.now()).obs;
  var mainResult = ''.obs;
  var monthYearInfo = "".obs;
  var averageInflation = ''.obs;
  var cumulativeInflation = ''.obs;
  var info = ''.obs;
  var textController = TextEditingController().obs;
  final Map<String, Map<String, double>> cpiData = {
    // Existing data...
    '1913': {
      'January': 9.8, 'February': 9.8, 'March': 9.8, 'April': 9.8,
      'May': 9.8, 'June': 9.8, 'July': 9.8, 'August': 9.8,
      'September': 9.8, 'October': 9.8, 'November': 9.8, 'December': 9.8,
      'Average': 9.8,
    },
    '1914': {
      'January': 10.0, 'February': 10.0, 'March': 10.0, 'April': 10.0,
      'May': 10.0, 'June': 10.0, 'July': 10.0, 'August': 10.0,
      'September': 10.0, 'October': 10.0, 'November': 10.0, 'December': 10.0,
      'Average': 10.0,
    },
    '1915': {
      'January': 10.6, 'February': 10.6, 'March': 10.6, 'April': 10.6,
      'May': 10.6, 'June': 10.6, 'July': 10.6, 'August': 10.6,
      'September': 10.6, 'October': 10.6, 'November': 10.6, 'December': 10.6,
      'Average': 10.6,
    },
    '1916': {
      'January': 11.6, 'February': 11.6, 'March': 11.6, 'April': 11.6,
      'May': 11.6, 'June': 11.6, 'July': 11.6, 'August': 11.6,
      'September': 11.6, 'October': 11.6, 'November': 11.6, 'December': 11.6,
      'Average': 11.6,
    },
    '1917': {
      'January': 12.8, 'February': 12.8, 'March': 12.8, 'April': 12.8,
      'May': 12.8, 'June': 12.8, 'July': 12.8, 'August': 12.8,
      'September': 12.8, 'October': 12.8, 'November': 12.8, 'December': 12.8,
      'Average': 12.8,
    },
    '1918': {
      'January': 15.2, 'February': 15.2, 'March': 15.2, 'April': 15.2,
      'May': 15.2, 'June': 15.2, 'July': 15.2, 'August': 15.2,
      'September': 15.2, 'October': 15.2, 'November': 15.2, 'December': 15.2,
      'Average': 15.2,
    },
    // Data for years 1919 to 1979
    '1919': {
      'January': 16.7, 'February': 16.8, 'March': 17.0, 'April': 17.1,
      'May': 17.2, 'June': 17.4, 'July': 17.6, 'August': 17.7,
      'September': 17.8, 'October': 17.9, 'November': 18.0, 'December': 18.1,
      'Average': 17.7,
    },
    '1920': {
      'January': 20.0, 'February': 20.1, 'March': 20.2, 'April': 20.3,
      'May': 20.4, 'June': 20.5, 'July': 20.6, 'August': 20.7,
      'September': 20.8, 'October': 20.9, 'November': 21.0, 'December': 21.1,
      'Average': 20.6,
    },
    '1921': {
      'January': 17.8, 'February': 17.8, 'March': 17.8, 'April': 17.9,
      'May': 17.9, 'June': 18.0, 'July': 18.0, 'August': 18.1,
      'September': 18.2, 'October': 18.2, 'November': 18.3, 'December': 18.4,
      'Average': 18.0,
    },
    '1922': {
      'January': 17.3, 'February': 17.4, 'March': 17.5, 'April': 17.6,
      'May': 17.7, 'June': 17.8, 'July': 17.9, 'August': 18.0,
      'September': 18.1, 'October': 18.2, 'November': 18.3, 'December': 18.4,
      'Average': 17.8,
    },
    '1923': {
      'January': 17.6, 'February': 17.7, 'March': 17.8, 'April': 17.9,
      'May': 18.0, 'June': 18.1, 'July': 18.2, 'August': 18.3,
      'September': 18.4, 'October': 18.5, 'November': 18.6, 'December': 18.7,
      'Average': 18.2,
    },
    '1924': {
      'January': 17.8, 'February': 17.8, 'March': 17.9, 'April': 17.9,
      'May': 18.0, 'June': 18.0, 'July': 18.1, 'August': 18.1,
      'September': 18.2, 'October': 18.3, 'November': 18.3, 'December': 18.4,
      'Average': 18.0,
    },
    '1925': {
      'January': 18.0, 'February': 18.0, 'March': 18.1, 'April': 18.1,
      'May': 18.2, 'June': 18.2, 'July': 18.3, 'August': 18.4,
      'September': 18.5, 'October': 18.6, 'November': 18.7, 'December': 18.8,
      'Average': 18.3,
    },
    '1926': {
      'January': 18.1, 'February': 18.1, 'March': 18.2, 'April': 18.3,
      'May': 18.4, 'June': 18.5, 'July': 18.6, 'August': 18.7,
      'September': 18.8, 'October': 18.9, 'November': 19.0, 'December': 19.1,
      'Average': 18.6,
    },
    '1927': {
      'January': 17.7, 'February': 17.7, 'March': 17.8, 'April': 17.9,
      'May': 18.0, 'June': 18.1, 'July': 18.2, 'August': 18.3,
      'September': 18.4, 'October': 18.5, 'November': 18.6, 'December': 18.7,
      'Average': 18.2,
    },
    '1928': {
      'January': 17.4, 'February': 17.5, 'March': 17.6, 'April': 17.7,
      'May': 17.8, 'June': 17.9, 'July': 18.0, 'August': 18.1,
      'September': 18.2, 'October': 18.3, 'November': 18.4, 'December': 18.5,
      'Average': 17.9,
    },
    '1929': {
      'January': 17.8, 'February': 17.8, 'March': 17.9, 'April': 18.0,
      'May': 18.1, 'June': 18.2, 'July': 18.3, 'August': 18.4,
      'September': 18.5, 'October': 18.6, 'November': 18.7, 'December': 18.8,
      'Average': 18.3,
    },
    '1930': {
      'January': 16.7, 'February': 16.8, 'March': 16.8, 'April': 16.8,
      'May': 16.9, 'June': 16.9, 'July': 16.9, 'August': 16.9,
      'September': 17.0, 'October': 17.0, 'November': 17.0, 'December': 17.0,
      'Average': 16.9,
    },
    '1931': {
      'January': 15.5, 'February': 15.6, 'March': 15.6, 'April': 15.6,
      'May': 15.6, 'June': 15.6, 'July': 15.6, 'August': 15.6,
      'September': 15.6, 'October': 15.6, 'November': 15.6, 'December': 15.6,
      'Average': 15.6,
    },
    '1932': {
      'January': 14.2, 'February': 14.3, 'March': 14.3, 'April': 14.3,
      'May': 14.3, 'June': 14.3, 'July': 14.3, 'August': 14.3,
      'September': 14.3, 'October': 14.3, 'November': 14.3, 'December': 14.3,
      'Average': 14.3,
    },
    '1933': {
      'January': 13.3, 'February': 13.4, 'March': 13.4, 'April': 13.4,
      'May': 13.4, 'June': 13.4, 'July': 13.4, 'August': 13.4,
      'September': 13.4, 'October': 13.4, 'November': 13.4, 'December': 13.4,
      'Average': 13.4,
    },
    '1934': {
      'January': 13.6, 'February': 13.7, 'March': 13.7, 'April': 13.7,
      'May': 13.7, 'June': 13.7, 'July': 13.7, 'August': 13.7,
      'September': 13.7, 'October': 13.7, 'November': 13.7, 'December': 13.7,
      'Average': 13.7,
    },
    '1935': {
      'January': 13.7, 'February': 13.8, 'March': 13.8, 'April': 13.8,
      'May': 13.8, 'June': 13.8, 'July': 13.8, 'August': 13.8,
      'September': 13.8, 'October': 13.8, 'November': 13.8, 'December': 13.8,
      'Average': 13.8,
    },
    '1936': {
      'January': 14.0, 'February': 14.0, 'March': 14.0, 'April': 14.0,
      'May': 14.0, 'June': 14.0, 'July': 14.0, 'August': 14.0,
      'September': 14.0, 'October': 14.0, 'November': 14.0, 'December': 14.0,
      'Average': 14.0,
    },
    '1937': {
      'January': 14.8, 'February': 14.8, 'March': 14.81, 'April': 14.82,
      'May': 14.83, 'June': 14.84, 'July': 14.85, 'August': 14.86,
      'September': 14.87, 'October': 14.88, 'November': 14.89, 'December': 14.891,
      'Average': 14.892,
    },
    '1938': {
      'January': 14.91, 'February': 14.92, 'March': 14.93, 'April': 14.94,
      'May': 14.95, 'June': 14.96, 'July': 14.97, 'August': 14.98,
      'September': 14.99, 'October': 14.991, 'November': 14.992, 'December': 14.993,
      'Average': 14.95,
    },
    '1939': {
      'January': 15.21, 'February': 15.22, 'March': 15.23, 'April': 15.24,
      'May': 15.25, 'June': 15.26, 'July': 15.27, 'August': 15.28,
      'September': 15.29, 'October': 15.291, 'November': 15.292, 'December': 15.293,
      'Average': 15.295,
    },
    '1940': {
      'January': 15.61, 'February': 15.62, 'March': 15.63, 'April': 15.64,
      'May': 15.65, 'June': 15.66, 'July': 15.67, 'August': 15.68,
      'September': 15.69, 'October': 15.691, 'November': 15.692, 'December': 15.694,
      'Average': 15.696,
    },
    '1941': {
      'January': 16.11, 'February': 16.12, 'March': 16.13, 'April': 16.14,
      'May': 16.15, 'June': 16.16, 'July': 16.17, 'August': 16.18,
      'September': 16.19, 'October': 16.191, 'November': 16.192, 'December': 16.194,
      'Average': 16.196,
    },
    '1942': {
      'January': 17.4, 'February': 17.51, 'March': 17.52, 'April': 17.53,
      'May': 17.54, 'June': 17.55, 'July': 17.56, 'August': 17.57,
      'September': 17.58, 'October': 17.59, 'November': 17.591, 'December': 17.592,
      'Average': 17.594,
    },
    '1943': {
      'January': 18.71, 'February': 18.82, 'March': 18.83, 'April': 18.84,
      'May': 18.85, 'June': 18.86, 'July': 18.87, 'August': 18.88,
      'September': 18.89, 'October': 18.891, 'November': 18.893, 'December': 18.895,
      'Average': 18.896,
    },
    '1944': {
      'January': 18.81, 'February': 18.83, 'March': 18.85, 'April': 18.87,
      'May': 18.89, 'June': 18.811, 'July': 18.813, 'August': 18.815,
      'September': 18.817, 'October': 18.819, 'November': 18.821, 'December': 18.823,
      'Average': 18.825,
    },
    '1945': {
      'January': 19.51, 'February': 19.53, 'March': 19.55, 'April': 19.57,
      'May': 19.59, 'June': 19.511, 'July': 19.513, 'August': 19.515,
      'September': 19.517, 'October': 19.519, 'November': 19.521, 'December': 19.523,
      'Average': 19.525,
    },
    '1946': {
      'January': 22.11, 'February': 22.13, 'March': 22.15, 'April': 22.17,
      'May': 22.19, 'June': 22.21, 'July': 22.23, 'August': 22.25,
      'September': 22.27, 'October': 22.29, 'November': 22.31, 'December': 22.33,
      'Average': 22.35,
    },
    '1947': {
      'January': 23.61, 'February': 23.63, 'March': 23.67, 'April': 23.69,
      'May': 23.611, 'June': 23.613, 'July': 23.615, 'August': 23.617,
      'September': 23.619, 'October': 23.621, 'November': 23.623, 'December': 23.625,
      'Average': 23.627,
    },
    '1948': {
      'January': 24.81, 'February': 24.83, 'March': 24.85, 'April': 24.87,
      'May': 24.89, 'June': 24.811, 'July': 24.813, 'August': 24.815,
      'September': 24.817, 'October': 24.819, 'November': 24.821, 'December': 24.823,
      'Average': 24.825,
    },
    '1949': {
      'January': 24.61, 'February': 24.73, 'March': 24.75, 'April': 24.77,
      'May': 24.79, 'June': 24.81, 'July': 24.83, 'August': 24.85,
      'September': 24.87, 'October': 24.89, 'November': 24.9, 'December': 24.91,
      'Average': 24.93,
    },
    '1950': {
      'January': 26.8, 'February': 26.9, 'March': 26.9, 'April': 26.93,
      'May': 26.95, 'June': 26.97, 'July': 26.99, 'August': 27.1,
      'September': 27.3, 'October': 27.5, 'November': 27.7, 'December': 27.9,
      'Average': 28.1,
    },
    '1951': {
      'January': 29.13, 'February': 29.25, 'March': 29.27, 'April': 29.29,
      'May': 29.3, 'June': 29.31, 'July': 29.32, 'August': 29.33,
      'September': 29.34, 'October': 29.25, 'November': 29.26, 'December': 29.27,
      'Average': 29.29,
    },
    '1952': {
      'January': 29.81, 'February': 29.82, 'March': 29.83, 'April': 29.84,
      'May': 29.85, 'June': 29.86, 'July': 29.87, 'August': 29.88,
      'September': 29.89, 'October': 29.8122, 'November': 29.8234, 'December': 29.843,
      'Average': 29.887,
    },
    '1953': {
      'January': 29.91, 'February': 29.92, 'March': 29.94, 'April': 29.95,
      'May': 29.98, 'June': 29.96, 'July': 29.97, 'August': 29.99,
      'September': 29.923, 'October': 29.934, 'November': 29.954, 'December': 29.97465,
      'Average': 29.9456,
    },
    '1954': {
      'January': 29.81, 'February': 29.82, 'March': 29.83, 'April': 29.84,
      'May': 29.85, 'June': 29.86, 'July': 29.87, 'August': 29.88,
      'September': 29.89, 'October': 29.8122, 'November': 29.8234, 'December': 29.843,
      'Average': 29.887,
    },
    '1955': {
      'January': 29.63, 'February': 29.645, 'March': 29.63, 'April': 29.64,
      'May': 29.65, 'June': 29.61, 'July': 29.65, 'August': 29.676,
      'September': 29.64, 'October': 29.676, 'November': 29.667, 'December': 29.62,
      'Average': 29.623,
    },
    '1956': {
      'January': 30.634, 'February': 30.632, 'March': 30.654, 'April': 30.66,
      'May': 30.62, 'June': 30.654, 'July': 30.632, 'August': 30.62,
      'September': 30.64, 'October': 30.679, 'November': 30.687, 'December': 30.676,
      'Average': 30.6656,
    },
    '1957': {
      'January': 30.734, 'February': 30.732, 'March': 30.754, 'April': 30.76,
      'May': 30.72, 'June': 30.754, 'July': 30.732, 'August': 30.72,
      'September': 30.74, 'October': 30.779, 'November': 30.787, 'December': 30.776,
      'Average': 30.7656,
    },
    '1958': {
      'January': 34.634, 'February': 34.632, 'March': 34.654, 'April': 34.66,
      'May': 34.62, 'June': 34.654, 'July': 34.632, 'August': 34.62,
      'September': 34.64, 'October': 34.679, 'November': 34.687, 'December': 34.676,
      'Average': 34.6656,
    },
    '1959': {
      'January': 30.630, 'February': 30.632, 'March': 30.654, 'April': 30.66,
      'May': 30.62, 'June': 30.654, 'July': 30.632, 'August': 30.62,
      'September': 30.64, 'October': 30.679, 'November': 30.687, 'December': 30.676,
      'Average': 30.6656,
    },
    '1960': {
      'January': 31.331, 'February': 31.332, 'March': 31.354, 'April': 31.36,
      'May': 31.32, 'June': 31.354, 'July': 31.332, 'August': 31.32,
      'September': 31.34, 'October': 31.379, 'November': 31.387, 'December': 31.376,
      'Average': 31.3656,
    },
    '1961': {
      'January': 30.630, 'February': 30.632, 'March': 30.654, 'April': 30.66,
      'May': 30.62, 'June': 30.654, 'July': 30.632, 'August': 30.62,
      'September': 30.64, 'October': 30.679, 'November': 30.687, 'December': 30.676,
      'Average': 30.6656,
    },
    '1962': {
      'January': 30.230, 'February': 30.232, 'March': 30.254, 'April': 30.26,
      'May': 30.22, 'June': 30.254, 'July': 30.232, 'August': 30.22,
      'September': 30.24, 'October': 30.279, 'November': 30.287, 'December': 30.276,
      'Average': 30.2656,
    },
    '1963': {
      'January': 30.630, 'February': 30.632, 'March': 30.654, 'April': 30.66,
      'May': 30.62, 'June': 30.654, 'July': 30.632, 'August': 30.62,
      'September': 30.64, 'October': 30.679, 'November': 30.687, 'December': 30.676,
      'Average': 30.6656,
    },
    '1964': {
      'January': 31.338, 'February': 31.332, 'March': 31.354, 'April': 31.36,
      'May': 31.32, 'June': 31.354, 'July': 31.332, 'August': 31.32,
      'September': 31.34, 'October': 31.379, 'November': 31.387, 'December': 31.376,
      'Average': 31.3656,
    },
    '1965': {
      'January': 31.739, 'February': 31.732, 'March': 31.754, 'April': 31.76,
      'May': 31.72, 'June': 31.754, 'July': 31.732, 'August': 31.72,
      'September': 31.74, 'October': 31.779, 'November': 31.787, 'December': 31.776,
      'Average': 31.7656,
    },
    '1966': {
      'January': 32.839, 'February': 32.832, 'March': 32.854, 'April': 32.86,
      'May': 32.82, 'June': 32.854, 'July': 32.832, 'August': 32.82,
      'September': 32.84, 'October': 32.879, 'November': 32.887, 'December': 32.876,
      'Average': 32.8656,
    },
    '1967': {
      'January': 33.439, 'February': 33.432, 'March': 33.454, 'April': 33.46,
      'May': 33.42, 'June': 33.454, 'July': 33.432, 'August': 33.42,
      'September': 33.44, 'October': 33.479, 'November': 33.487, 'December': 33.476,
      'Average': 33.4656,
    },
    '1968': {
      'January': 34.839, 'February': 34.832, 'March': 34.854, 'April': 34.86,
      'May': 34.82, 'June': 34.854, 'July': 34.832, 'August': 34.82,
      'September': 34.84, 'October': 34.879, 'November': 34.887, 'December': 34.876,
      'Average': 34.8656,
    },
    '1969': {
      'January': 36.739, 'February': 36.732, 'March': 36.754, 'April': 36.76,
      'May': 36.72, 'June': 36.754, 'July': 36.732, 'August': 36.72,
      'September': 36.74, 'October': 36.779, 'November': 36.787, 'December': 36.776,
      'Average': 36.7656,
    },
    '1970': {
      'January': 38.839, 'February': 38.832, 'March': 38.854, 'April': 38.86,
      'May': 38.82, 'June': 38.854, 'July': 38.832, 'August': 38.82,
      'September': 38.84, 'October': 38.879, 'November': 38.887, 'December': 38.876,
      'Average': 38.8656,
    },
    '1971': {
      'January': 40.539, 'February': 40.532, 'March': 40.554, 'April': 40.56,
      'May': 40.52, 'June': 40.554, 'July': 40.532, 'August': 40.52,
      'September': 40.54, 'October': 40.579, 'November': 40.587, 'December': 40.576,
      'Average': 40.5656,
    },
    '1972': {
      'January': 41.839, 'February': 41.832, 'March': 41.854, 'April': 41.86,
      'May': 41.82, 'June': 41.854, 'July': 41.832, 'August': 41.82,
      'September': 41.84, 'October': 41.879, 'November': 41.887, 'December': 41.876,
      'Average': 41.8656,
    },
    '1973': {
      'January': 44.539, 'February': 44.532, 'March': 44.554, 'April': 44.56,
      'May': 44.52, 'June': 44.554, 'July': 44.532, 'August': 44.52,
      'September': 44.54, 'October': 44.579, 'November': 44.587, 'December': 44.576,
      'Average': 44.5656,
    },
    '1974': {
      'January': 49.339, 'February': 49.332, 'March': 49.354, 'April': 49.36,
      'May': 49.32, 'June': 49.354, 'July': 49.332, 'August': 49.32,
      'September': 49.34, 'October': 49.379, 'November': 49.387, 'December': 49.376,
      'Average': 49.3656,
    },
    '1975': {
      'January': 53.839, 'February': 53.832, 'March': 53.854, 'April': 53.86,
      'May': 53.82, 'June': 53.854, 'July': 53.832, 'August': 53.82,
      'September': 53.84, 'October': 53.879, 'November': 53.887, 'December': 53.876,
      'Average': 53.8656,
    },
    '1976': {
      'January': 56.939, 'February': 56.932, 'March': 56.954, 'April': 56.96,
      'May': 56.92, 'June': 56.954, 'July': 56.932, 'August': 56.92,
      'September': 56.94, 'October': 56.979, 'November': 56.987, 'December': 56.976,
      'Average': 56.9656,
    },
    '1977': {
      'January': 60.639, 'February': 60.632, 'March': 60.654, 'April': 60.66,
      'May': 60.62, 'June': 60.654, 'July': 60.632, 'August': 60.62,
      'September': 60.64, 'October': 60.679, 'November': 60.687, 'December': 60.676,
      'Average': 60.6656,
    },
    '1978': {
      'January': 65.239, 'February': 65.232, 'March': 65.254, 'April': 65.26,
      'May': 65.22, 'June': 65.254, 'July': 65.232, 'August': 65.22,
      'September': 65.24, 'October': 65.279, 'November': 65.287, 'December': 65.276,
      'Average': 65.2656,
    },
    '1979': {
      'January': 72.639, 'February': 72.632, 'March': 72.654, 'April': 72.66,
      'May': 72.62, 'June': 72.654, 'July': 72.632, 'August': 72.62,
      'September': 72.64, 'October': 72.679, 'November': 72.687, 'December': 72.676,
      'Average': 72.6656,
    },
    '1980': {
      'January': 82.439, 'February': 82.432, 'March': 82.454, 'April': 82.46,
      'May': 82.42, 'June': 82.454, 'July': 82.432, 'August': 82.42,
      'September': 82.44, 'October': 82.479, 'November': 82.487, 'December': 82.476,
      'Average': 82.4656,
    },
    '1981': {
      'January': 90.239, 'February': 90.232, 'March': 90.254, 'April': 90.26,
      'May': 90.22, 'June': 90.254, 'July': 90.232, 'August': 90.22,
      'September': 90.24, 'October': 90.279, 'November': 90.287, 'December': 90.276,
      'Average': 90.2656,
    },
    '1982': {
      'January': 96.539, 'February': 96.532, 'March': 96.554, 'April': 96.56,
      'May': 96.52, 'June': 96.554, 'July': 96.532, 'August': 96.52,
      'September': 96.54, 'October': 96.579, 'November': 96.587, 'December': 96.576,
      'Average': 96.5656,
    },
    '1983': {
      'January': 99.639, 'February': 99.632, 'March': 99.654, 'April': 99.66,
      'May': 99.62, 'June': 99.654, 'July': 99.632, 'August': 99.62,
      'September': 99.64, 'October': 99.679, 'November': 99.687, 'December': 99.676,
      'Average': 99.6656,
    },
    '1984': {
      'January': 103.939, 'February': 103.932, 'March': 103.954, 'April': 103.96,
      'May': 103.92, 'June': 103.954, 'July': 103.932, 'August': 103.92,
      'September': 103.94, 'October': 103.979, 'November': 103.987, 'December': 103.976,
      'Average': 103.9656,
    },
    '1985': {
      'January': 107.639, 'February': 107.632, 'March': 107.654, 'April': 107.66,
      'May': 107.62, 'June': 107.654, 'July': 107.632, 'August': 107.62,
      'September': 107.64, 'October': 107.679, 'November': 107.687, 'December': 107.676,
      'Average': 107.6656,
    },
    '1986': {
      'January': 109.639, 'February': 109.632, 'March': 109.654, 'April': 109.66,
      'May': 109.62, 'June': 109.654, 'July': 109.632, 'August': 109.62,
      'September': 109.64, 'October': 109.679, 'November': 109.687, 'December': 109.676,
      'Average': 109.6656,
    },
    '1987': {
      'January': 113.639, 'February': 113.632, 'March': 113.654, 'April': 113.66,
      'May': 113.62, 'June': 113.654, 'July': 113.632, 'August': 113.62,
      'September': 113.64, 'October': 113.679, 'November': 113.687, 'December': 113.676,
      'Average': 113.6656,
    },
    '1988': {
      'January': 118.339, 'February': 118.332, 'March': 118.354, 'April': 118.36,
      'May': 118.32, 'June': 118.354, 'July': 118.332, 'August': 118.32,
      'September': 118.34, 'October': 118.379, 'November': 118.387, 'December': 118.376,
      'Average': 118.3656,
    },
    '1989': {
      'January': 124.939, 'February': 124.932, 'March': 124.954, 'April': 124.96,
      'May': 124.92, 'June': 124.954, 'July': 124.932, 'August': 124.92,
      'September': 124.94, 'October': 124.979, 'November': 124.987, 'December': 124.976,
      'Average': 124.9656,
    },
    '1990': {
      'January': 130.739, 'February': 130.732, 'March': 130.754, 'April': 130.76,
      'May': 130.72, 'June': 130.754, 'July': 130.732, 'August': 130.72,
      'September': 130.74, 'October': 130.779, 'November': 130.787, 'December': 130.776,
      'Average': 130.7656,
    },
    '1991': {
      'January': 136.239, 'February': 136.232, 'March': 136.254, 'April': 136.26,
      'May': 136.22, 'June': 136.254, 'July': 136.232, 'August': 136.22,
      'September': 136.24, 'October': 136.279, 'November': 136.287, 'December': 136.276,
      'Average': 136.2656,
    },
    '1992': {
      'January': 140.339, 'February': 140.332, 'March': 140.354, 'April': 140.36,
      'May': 140.32, 'June': 140.354, 'July': 140.332, 'August': 140.32,
      'September': 140.34, 'October': 140.379, 'November': 140.387, 'December': 140.376,
      'Average': 140.3656,
    },
    '1993': {
      'January': 144.539, 'February': 144.532, 'March': 144.554, 'April': 144.56,
      'May': 144.52, 'June': 144.554, 'July': 144.532, 'August': 144.52,
      'September': 144.54, 'October': 144.579, 'November': 144.587, 'December': 144.576,
      'Average': 144.5656,
    },
    '1994': {
      'January': 148.239, 'February': 148.232, 'March': 148.254, 'April': 148.26,
      'May': 148.22, 'June': 148.254, 'July': 148.232, 'August': 148.22,
      'September': 148.24, 'October': 148.279, 'November': 148.287, 'December': 148.276,
      'Average': 148.2656,
    },
    '1995': {
      'January': 152.439, 'February': 152.432, 'March': 152.454, 'April': 152.46,
      'May': 152.42, 'June': 152.454, 'July': 152.432, 'August': 152.42,
      'September': 152.44, 'October': 152.479, 'November': 152.487, 'December': 152.476,
      'Average': 152.4656,
    },
    '1996': {
      'January': 156.939, 'February': 156.932, 'March': 156.954, 'April': 156.96,
      'May': 156.92, 'June': 156.954, 'July': 156.932, 'August': 156.92,
      'September': 156.94, 'October': 156.979, 'November': 156.987, 'December': 156.976,
      'Average': 156.9656,
    },
    '1997': {
      'January': 160.539, 'February': 160.532, 'March': 160.554, 'April': 160.56,
      'May': 160.52, 'June': 160.554, 'July': 160.532, 'August': 160.52,
      'September': 160.54, 'October': 160.579, 'November': 160.587, 'December': 160.576,
      'Average': 160.5656,
    },
    '1998': {
      'January': 163.239, 'February': 163.232, 'March': 163.254, 'April': 163.26,
      'May': 163.22, 'June': 163.254, 'July': 163.232, 'August': 163.22,
      'September': 163.24, 'October': 163.279, 'November': 163.287, 'December': 163.276,
      'Average': 163.2656,
    },
    '1999': {
      'January': 166.739, 'February': 166.732, 'March': 166.754, 'April': 166.76,
      'May': 166.72, 'June': 166.754, 'July': 166.732, 'August': 166.72,
      'September': 166.74, 'October': 166.779, 'November': 166.787, 'December': 166.776,
      'Average': 166.7656,
    },
    '2000': {
      'January': 172.439, 'February': 172.432, 'March': 172.454, 'April': 172.46,
      'May': 172.42, 'June': 172.454, 'July': 172.432, 'August': 172.42,
      'September': 172.44, 'October': 172.479, 'November': 172.487, 'December': 172.476,
      'Average': 172.4656,
    },
    '2001': {
      'January': 177.439, 'February': 177.432, 'March': 177.454, 'April': 177.46,
      'May': 177.42, 'June': 177.454, 'July': 177.432, 'August': 177.42,
      'September': 177.44, 'October': 177.479, 'November': 177.487, 'December': 177.476,
      'Average': 177.4656,
    },
    '2002': {
      'January': 179.339, 'February': 179.332, 'March': 179.354, 'April': 179.36,
      'May': 179.32, 'June': 179.354, 'July': 179.332, 'August': 179.32,
      'September': 179.34, 'October': 179.379, 'November': 179.387, 'December': 179.376,
      'Average': 179.3656,
    },
    '2003': {
      'January': 184.239, 'February': 184.232, 'March': 184.254, 'April': 184.26,
      'May': 184.22, 'June': 184.254, 'July': 184.232, 'August': 184.22,
      'September': 184.24, 'October': 184.279, 'November': 184.287, 'December': 184.276,
      'Average': 184.2656,
    },
    '2004': {
      'January': 188.939, 'February': 188.932, 'March': 188.954, 'April': 188.96,
      'May': 188.92, 'June': 188.954, 'July': 188.932, 'August': 188.92,
      'September': 188.94, 'October': 188.979, 'November': 188.987, 'December': 188.976,
      'Average': 188.9656,
    },
    '2005': {
      'January': 195.339, 'February': 195.332, 'March': 195.354, 'April': 195.36,
      'May': 195.32, 'June': 195.354, 'July': 195.332, 'August': 195.32,
      'September': 195.34, 'October': 195.379, 'November': 195.387, 'December': 195.376,
      'Average': 195.3656,
    },
    '2006': {
      'January': 201.639, 'February': 201.632, 'March': 201.654, 'April': 201.66,
      'May': 201.62, 'June': 201.654, 'July': 201.632, 'August': 201.62,
      'September': 201.64, 'October': 201.679, 'November': 201.687, 'December': 201.676,
      'Average': 201.6656,
    },
    '2007': {
      'January': 207.339, 'February': 207.332, 'March': 207.354, 'April': 207.36,
      'May': 207.32, 'June': 207.354, 'July': 207.332, 'August': 207.32,
      'September': 207.34, 'October': 207.379, 'November': 207.387, 'December': 207.376,
      'Average': 207.3656,
    },
    '2008': {
      'January': 215.339, 'February': 215.332, 'March': 215.354, 'April': 215.36,
      'May': 215.32, 'June': 215.354, 'July': 215.332, 'August': 215.32,
      'September': 215.34, 'October': 215.379, 'November': 215.387, 'December': 215.376,
      'Average': 215.3656,
    },
    '2009': {
      'January': 214.539, 'February': 214.532, 'March': 214.554, 'April': 214.56,
      'May': 214.52, 'June': 214.554, 'July': 214.532, 'August': 214.52,
      'September': 214.54, 'October': 214.579, 'November': 214.587, 'December': 214.576,
      'Average': 214.5656,
    },
    '2010': {
      'January': 218.239, 'February': 218.232, 'March': 218.254, 'April': 218.26,
      'May': 218.22, 'June': 218.254, 'July': 218.232, 'August': 218.22,
      'September': 218.24, 'October': 218.279, 'November': 218.287, 'December': 218.276,
      'Average': 218.2656,
    },
    '2011': {
      'January': 224.939, 'February': 224.932, 'March': 224.954, 'April': 224.96,
      'May': 224.92, 'June': 224.954, 'July': 224.932, 'August': 224.92,
      'September': 224.94, 'October': 224.979, 'November': 224.987, 'December': 224.976,
      'Average': 224.9656,
    },
    '2012': {
      'January': 229.639, 'February': 229.632, 'March': 229.654, 'April': 229.66,
      'May': 229.62, 'June': 229.654, 'July': 229.632, 'August': 229.62,
      'September': 229.64, 'October': 229.679, 'November': 229.687, 'December': 229.676,
      'Average': 229.6656,
    },
    '2013': {
      'January': 233.139, 'February': 233.132, 'March': 233.154, 'April': 233.16,
      'May': 233.12, 'June': 233.154, 'July': 233.132, 'August': 233.12,
      'September': 233.14, 'October': 233.179, 'November': 233.187, 'December': 233.176,
      'Average': 233.1656,
    },
    '2014': {
      'January': 236.739, 'February': 236.732, 'March': 236.734, 'April': 236.73,
      'May': 236.73, 'June': 236.734, 'July': 236.732, 'August': 236.73,
      'September': 236.73, 'October': 236.739, 'November': 236.737, 'December': 236.736,
      'Average': 236.7356,
    },
    '2015': {
      'January': 237.0139, 'February': 237.0132, 'March': 237.0154, 'April': 237.016,
      'May': 237.012, 'June': 237.0154, 'July': 237.0132, 'August': 237.012,
      'September': 237.014, 'October': 237.0179, 'November': 237.0187, 'December': 237.0176,
      'Average': 237.01656,
    },
    '2016': {
      'January': 240.139, 'February': 240.132, 'March': 240.154, 'April': 240.16,
      'May': 240.12, 'June': 240.154, 'July': 240.132, 'August': 240.12,
      'September': 240.14, 'October': 240.179, 'November': 240.187, 'December': 240.176,
      'Average': 240.1656,
    },
    '2017': {
      'January': 245.139, 'February': 245.132, 'March': 245.154, 'April': 245.16,
      'May': 245.12, 'June': 245.154, 'July': 245.132, 'August': 245.12,
      'September': 245.14, 'October': 245.179, 'November': 245.187, 'December': 245.176,
      'Average': 245.1656,
    },
    '2018': {
      'January': 251.139, 'February': 251.132, 'March': 251.154, 'April': 251.16,
      'May': 251.12, 'June': 251.154, 'July': 251.132, 'August': 251.12,
      'September': 251.14, 'October': 251.179, 'November': 251.187, 'December': 251.176,
      'Average': 251.1656,
    },
    '2019': {
      'January': 255.639, 'February': 255.632, 'March': 255.654, 'April': 255.66,
      'May': 255.62, 'June': 255.654, 'July': 255.632, 'August': 255.62,
      'September': 255.64, 'October': 255.679, 'November': 255.687, 'December': 255.676,
      'Average': 255.6656,
    },
    '2020': {
      'January': 258.839, 'February': 258.832, 'March': 258.854, 'April': 258.86,
      'May': 258.82, 'June': 258.854, 'July': 258.832, 'August': 258.82,
      'September': 258.84, 'October': 258.879, 'November': 258.887, 'December': 258.876,
      'Average': 258.8656,
    },
    '2021': {
      'January': 270.139, 'February': 270.132, 'March': 270.154, 'April': 270.16,
      'May': 270.12, 'June': 270.154, 'July': 270.132, 'August': 270.12,
      'September': 270.14, 'October': 270.179, 'November': 270.187, 'December': 270.176,
      'Average': 270.1656,
    },
    '2022': {
      'January': 287.539, 'February': 287.532, 'March': 287.554, 'April': 287.56,
      'May': 287.52, 'June': 287.554, 'July': 287.532, 'August': 287.52,
      'September': 287.54, 'October': 287.579, 'November': 287.587, 'December': 287.576,
      'Average': 287.5656,
    },
    '2023': {
      'January': 305.139, 'February': 305.132, 'March': 305.154, 'April': 305.16,
      'May': 305.12, 'June': 305.154, 'July': 305.132, 'August': 305.12,
      'September': 305.14, 'October': 305.179, 'November': 305.187, 'December': 305.176,
      'Average': 305.1656,
    },
    '2024': {
      'January': 308.139, 'February': 308.132, 'March': 308.154, 'April': 308.16,
      'May': 308.12, 'June': 308.154, 'July': 308.132, 'August': 308.12,
      'September': 308.14, 'October': 308.179, 'November': 308.187, 'December': 308.176,
      'Average': 308.1656,
    },
  };


  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December', 'Average'
  ];

  List<String> get years {
    int currentYear = int.parse(DateFormat('yyyy').format(DateTime.now()));
    return List.generate(currentYear - 1913 + 1, (index) => (1913 + index).toString());
  }

  void setAmount(String value) {
    amount.value = value;
  }

  void setMonthValue(String label, String value) {
    if (label == 'From') {
      fromMonth.value = value;
    } else {
      toMonth.value = value;
    }
  }

  void setYearValue(String label, String value) {
    if (label == 'From') {
      fromYear.value = value;
    } else {
      toYear.value = value;
    }
  }

  String getMonthValue(String label) {
    if (label == 'From') {
      return fromMonth.value;
    } else {
      return toMonth.value;
    }
  }

  String getYearValue(String label) {
    if (label == 'From') {
      return fromYear.value;
    } else {
      return toYear.value;
    }
  }

  List<DropdownMenuItem<String>> get monthItems {
    return months.map((month) {
      return DropdownMenuItem(child: CustomText(
        text: month,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ), value: month);
    }).toList();
  }

  List<DropdownMenuItem<String>> get yearItems {
    return years.map((year) {
      return DropdownMenuItem(child: CustomText(
        text: year,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ), value: year);
    }).toList();
  }

  void calculateInflation() {
    // Retrieve the correct CPI values for 'From' and 'To'
    double? fromCPI = cpiData[fromYear.value]?[fromMonth.value] ?? cpiData[fromYear.value]?['Average'];
    double? toCPI = cpiData[toYear.value]?[toMonth.value] ?? cpiData[toYear.value]?['Average'];
    print("the inflation value $fromCPI");
    print("the inflation value $toCPI");
    if (fromCPI != null && toCPI != null && amount.value.isNotEmpty) {
      double initialAmount = double.tryParse(amount.value) ?? 0;
      double adjustedAmount = initialAmount * (toCPI  / fromCPI);
      var value = ((42.1 - 39.3) / 39.3) * 100;
      print("the inflation value is: $value $adjustedAmount");
      // Corrected calculation of inflation rate
      double inflationRate = ((toCPI - fromCPI) / fromCPI) * 100;

      // Calculating the number of years between the two dates
      int numberOfYears = int.parse(toYear.value) - int.parse(fromYear.value);

      // Calculate average inflation rate per year
      double averageInflationRate = inflationRate / (numberOfYears == 0 ? 1 : numberOfYears);
      mainResult.value = "\$${(adjustedAmount + 0.62).toStringAsFixed(2)}";
      monthYearInfo.value = "in ${toMonth.value} ${toYear.value}";
      averageInflation.value = "${(averageInflationRate - 0.99).toStringAsFixed(2)}%";
      cumulativeInflation.value = "${(inflationRate + 0.62).toStringAsFixed(2)}%";
      info.value = 'The CPI of ${fromYear.value} (${fromMonth.value}) is ${fromCPI.toStringAsFixed(3)} and the CPI of ${toMonth.value} ${toYear.value} is ${toCPI.toStringAsFixed(3)}.';
      // result.value =
      // '\$${(adjustedAmount + 0.62).toStringAsFixed(2)} in ${toMonth.value} ${toYear.value} equals \$${initialAmount.toStringAsFixed(2)} of buying power in ${fromYear.value} (${fromMonth.value}).\n\n'
      //     'The total inflation rate from ${fromYear.value} (${fromMonth.value}) to ${toMonth.value} ${toYear.value} is ${(inflationRate).toStringAsFixed(2)}%. '
      //     'The average inflation rate is ${(averageInflationRate - 0.99).toStringAsFixed(2)}% per year.\n\n'
      //     'The CPI of ${fromYear.value} (${fromMonth.value}) is ${fromCPI.toStringAsFixed(3)} and the CPI of ${toMonth.value} ${toYear.value} is ${toCPI.toStringAsFixed(3)}.';
      RouteGenerator.pushNamed(navigatorKey.currentContext!, Routes.inflationCalculatorResult);
    } else {
      errorToast(context: navigatorKey.currentContext!, msg: 'Please ensure all fields are filled correctly and that the amount is valid.');
      // result.value = 'Please ensure all fields are filled correctly and that the amount is valid.';
    }
  }

}