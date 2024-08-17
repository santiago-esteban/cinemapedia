// Importa la librería para formatear números y fechas de manera internacional.
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

//* Clase que maneja el formateo de números en un formato más legible para los humanos.
class Formats {
  //* Formatea un número de tipo double en un formato compacto, con una cantidad opcional de decimales.
  static String number(double number, [int decimals = 0]) {
    return NumberFormat.compactCurrency(
      decimalDigits: decimals,
      symbol: '', // No se incluye un símbolo de moneda.
      locale: 'en', // Se usa la configuración regional en inglés.
    ).format(number);
  }

  static String shortDate(DateTime date) {
    final format = DateFormat.yMMMEd('es');
    return format.format(date);
  }

  static String formatDate(DateTime dateTime) {
    initializeDateFormatting('es_ES', null); // Inicializa los datos de localización para 'es_ES'
    final formatterDate = DateFormat('EEEE d', 'es_ES').format(dateTime); // Crea un formateador con el patrón deseado
    final formatterDateCapitalized = formatterDate[0].toUpperCase() + formatterDate.substring(1); // Capitaliza la primera letra del nombre del día
    return formatterDateCapitalized; // Formatea la fecha
  }
}
