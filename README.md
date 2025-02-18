# LINUX_USB_PREKOL

Этот проект представляет собой модуль ядра Linux, который отключает USB-устройства при обнаружении определенного процесса. Модуль может быть настроен для автоматической загрузки при старте системы.

## Сборка и установка

### Требования
- Установленный компилятор и инструменты для сборки модулей ядра.
- Права `sudo` для установки и загрузки модуля.

### Команды Makefile

#### 1. **Сборка модуля**
##### Собирает модуль ядра
```bash
make
```
##### После выполнения команды будет создан файл src/usb_prekol.ko.
---------
#### 2. **Временная загрузка модуля**
##### Загружает модуль в ядро без настройки автозагрузки.
```bash
make load
```
##### Модуль будет загружен в ядро, но не будет сохраняться после перезагрузки.
---------
#### 3. **Выгрузка модуля**
Выгружает модуль из ядра.
```bash
make unload
```
##### Модуль будет удален из ядра.
----------
#### 4. **Установка модуля на автозагрузку**
##### Устанавливает модуль в систему и настраивает его автозагрузку при старте системы.
```bash
make install
```
- Модуль будет скопирован в /lib/modules/$(uname -r)/kernel/drivers/usb/.
- Будет создан конфигурационный файл для автоматической загрузки модуля.
----------
#### 5. **Удаление модуля**
##### Удаляет модуль из системы и отключает его автозагрузку.
```bash
make uninstall
```
- Модуль будет удален из /lib/modules/$(uname -r)/kernel/drivers/usb/.
- Конфигурационные файлы для автозагрузки будут удалены.
- Модуль будет выгружен из ядра.
-----------
#### 6. **Очистка проекта**
##### Удаляет все сгенерированные файлы, кроме исходных (.c и .h).
```bash
make clean
```
##### Удаляются:
- Объектные файлы (.o).
- Временные файлы (.cmd, .flags, .mod.c, .order).
- Скрытые файлы (.tmp*, .*.*.cmd).
- Скомпилированный модуль (usb_prekol.ko).
- Промежуточные файлы (usb_prekol.mod.c, usb_prekol.mod.o).
------------

## Параметры
- TARGET_PROCESS: Имя процесса, при обнаружении которого USB-устройства будут отключены. По умолчанию: "phpstorm".

Пример:
```bash
make install TARGET_PROCESS="my_custom_script.sh"
```
или
```bash
make load TARGET_PROCESS="my_custom_script.sh"
```
------
## Лицензия

Этот проект распространяется под лицензией **GPL v2**. Подробности см. в файле [LICENSE](LICENSE).
