require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Serenity

  Node = Struct.new(:text, :type)

  describe XmlReader do
    it "should stream the xml, tag by tag" do
      xml  = <<-EOF
          <?xml version="1.0" encoding="UTF-8"?><office:document-content><office:scripts/>
          <office:body><text:p style="Standard">This is<text:span text:style-name="T10"> </text:span>a sentence</text:p><text:s>{%= yeah %}</text:s></office:body>
          {% for row in rows %}
          </office:document-content>
        EOF

      expected = [Node.new('          ', NodeType::TEMPLATE),
                  Node.new('<?xml version="1.0" encoding="UTF-8"?>', NodeType::TAG),
                  Node.new('<office:document-content>', NodeType::TAG),
                  Node.new('<office:scripts/>', NodeType::TAG),
                  Node.new("\n          ", NodeType::TEMPLATE),
                  Node.new('<office:body>', NodeType::TAG),
                  Node.new('<text:p style="Standard">', NodeType::TAG),
                  Node.new('This is', NodeType::TEMPLATE),
                  Node.new('<text:span text:style-name="T10">', NodeType::TAG),
                  Node.new(' ', NodeType::TEMPLATE),
                  Node.new('</text:span>', NodeType::TAG),
                  Node.new('a sentence', NodeType::TEMPLATE),
                  Node.new('</text:p>', NodeType::TAG),
                  Node.new('<text:s>', NodeType::TAG),
                  Node.new('{%= yeah %}', NodeType::TEMPLATE),
                  Node.new('</text:s>', NodeType::TAG),
                  Node.new('</office:body>', NodeType::TAG),
                  Node.new("\n          {% for row in rows %}\n          ", NodeType::CONTROL),
                  Node.new('</office:document-content>', NodeType::TAG)]

      reader = XmlReader.new xml

      idx = 0
      reader.each_node do |node, type|
        node.should == expected[idx].text
        type.should == expected[idx].type
        idx += 1
      end
    end
    it "should ignore tags in controls and templates" do
      xml  = <<-EOF
          <office:body><text:p style="Standard">This is<text:span text:style-name="T10">
          </text:span>a sentence</text:p><text:s>{%= <text:span text:style-name="T10">yeah</text:span> %}</text:s></office:body>
      EOF
      expected = [Node.new('          ', NodeType::TEMPLATE),
                  Node.new('<office:body>', NodeType::TAG),
                  Node.new('<text:p style="Standard">', NodeType::TAG),
                  Node.new('This is', NodeType::TEMPLATE),
                  Node.new('<text:span text:style-name="T10">', NodeType::TAG),
                  Node.new("\n          ", NodeType::TEMPLATE),
                  Node.new('</text:span>', NodeType::TAG),
                  Node.new('a sentence', NodeType::TEMPLATE),
                  Node.new('</text:p>', NodeType::TAG),
                  Node.new('<text:s>', NodeType::TAG),
                  Node.new('{%= yeah %}', NodeType::TEMPLATE),
                  Node.new('</text:s>', NodeType::TAG),
                  Node.new('</office:body>', NodeType::TAG),
                  Node.new("\n          {% for row in rows %}\n          ", NodeType::CONTROL),
                  Node.new('</office:document-content>', NodeType::TAG)]
      reader = XmlReader.new xml

      idx = 0
      reader.each_node do |node, type|
        node.should == expected[idx].text
        type.should == expected[idx].type
        idx += 1
      end

    end
    it "should unescape xml" do
      xml  = <<-EOF
              <text:p text:style-name="P1"><text:span text:style-name="T1">{%=</text:span>
              <text:span text:style-name="T2">@data.applicants.applicant[1][&apos;first-name&apos;]</text:span><text:span text:style-name="T1">%}</text:span></text:p>
      EOF
      expected = [Node.new('              ', NodeType::TEMPLATE),
                  Node.new('<text:p text:style-name="P1">', NodeType::TAG),
                  Node.new('<text:span text:style-name="T1">', NodeType::TAG),
                  Node.new("{%=\n              @data.applicants.applicant[1]['first-name']%}", NodeType::TEMPLATE),
                  Node.new('</text:span>', NodeType::TAG),
                  Node.new('</text:p>', NodeType::TAG)]
      reader = XmlReader.new xml

      idx = 0
      reader.each_node do |node, type|
        node.should == expected[idx].text
        type.should == expected[idx].type
        idx += 1
      end

    end
  end
end

