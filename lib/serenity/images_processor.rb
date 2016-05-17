module Serenity
  class ImagesProcessor
    include Debug

    def initialize(xml_content, context)
      @replacements = []
      @images = eval('@images', context)
      @xml_content = xml_content
    end

    def generate_replacements
      require 'nokogiri'

      if @images && @images.kind_of?(Hash)
        xml_data = Nokogiri::XML(@xml_content)

        @images.each do |image_name, replacement_path|
          if node = xml_data.xpath("//draw:frame[@draw:name='#{image_name}']/draw:image").first
            placeholder_path = node.attribute('href').value

            @replacements << [placeholder_path, replacement_path]
          end
        end
      end

      @replacements
    end
  end
end
