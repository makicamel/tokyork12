@default_foreground ||= @foreground
@default_background ||= @background
@default_shadow_color ||= @shadow_color

@base_color            = '#333333'
accent_color           = '#dd451d'
@default_font          = 'Noto Sans JP'
@font_family           = find_font_family(@default_font)
@bold_font             = 'Noto Sans JP'
@bold_font_family      = find_font_family(@bold_font)
@monospace_font        = 'Space Mono'
@monospace_font_family = find_font_family(@monospace_font)

@default_item1_mark_color = accent_color
@default_item2_mark_color = accent_color

@xxxx_large_font_size = screen_size(10 * Pango::SCALE)
@xxx_large_font_size  = screen_size(8 * Pango::SCALE)
@xx_large_font_size   = screen_size(6 * Pango::SCALE)
@x_large_font_size    = screen_size(4.5 * Pango::SCALE)
@large_font_size      = screen_size(4 * Pango::SCALE)
@normal_font_size     = screen_size(3.5 * Pango::SCALE)
@small_font_size      = screen_size(3.2  * Pango::SCALE)
@x_small_font_size    = screen_size(3 * Pango::SCALE)
@xx_small_font_size   = screen_size(2.8 * Pango::SCALE)
@xxx_small_font_size  = screen_size(2.0 * Pango::SCALE)
@script_font_size            = @x_small_font_size
@large_script_font_size      = @small_font_size
@x_large_script_font_size    = @large_font_size
@title_slide_title_font_size = @xxx_large_font_size

@block_quote_fill_color = "#f8f8f8"
@preformatted_fill_color = "#f8f8f8"
@default_headline_line_color = accent_color
@description_term_line_color = @default_headline_line_color
@default_headline_line_width = 2

@title_slide_background_image = 'image/title_background.png'

@image_caption_color = @base_color
@default_emphasis_color = accent_color

@foot_text_block_line_width = 0

set_foreground(@base_color)

include_theme("default-icon")
include_theme("default-title-text")
include_theme("default-text")
include_theme("default-title-slide")
include_theme("default-slide")
include_theme("default-item-mark")
include_theme("default-method-list")
include_theme("default-preformatted")
include_theme("default-block-quote")
include_theme("default-description")
include_theme("image")
include_theme("table")
include_theme("newline-in-slides")
include_theme("per-slide-background-color")
include_theme("background-image-toolkit")
include_theme("per-slide-background-image")
include_theme("body-background-image")
include_theme("tag")
include_theme("syntax-highlighting")

include_theme("title-slide-background-image")

@lightning_talk_proc_name = "lightning-rabbit"
@lightning_talk_as_large_as_possible = true
@lightning_talk_color = @base_color
@lightning_talk_font_family = @bold_font
include_theme("lightning-talk-toolkit")

match(TitleSlide) do |slides|
  slides.vertical_centering = true
  slides.prop_set("weight", "Bold")
  slides.prop_set("foreground", "#fff")
end
match(TitleSlide, Title) do |titles|
  titles.padding_top = @space * 10
  titles.margin_right = @space * 12
  titles.margin_left = @space * 12
  titles.prop_set("size", @xxx_large_font_size)
  titles.prop_set("weight", "bold")
end
match(TitleSlide, "**", Emphasis) do |texts|
  texts.prop_set("foreground", @base_color)
end
match(TitleSlide, Author) do |author|
  author.margin_top = 80
  author.margin_bottom = 0
  author.vertical_centering = true
  author.prop_set("weight", "normal")
end
match(TitleSlide, Date) do |date|
  date.margin_top = 4
  date.prop_set("weight", "normal")
end
match(TitleSlide, ContentSource) do |cs|
  cs.margin_top = 4
  cs.prop_set("weight", "normal")
end
match(TitleSlide, "*") do |elems|
  elems.prop_set("style", "normal")
end

match(Slide, HeadLine) do |heads|
  heads.margin_top = 4
  heads.margin_bottom = 40
  heads.prop_set("size", @x_large_font_size)
  heads.prop_set("weight", "SemiBold")
end

match("**", ReferText) do |texts|
  texts.prop_set("foreground", accent_color)
  texts.prop_set("size", @xxx_small_font_size)
end

# 脚注参照番号
match("**", Footnote) do
  prop_set("foreground", @base_color)
  each do |note|
    note.text = "[^#{note.order}]"
    note.prop_set("size", @xxx_small_font_size)
    note.prop_set("rise", (@normal_font_size * 3 / 5.0).to_i)
  end
end
# 脚注本体番号
match("**", FootText) do
  each do |text|
    if text["order_added"]
      order_text = text.elements.first
      order_text.text = text.elements.first.text.sub(%r{\(\*(\d+)\)}) { "[^#{$1}]: " }
      order_text.prop_set("rise", (@xxx_small_font_size * 1 / 10.0).to_i)
      order_text.prop_set("foreground", @base_color)
      order_text.prop_set("size", @xxx_small_font_size)
    end
  end
end
# 脚注本体
match("**", FootTextBlock) do |text_block|
  text_block.margin_bottom = 0
  text_block.margin_left = 40
  text_block.prop_set("size", @xxx_small_font_size)
end

match(Slide) do |slides|
  slides.each do |slide|
    if slide.lightning_talk?
      slide.lightning_talk
    end
  end
end

pp "reloaded!"
