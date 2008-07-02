module Moo
  class TextLine < OptionsStruct.create(:design, :string, :font_size, :bold, :italic, :align, :font, :colour)
    def default_options
      {
        :bold => false,
        :align => 'left',
        :font => 'modern',
        :colour => '#000000'
      }
    end
  end
end