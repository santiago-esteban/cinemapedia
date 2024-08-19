//* Importa la librería para el formateo internacional de fechas y números.
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

//* Clase que maneja el formateo de números y fechas.
class Formats {
  //* Formatea un número de tipo double en un formato compacto, con una cantidad opcional de decimales.
  static String number(double number, [int decimals = 0]) {
    return NumberFormat.compactCurrency(
      decimalDigits: decimals,
      symbol: '',
      locale: 'en',
    ).format(number);
  }

  //* Formatea una fecha corta en español.
  static String shortDate(DateTime date) {
    final format = DateFormat.yMMMEd('es');
    return format.format(date);
  }

  //* Formatea una fecha en un patrón específico en español y capitaliza el nombre del día.
  static String formatDate(DateTime dateTime) {
    initializeDateFormatting('es_ES', null);
    final formatterDate = DateFormat('EEEE d', 'es_ES').format(dateTime);
    final formatterDateCapitalized = formatterDate[0].toUpperCase() + formatterDate.substring(1);
    return formatterDateCapitalized;
  }
}
