import os

# Имя скрипта, которое нужно исключить
EXCLUDE_FILE = "main.py"
# Путь к текущей папке
CURRENT_DIR = os.getcwd()
# Имя выходного файла для слияния
OUTPUT_FILE = "merged.sql"

# Функция для проверки, что файл соответствует шаблону и не является скриптом

def is_sql_file(filename):
    return filename.endswith(".sql") and filename != OUTPUT_FILE and filename != EXCLUDE_FILE

# Получение списка всех подходящих файлов
sql_files = sorted(
    [f for f in os.listdir(CURRENT_DIR) if is_sql_file(f)]
)

if not sql_files:
    print("Нет файлов для объединения.")
else:
    with open(OUTPUT_FILE, "w", encoding="utf-8") as outfile:
        for filename in sql_files:
            filepath = os.path.join(CURRENT_DIR, filename)
            with open(filepath, "r", encoding="utf-8") as infile:
                outfile.write(infile.read())
                outfile.write("\n\n")
    print(f"Файлы успешно объединены в {OUTPUT_FILE}.")
