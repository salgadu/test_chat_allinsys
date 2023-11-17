import 'package:crypto/crypto.dart';
import 'dart:convert';

extension StringHashing on String {
  String calculateHash() {
    // Converte a string em uma lista de caracteres (tokens)
    List<String> tokens = split('');

    // Ordena os tokens
    tokens.sort();

    // Junta os tokens de volta em uma string
    String sortedInput = tokens.join();

    // Calcula o hash da string ordenada
    var bytes = utf8.encode(sortedInput);
    var digest = sha1.convert(bytes);

    return digest.toString();
  }
}
