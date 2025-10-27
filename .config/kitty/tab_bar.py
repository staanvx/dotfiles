# pyright: reportMissingImports=false
import math
import datetime
from kitty.fast_data_types import Screen
from kitty.tab_bar import DrawData, ExtraData, TabBarData, draw_title, as_rgb
from kitty.rgb import to_color

# ──────────────────────────────────────────────
# Константы стиля
# ──────────────────────────────────────────────
LEFT_PAD   = " "
RIGHT_PAD  = ""
SEPARATOR  = ""
TAB_SPACING = " "   # отступ между вкладками

# Цвета
GREEN    = as_rgb(int(to_color("#36c692")))  # имя сессии
RIGHT_FG = as_rgb(int(to_color("#e4e4e4")))  # цвет правого статуса (время)

TIME_FMT = "%H:%M"    # формат времени
MAX_SESSION_LEN = 24  # ограничение длины имени сессии

# ──────────────────────────────────────────────
# Вспомогательные функции
# ──────────────────────────────────────────────

def _truncate_middle(s: str, n: int) -> str:
    """Обрезает строку посередине с троеточием, если слишком длинная."""
    if len(s) <= n:
        return s
    half = (n - 1) // 2
    return s[:half] + "… " + s[-half:]

def _session_name(draw_data: DrawData, tab: TabBarData) -> str:
    """Получить имя сессии (session_name, active_session_name или title)."""
    for attr in ("session_name", "active_session_name", "title"):
        v = getattr(draw_data, attr, None) or getattr(tab, attr, None)
        if isinstance(v, str) and v.strip():
            return v.strip()
    return ""

def _badge_text(name: str) -> str:
    """Подготовить бейдж для имени сессии."""
    return f"{LEFT_PAD}{name.upper()}{RIGHT_PAD}" if name else ""

def _right_status_text() -> str:
    """Текст правого статуса (время). Добавляй сюда VPN/CPU и т.п."""
    return " " + datetime.datetime.now().strftime(TIME_FMT)

def _draw_right_status(screen: Screen, text: str) -> int:
    """Рисуем правый статус у правого края и возвращаем его ширину."""
    right_len = len(text)
    target_x = max(0, screen.columns - right_len)
    old_fg = screen.cursor.fg
    old_bold = screen.cursor.bold   # ← запомним состояние жирности

    screen.cursor.x  = target_x
    screen.cursor.fg = RIGHT_FG
    screen.cursor.bold = False      # ← сбрасываем жирный
    screen.draw(text)

    screen.cursor.fg = old_fg
    screen.cursor.bold = old_bold   # ← возвращаем
    screen.cursor.x = screen.columns
    return right_len

# ──────────────────────────────────────────────
# Основная функция отрисовки
# ──────────────────────────────────────────────

_left_status_len = 0

def draw_tab(draw_data, screen: Screen, tab: TabBarData,
             before: int, max_len: int, index: int, is_last: bool,
             extra_data: ExtraData) -> int:
    global _left_status_len

    # ► Бейдж с именем сессии (один раз, слева)
    if before == 0:
        name = _session_name(draw_data, tab)
        label = _badge_text(_truncate_middle(name, MAX_SESSION_LEN))
        if label:
            start_x = screen.cursor.x
            old_fg   = screen.cursor.fg
            old_bold = screen.cursor.bold

            screen.cursor.fg   = GREEN
            screen.cursor.bold = True
            screen.draw(label + SEPARATOR)
            screen.cursor.bold = old_bold
            screen.cursor.fg   = old_fg

            # реальная ширина левого блока по координатам (корректно для иконок)
            _left_status_len = screen.cursor.x - start_x
        else:
            _left_status_len = 0

    # ► Стандартная отрисовка вкладок Kitty
    draw_title(draw_data, screen, tab, index, max_len)

    # ► Отступы между вкладками
    if not is_last:
        screen.draw(TAB_SPACING)

    # ► После последней вкладки — центрируем и рисуем правый статус
    if is_last:
        end_x = screen.cursor.x
        center_width = max(0, end_x - _left_status_len)

        # 1) формируем текст правого статуса и узнаём его длину (без рисования)
        right_text = _right_status_text()
        right_len  = len(right_text)

        # 2) считаем отступ для центрирования между левым и правым блоками
        leading_spaces = (screen.columns - _left_status_len - right_len - center_width) / 2
        leading_spaces = int(math.floor(leading_spaces))

        # 3) вставляем пробелы сразу после левого бейджа — сдвигаем центр
        if leading_spaces > 0:
            screen.cursor.x = _left_status_len
            screen.insert_characters(leading_spaces)
            screen.cursor.x = end_x + leading_spaces
        else:
            screen.cursor.x = end_x

        # 4) теперь рисуем правый статус — он уже не «уедет»
        _draw_right_status(screen, right_text)

        screen.cursor.x = screen.columns

    return screen.cursor.x
