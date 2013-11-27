module Serenity
  class XmlReader

    def initialize src
      @src = src.force_encoding("UTF-8")
    end

    def each_node
      last_match_pos = 0
      part_match = false
      ptext = ''

      @src.scan(/<.*?>/) do |node|
        m = Regexp.last_match
        if m.begin(0) > last_match_pos
          text = @src[last_match_pos...m.begin(0)]
          part_match ||= (text =~ /\s*\{%/ and not text =~ /%\}\s*/)
          if part_match
            ptext += text
            if ptext  =~ /%\}\s*/ #end of tag
              part_match = false
              yield ptext.unescape_xml, node_type(ptext)
              ptext=''
            end
          else
            yield text, node_type(text) if text != ''
          end
        end
        last_match_pos = m.end(0)
        yield node, NodeType::TAG unless part_match

      end
    end

    def node_type text
      if text =~ /\s*\{%[^=#].+?%\}\s*/
        NodeType::CONTROL
      else
        NodeType::TEMPLATE
      end
    end
  end
end
