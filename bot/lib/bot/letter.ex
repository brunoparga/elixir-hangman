defmodule Bot.Letter do

  def new_letter do
    letter_list = for n <- ?a..?z, do: << n :: utf8 >>
    Enum.random(letter_list)
  end
end
