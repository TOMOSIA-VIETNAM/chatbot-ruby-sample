class String
  def clr_black;          "\e[30m#{self}\e[0m" end
  def clr_red;            "\e[31m#{self}\e[0m" end
  def clr_green;          "\e[32m#{self}\e[0m" end
  def clr_brown;          "\e[33m#{self}\e[0m" end
  def clr_blue;           "\e[34m#{self}\e[0m" end
  def clr_magenta;        "\e[35m#{self}\e[0m" end
  def clr_cyan;           "\e[36m#{self}\e[0m" end
  def clr_gray;           "\e[37m#{self}\e[0m" end

  def bg_black;       "\e[40m#{self}\e[0m" end
  def bg_red;         "\e[41m#{self}\e[0m" end
  def bg_green;       "\e[42m#{self}\e[0m" end
  def bg_brown;       "\e[43m#{self}\e[0m" end
  def bg_blue;        "\e[44m#{self}\e[0m" end
  def bg_magenta;     "\e[45m#{self}\e[0m" end
  def bg_cyan;        "\e[46m#{self}\e[0m" end
  def bg_gray;        "\e[47m#{self}\e[0m" end

  def sty_bold;           "\e[1m#{self}\e[22m" end
  def sty_italic;         "\e[3m#{self}\e[23m" end
  def sty_underline;      "\e[4m#{self}\e[24m" end
  def sty_blink;          "\e[5m#{self}\e[25m" end
  def sty_reverse_color;  "\e[7m#{self}\e[27m" end
end
