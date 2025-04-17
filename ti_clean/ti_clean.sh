  GNU nano 7.2                                                       ti_clean.sh                                                                 
#!/bin/bash

# Перевірка наявності аргументу
if [ -z "$1" ]; then
  echo "❌ Вкажи ім'я файлу, наприклад: ti_clean subtitle.vtt"
  exit 1
fi

# Каталог із файлами
DIR="/home/tysser/Desktop"
FILENAME="$1"
INPUT="$DIR/$FILENAME"

# Формуємо ім'я для виводу
BASENAME="${FILENAME%.*}"        # без .vtt
OUTPUT="$DIR/clean_${BASENAME}.txt"

# Перевірка, чи існує вхідний файл
if [ ! -f "$INPUT" ]; then
  echo "❌ Файл не знайдено: $INPUT"
  exit 1
fi

# Обробка
sed -e '/^WEBVTT/d' \
    -e '/^X-TIMESTAMP-MAP/d' \
    -e '/^[0-9]\{2\}:[0-9]\{2\}\.[0-9]\{3\} --> /d' \
    -e '/^\[Music\]/d' "$INPUT" |
tr '\n' ' ' |
sed -E 's/\. +([A-Z])/\.\n\1/g' > "$OUTPUT"

echo "✅ Збережено до: $OUTPUT"
