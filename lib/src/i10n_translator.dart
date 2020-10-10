library i10n_translator;

///
/// Copyright (C) 2019 Andrious Solutions
///
/// This program is free software; you can redistribute it and/or
/// modify it under the terms of the GNU General Public License
/// as published by the Free Software Foundation; either version 3
/// of the License, or any later version.
///
/// You may obtain a copy of the License at
///
///  http://www.apache.org/licenses/LICENSE-2.0
///
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
///          Created  06 Oct 2019
///
///
import 'dart:io' show File, FileMode;

import 'package:csv/csv.dart' show CsvToListConverter;

/// Loads translations from a file into memory
class I10nTranslator {
  void generate([String filePath, String targetPath]) {
    if (filePath == null || filePath.trim().isEmpty) filePath = "i10n.csv";

    if (targetPath == null || targetPath.trim().isEmpty)
      targetPath = "i10n_words.dart";

    File file = File(filePath);

    if (!file.existsSync()) {
      logError("File $filePath does not exist");
      return;
    }

    List<String> lines = file.readAsLinesSync();

    // Remove any blank lines.
    lines.removeWhere((line) => line.isEmpty);

    if (lines.isEmpty) {
      logError("File is empty:\n $filePath");
      return;
    }

    // Get the language codes.
    List<String> languages = _getLineOfWords(lines.first);

    Iterable<String> invalid = languages.where((code) {
      return code.trim().length != 2;
    });

    if (invalid.isNotEmpty) {
      logError("Not valid language code(s):\n $invalid");
      return;
    }

    // Assume the first code is the 'default' language. The rest are the translations.
    List<String> supportedLanguages = languages.sublist(1, languages.length);

    List<Map<String, String>> maps = [];

    // Add a Map object the List with every Language.
    supportedLanguages.forEach((_) => maps.add(Map()));

    List<String> lineOfWords;
    String key;
    List<String> words;
    String translations;
    bool noWord;

    for (var linesIndex = 1; linesIndex < lines.length; linesIndex++) {
      lineOfWords = _getLineOfWords(lines[linesIndex]);

      // Assume the first word is the key.
      key = lineOfWords.first;

      if (RESERVED_WORDS.contains(key)) {
        logError(
            "$key is a reserved keyword and cannot be used as key (line ${linesIndex + 1})");
        continue;
      }

      // Assume the rest of the words are the translations.
      words = lineOfWords.sublist(1, lineOfWords.length);

      if (words.length != supportedLanguages.length) {
        logError(
            "The line number ${linesIndex + 1} seems malformatted (${words.length} words for ${supportedLanguages.length} columns)");
      }

      for (var wordIndex = 0; wordIndex < words.length; wordIndex++) {
        noWord = words[wordIndex].isEmpty;
        maps[wordIndex][key] = noWord ? key : words[wordIndex];
        if (noWord)
          logError(
              "The line number ${linesIndex + 1} had no word and so key was used: $key");
      }
    }

    translations = _makeTranslations(maps, supportedLanguages);

    _writeInFile(translations, targetPath);
  }

  List<String> _getLineOfWords(String line) => CsvToListConverter()
      .convert(line)
      .first
      .map((element) => element.toString())
      .toList();

  String _makeTranslations(
      List<Map<String, String>> maps, List<String> supportedLanguages) {
    final Map<String, Map<String, String>> allValuesMap = Map();
    final List<String> mapsNames = [];

    String result = "";
    String lang;
    Map<String, String> map;
    String mapName;

    for (var index = 0; index < maps.length; index++) {
      lang = supportedLanguages[index];

      map = maps[index];

      mapName = "${lang}Values";

      mapsNames.add(mapName);

      result += """
      \nMap<String, String> $mapName = {
      """;

      map.forEach((key, value) {
        result += """
        "$key": "${_formatString(value)}",
        """;
      });

      result += "};\n";

      allValuesMap[lang] = map;
    }

    result += """
    \nMap<String, Map<String, String>> i10nWords = {
    """;

    supportedLanguages.asMap().forEach((index, lang) {
      result += """
        "$lang": ${mapsNames[index]},
      """;
    });

    result += "};\n";

    result = """
   /// This class is generated by library package, I18nTranslator
   \n
    """ +
        result;

    return result;
  }

  String _formatString(String text) {
    text = text.replaceAll('"', '\\"');

    text = text.replaceAll('\$', '\\\$');

    return text;
  }

  bool _writeInFile(String content, String file) {
    if (content == null) return false;

    if (file == null) return false;

    content = content.trim();

    if (content.isEmpty) return false;

    file = file.trim();

    if (file.isEmpty) return false;

    final File generatedFile = File(file);

    bool write = true;
    try {
      generatedFile.createSync(recursive: true);
      generatedFile.writeAsStringSync(content, mode: FileMode.write);
    } catch (ex) {
      write = false;
    }
    return write;
  }

  static void logError(String text) => print("[I10N ERROR] $text\r\n");
}

void main(List<String> arguments) {
  final translator = I10nTranslator();
  translator.generate(arguments.length == 0 ? null : arguments.first,
      arguments.length == 2 ? arguments[1] : null);
}

const List<String> RESERVED_WORDS = [
  "assert",
  "default",
  "finally",
  "rethrow",
  "try",
  "break",
  "do",
  "for",
  "return",
  "var",
  "case",
  "else",
  "if",
  "super",
  "void",
  "catch",
  "enum",
  "in",
  "switch",
  "while",
  "class",
  "extends",
  "is",
  "this",
  "with",
  "const",
  "false",
  "new",
  "throw",
  "continue",
  "final",
  "null",
  "true",
];
