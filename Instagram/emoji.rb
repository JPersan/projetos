require 'gemoji'

$emoji = Emoji.create("mao") do |char|
    char.add_alias "mao"
    char.add_unicode_alias "\u{270b}"
    char.add_tag "notes"
  end