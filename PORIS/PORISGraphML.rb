require "rexml/document"


require_relative 'PORIS'


######### PORISValueFormatter #################

module PORISValueFormatterGraphMLPatch
  def self.included(base)
    base.extend(ClassMethods)

    base.send(:include , InstanceMethods)

    base.class_eval do
    end
  end

  module ClassMethods

    def fromGraphMLRef(n_node)
      idnode = n_node.elements["value-formatter-id"]
      idnode.each_element do |t|
        if t.text?
          @@instances[t.text]
        end
      end
      nil
    end

  end

  module InstanceMethods

    def toGraphMLRef(dom)
      n_node = REXML::Element.new("value-formatter-id")
      n_node.add_attribute("type", "integer")
      if @id
        value_text = REXML::Text.new(@id.to_s)
        n_node.add_text(value_text)
      else
        n_node.add_attribute("nil", "true")
      end
      n_node
    end

  end
end
PORISValueFormatter.send(:include, PORISValueFormatterGraphMLPatch)

######### PORIS #################

module PORISGraphMLPatch
  def self.included(base)
    base.extend(ClassMethods)

    base.send(:include , InstanceMethods)

    base.class_eval do
    end
  end

  module ClassMethods

    # Recovers the id of the item from a reference
    def fromGraphMLRef(n_node, pdoc)
      # puts "destination_node: #{n_node.xpath}"
      idnode = n_node.getElementsByTagName("id")[0]
      if idnode.firstChild.nodeType == idnode.TEXT_NODE
        return pdoc.get_item(idnode.firstChild.nodeValue.to_i)
      end
      nil
    end


    # Creates the object instance from an GraphML node
    def fromGraphML(n_node, pdoc)
      ret = nil
      name = nil
      ident = nil
      nats_node = nil
      labs_node = nil
      virtual = false
      n_node.children.each do |e|
        if not virtual
          if e.xpath == "name"
            e.children.each do |c|
              if c.nodeType == c.TEXT_NODE
                name = c.nodeValue
                break
              end
            end
          end

          if e.xpath == "id"
            e.children.each do |c|
              if c.nodeType == c.TEXT_NODE
                id = c.nodeValue.to_i
                if (id < 0)
                  virtual = true
                end
                break
              end
            end
          end

          if e.xpath == "ident"
            e.children.each do |c|
              if c.nodeType == c.TEXT_NODE
                ident = c.nodeValue
                break
              end
            end
          end

          if e.xpath == "node-attributes"
            nats_node = e
          end

          if e.xpath == "labels"
            labs_node = e
          end
        end
      end

      if not virtual
        ret = PORIS.new(name)
        ident ||= "id_#{@id}"
        ret.setIdent(ident)
        pdoc.addItem(ret, id)

        if nats_node
          nats_node.children.each do |e|
            if e.xpath == "node-attribute"
              this_nat = {}
              this_key = nil
              e.children.each do |f|
                if f.xpath == "content"
                  f.children.each do |c|
                    if c.nodeType == c.TEXT_NODE
                      this_nat["content"] = c.nodeValue
                    end
                  end
                end

                if f.xpath == "name"
                  f.children.each do |c|
                    if c.nodeType == c.TEXT_NODE
                      this_key = c.nodeValue
                    end
                  end
                end

                if f.xpath == "visibility"
                  f.children.each do |c|
                    if c.nodeType == c.TEXT_NODE
                      this_nat["visibility"] = (c.nodeValue == "true")
                    end
                  end
                end
              end
              if this_key
                ret.instance_variable_get(:@node_attributes)[this_key] = this_nat
              end
            end
          end
        end

        if labs_node
          labs_node.children.each do |e|
            if e.xpath == "label"
              this_sck = nil
              this_name = nil
              e.children.each do |f|
                if f.xpath == "name"
                  f.children.each do |c|
                    if c.nodeType == c.TEXT_NODE
                      this_name = c.nodeValue
                    end
                  end
                end

                if f.xpath == "scope-kind"
                  f.children.each do |c|
                    if c.xpath == "name"
                      c.children.each do |d|
                        if d.nodeType == c.TEXT_NODE
                          this_sck = d.nodeValue
                        end
                      end
                    end
                  end
                end
              end
              if this_name && this_sck
                ret.setLabel(this_name, this_sck)
                ret.instance_variable_get(:@labels)[this_name] = this_sck
              end
            end
          end
        end
      end
      ret
    end


  end

  module InstanceMethods


    # Getter for the node name (tag name) which depends of the class.
    # It will be overloaded by subclasses
    def getGraphMLNodeName
      "none"
    end

    # Getter for the nodetype which depends of the class.
    # It will be overloaded by subclasses
    def getGraphMLNodeType
      0
    end

    # Getter for the type which depends of the class, by default is the class name
    # It can overloaded by subclasses.
    def getGraphMLType
      self.class.name
    end

    # Builds a reference for the item, to be used mainly inside the "destination" tag
    def toGraphMLRef(dom)
      ret = REXML::Element.new("id")
      ret.add_attribute("type", "integer")
      value_text = REXML::Text.new(@id.to_s)
      ret.push(value_text)
      ret
    end

    def addGraphMLShapeToNode(dom, content_node)
      data_child = REXML::Element.new("error")
      data_child.add_attribute("ERROR", "******* #{self.getName}:#{self.class.name} *************")
      content_node.push(data_child)
    end


    # Dumps the current item to an GraphML node
    # PORIS items, after calling this function using super().toGraphML(doc),
    # will add additional nodes which will depend on the class
    def toGraphML(dom)
      # Tag name will be normally the class name, but it can be overloaded
      # so we use a function to get it
      n_node = REXML::Element.new("node")

=begin
      <node id="n0::n5::n5::n0::n3::n0">
      <data key="d9" xml:space="preserve"><![CDATA[ARC-0081]]></data>
      <data key="d10" xml:space="preserve">81</data>
      <data key="d11" xml:space="preserve"><![CDATA[arcgen]]></data>
      <data key="d13" xml:space="preserve"><![CDATA[http://csys.cosmobots.eu:3000/issues/81]]></data>
    </node>
=end

      n_node.add_attribute("id", "id_#{self.getId.to_s}")

      # subnode with an identifying integer
      id_child = REXML::Element.new("data")
      id_child.add_attribute("key", "d9")
      id_child.add_attribute("xml:space", "preserve")
      value_text = REXML::CData.new(self.getIdent)
      id_child.push(value_text)
      n_node.push(id_child)

      # subnode with an identifying integer
      id_child = REXML::Element.new("data")
      id_child.add_attribute("key", "d10")
      id_child.add_attribute("xml:space", "preserve")
      value_text = REXML::Text.new(self.getRmId.to_s)
      id_child.push(value_text)
      n_node.push(id_child)


      # subnode with an identifying integer
      id_child = REXML::Element.new("data")
      id_child.add_attribute("key", "d11")
      id_child.add_attribute("xml:space", "preserve")
      value_text = REXML::CData.new(self.getDocument.getRmId)
      id_child.push(value_text)
      n_node.push(id_child)


      # subnode with an identifying integer
      id_child = REXML::Element.new("data")
      id_child.add_attribute("key", "d13")
      id_child.add_attribute("xml:space", "preserve")
      value_text = REXML::CData.new("https://dev.csys.cosmobots.eu/issues/self.getRmId.to_s")
      id_child.push(value_text)
      n_node.push(id_child)

      # subnode with an identifying integer
      data_child = REXML::Element.new("data")
      data_child.add_attribute("key", "d15")
      addGraphMLShapeToNode(dom, data_child)
      n_node.push(data_child)

      n_node
    end

  end
end
PORIS.send(:include, PORISGraphMLPatch)



######### PORISValue #################

module PORISValueGraphMLPatch
  def self.included(base)
    base.extend(ClassMethods)

    base.send(:include , InstanceMethods)

    base.class_eval do
    end
  end

  module ClassMethods

    # Creates the object instance from an GraphML node
    def fromGraphML(n_node, pdoc)
      ret = super(n_node, pdoc)
      if ret != nil then
        ret.class = PORISValue
        formatter = PORISValueFormatter.fromGraphMLRef(n_node)
        ret.setGraphMLFormatter(formatter)
      end
      ret
    end

  end

  module InstanceMethods

    # the tag name will be "value", but subclasses
    # might overload it
    def getGraphMLNodeName
      "value"
    end

    # getter for the node type (overloading PORIS one)
    def getGraphMLNodeType
      5
    end

    def getGraphMLFormatter
      @__formatter
    end

    def setGraphMLFormatter(formatter)
      @__formatter = PORISVALUEFORMATTER_NIL
    end

    # Dumps item to GraphML, uses super().toGraphML and
    # appends specific nodes for this class
    def addGraphMLShapeToNode(dom, content_node)

      shape_node = REXML::Element.new("y:ShapeNode")

      thisnode = REXML::Element.new("y:Geometry")
      thisnode.add_attribute("height", "30.0")
      thisnode.add_attribute("width", "30.0")
      thisnode.add_attribute("x", "610.0")
      thisnode.add_attribute("y", "913.0")
      shape_node.push(thisnode)

      thisnode = REXML::Element.new("y:Fill")
      thisnode.add_attribute("color", "#99CCFF")
      thisnode.add_attribute("transparent", "false")
      shape_node.push(thisnode)

      thisnode = REXML::Element.new("y:BorderStyle")
      thisnode.add_attribute("color", "#000000")
      thisnode.add_attribute("type", "line")
      thisnode.add_attribute("width", "1.0")
      shape_node.push(thisnode)

      thisnode = REXML::Element.new("y:NodeLabel")
      thisnode.add_attribute("alignment", "center")
      thisnode.add_attribute("autoSizePolicy", "content")
      thisnode.add_attribute("fontFamily", "Dialog")
      thisnode.add_attribute("fontSize", "12")
      thisnode.add_attribute("fontStyle", "plain")
      thisnode.add_attribute("hasBackgroundColor", "false")
      thisnode.add_attribute("hasLineColor", "false")
      thisnode.add_attribute("height", "17.96875")
      thisnode.add_attribute("horizontalTextPosition", "center")
      thisnode.add_attribute("iconTextGap", "4")
      thisnode.add_attribute("modelName", "internal")
      thisnode.add_attribute("modelPosition", "c")
      thisnode.add_attribute("textColor", "#000000")
      thisnode.add_attribute("verticalTextPosition", "bottom")
      thisnode.add_attribute("visible", "true")
      thisnode.add_attribute("width", "26.37109375")
      thisnode.add_attribute("x", "1.814453125")
      thisnode.add_attribute("xml:space", "preserve")
      thisnode.add_attribute("y", "6.015625")
      value_text = REXML::Text.new(self.getName)
      thisnode.push(value_text)
      shape_node.push(thisnode)

      thisnode = REXML::Element.new("y:Shape")
      thisnode.add_attribute("type", "parallelogram")
      shape_node.push(thisnode)

      content_node.push(shape_node)

    end

  end
end
PORISValue.send(:include, PORISValueGraphMLPatch)





######### PORISValueData #################

module PORISValueDataGraphMLPatch
  def self.included(base)
    base.extend(ClassMethods)

    base.send(:include , InstanceMethods)

    base.class_eval do
    end
  end

  module ClassMethods

    # Creates the object instance from an GraphML node
    def fromGraphML(n_node, pdoc)
      ret = super(n_node, pdoc)
      if ret != nil then
        ret.class = PORISValueData
        formatter = PORISValueFormatter.fromGraphMLRef(n_node)
        ret.setGraphMLFormatter(formatter)
      end
      ret
    end

  end

  module InstanceMethods

    # The tag is "none" because this class shall never
    # be instanced directly
    def getGraphMLNodeName
      "none"
    end

    # The node type is 0 because this class shall never
    # be instanced directly
    def getGraphMLNodeType
      0
    end

  end
end
PORISValueData.send(:include, PORISValueDataGraphMLPatch)


######### PORISValueString #################

module PORISValueStringGraphMLPatch
  def self.included(base)
    base.extend(ClassMethods)

    base.send(:include , InstanceMethods)

    base.class_eval do
    end
  end

  module ClassMethods

    # Creates the object instance from an GraphML node
    def fromGraphML(n_node, pdoc)
      ret = super(n_node, pdoc)
      if ret != nil then
        ret.class = PORISValueString

        listnodes = n_node.elements.to_a("default-string")
        if listnodes.length > 0
          defaultstringnode = listnodes[0]
          if defaultstringnode.nil?
            puts "ERROR! default string is None"
          else
            defaultstringnode.elements.each do |t|
              if t.node_type == REXML::Text::NodeType
                ret.setDefaultData(t.value)
              end
            end
          end
        end

        formatter = PORISValueFormatter.fromGraphMLRef(n_node)
        ret.setGraphMLFormatter(formatter)
      end
      ret
    end
  end

  module InstanceMethods

    # getter for the GraphML tag name
    def getGraphMLNodeName
      "value-string"
    end

    # The node type is 6 for PORISValueStrings
    def getGraphMLNodeType
      6
    end

  end
end
PORISValueString.send(:include, PORISValueStringGraphMLPatch)

######### PORISValueFilePath #################

module PORISValueFilePathGraphMLPatch
  def self.included(base)
    base.extend(ClassMethods)

    base.send(:include , InstanceMethods)

    base.class_eval do
    end
  end

  module ClassMethods

    # Creates the object instance from an GraphML node
    def fromGraphML(n_node, pdoc)
      ret = super(n_node, pdoc)
      if ret != nil then
        ret.class = PORISValueFilePath
        ret.file_ext = nil
        ret.file_desc = nil

        extnode = n_node.elements["file-extension"]
        if extnode.nil?
          puts "ERROR! default string is None"
        else
          extnode.elements.each do |t|
            if t.node_type == REXML::Text::NodeType
              ret.file_ext = t.value
            end
          end
        end

        descnode = n_node.elements["file-description"]
        if descnode.nil?
          puts "ERROR! default string is None"
        else
          descnode.elements.each do |t|
            if t.node_type == REXML::Text::NodeType
              ret.file_desc = t.value
            end
          end
        end

        formatter = PORISValueFormatter.fromGraphMLRef(n_node)
        ret.setGraphMLFormatter(formatter)
      end
      ret
    end

  end

  module InstanceMethods

    # Getter for the GraphML tag name of this item
    def getGraphMLNodeName
      "value-file-path"
    end

  end
end
PORISValueFilePath.send(:include, PORISValueFilePathGraphMLPatch)


######### PORISValueDate #################

module PORISValueDateGraphMLPatch
  def self.included(base)
    base.extend(ClassMethods)

    base.send(:include , InstanceMethods)

    base.class_eval do
    end
  end

  module ClassMethods

    # Creates the object instance from an GraphML node
    def fromGraphML(n_node, pdoc)
      ret = super(n_node, pdoc)
      if ret != nil then
        ret.class = PORISValueDate
        ret.min_date = nil
        ret.max_date = nil

        defaultstringnode = n_node.elements["default-date"]
        if defaultstringnode.nil?
          puts "ERROR! default string is None"
        else
          defaultstringnode.elements.each do |t|
            if t.node_type == REXML::Text::NodeType
              ret.setDefaultData(t.value)
            end
          end
        end

        maxnode = n_node.elements["date-max"]
        if maxnode.nil?
          puts "ERROR! default string is None"
        else
          maxnode.elements.each do |t|
            if t.node_type == REXML::Text::NodeType
              ret.max_date = t.value
            end
          end
        end

        minnode = n_node.elements["date-min"]
        if minnode.nil?
          puts "ERROR! default string is None"
        else
          minnode.elements.each do |t|
            if t.node_type == REGraphML::Text::NodeType
              ret.min_date = t.value
            end
          end
        end

        formatter = PORISValueFormatter.fromGraphMLRef(n_node)
        ret.setGraphMLFormatter(formatter)
      end
      ret
    end

  end

  module InstanceMethods


    # getter for the node type (overloading PORISValueString one)
    def getGraphMLNodeType
      5
    end

    # Getter for the GraphML tag name of this item
    def getGraphMLNodeName
      "value-date"
    end

    # getter for the GraphML tag name
    def getGraphMLFormatter
      PORISVALUEFORMATTER_DATE
    end

  end
end
PORISValueDate.send(:include, PORISValueDateGraphMLPatch)

######### PORISValueFloat #################

module PORISValueFloatGraphMLPatch
  def self.included(base)
    base.extend(ClassMethods)

    base.send(:include , InstanceMethods)

    base.class_eval do
    end
  end

  module ClassMethods

    # Creates the object instance from an GraphML node
    def fromGraphML(n_node, pdoc)
      ret = super(n_node, pdoc)
      if ret != nil then
        ret.class = PORISValueFloat

        defaultfloatnode = n_node.elements["default-float"]
        if defaultfloatnode.nil?
          puts "ERROR! default float is None"
        else
          defaultfloatnode.elements.each do |t|
            if t.node_type == REXML::Text::NodeType
              ret.setDefaultData(t.value.to_f)
            end
          end
        end

        minnode = n_node.elements["rangemin"]
        if minnode.nil?
          puts "ERROR! default float is None"
        else
          minnode.elements.each do |t|
            if t.node_type == REXML::Text::NodeType
              ret.__min = t.value.to_f
            end
          end
        end

        maxnode = n_node.elements["rangemax"]
        if maxnode.nil?
          puts "ERROR! default float is None"
        else
          maxnode.elements.each do |t|
            if t.node_type == REXML::Text::NodeType
              ret.__max = t.value.to_f
            end
          end
        end

        formatter = PORISValueFormatter.fromGraphMLRef(n_node)
        ret.setGraphMLFormatter(formatter)
      end
      ret
    end

  end

  module InstanceMethods

    # getter for the GraphML tag name
    def getGraphMLNodeName
      "value-double-range"
    end

    # getter for the formatter, overload super()'s
    def getGraphMLFormatter
      PORISVALUEFORMATTER_REAL
    end

    # Dumps item to GraphML, uses super().toGraphML and
    # appends specific nodes for this class
    def addGraphMLShapeToNode(dom, content_node)

=begin

      PORISValue

      <data key="d15">
        <y:ShapeNode>

          <y:Geometry height="30.0" width="30.0" x="640.6763137032586" y="913.1919259494838"/>
          <y:Fill color="#99CCFF" transparent="false"/>
          <y:BorderStyle color="#000000" type="line" width="1.0"/>
          <y:NodeLabel alignment="center" autoSizePolicy="content" fontFamily="Dialog" fontSize="12" fontStyle="plain" hasBackgroundColor="false" hasLineColor="false" height="17.96875" horizontalTextPosition="center" iconTextGap="4" modelName="internal" modelPosition="c" textColor="#000000" verticalTextPosition="bottom" visible="true" width="26.37109375" x="1.814453125" xml:space="preserve" y="6.015625">1x1</y:NodeLabel>

          <y:Shape type="parallelogram"/>
        </y:ShapeNode>
      </data>


      PORISValueFloat


      <data key="d15">
        <y:ShapeNode>
          <y:Geometry height="46.0" width="134.0" x="437.17631370325864" y="1488.2614772156162"/>
          <y:Fill color="#CCCCFF" transparent="false"/>
          <y:BorderStyle color="#000000" type="line" width="1.0"/>
          <y:NodeLabel alignment="center" autoSizePolicy="content" fontFamily="Dialog" fontSize="12" fontStyle="plain" hasBackgroundColor="false" hasLineColor="false" height="17.96875" horizontalTextPosition="center" iconTextGap="4" modelName="internal" modelPosition="tr" textColor="#000000" verticalTextPosition="bottom" visible="true" width="69.47265625" x="60.52734375" xml:space="preserve" y="4.0">
            Full_Range
          </y:NodeLabel>
          <y:NodeLabel alignment="center" autoSizePolicy="content" backgroundColor="#FFFFFF" fontFamily="Dialog" fontSize="12" fontStyle="bold" hasLineColor="false" height="17.96875" horizontalTextPosition="center" iconTextGap="4" modelName="custom" textColor="#0000FF" verticalTextPosition="bottom" visible="true" width="107.6171875" x="13.19140625" xml:space="preserve" y="20.956670673077042">
            0 &lt; 200 &lt; 1000
            <y:LabelModel>
              <y:SmartNodeLabelModel distance="4.0"/>
            </y:LabelModel>
            <y:ModelParameter>
              <y:SmartNodeLabelModelParameter labelRatioX="0.0" labelRatioY="0.5" nodeRatioX="0.0" nodeRatioY="0.3462047972408028" offsetX="0.0" offsetY="0.0" upX="0.0" upY="-1.0"/>
            </y:ModelParameter>
          </y:NodeLabel>
          <y:Shape type="parallelogram"/>
        </y:ShapeNode>
      </data>
=end

      shape_node = REXML::Element.new("y:ShapeNode")

      thisnode = REXML::Element.new("y:Geometry")
      thisnode.add_attribute("height", "46.0")
      thisnode.add_attribute("width", "134.0")
      thisnode.add_attribute("x", "437.0")
      thisnode.add_attribute("y", "1488.0")
      shape_node.push(thisnode)

      thisnode = REXML::Element.new("y:Fill")
      thisnode.add_attribute("color", "#CCCCFF")
      thisnode.add_attribute("transparent", "false")
      shape_node.push(thisnode)

      thisnode = REXML::Element.new("y:BorderStyle")
      thisnode.add_attribute("color", "#000000")
      thisnode.add_attribute("type", "line")
      thisnode.add_attribute("width", "1.0")
      shape_node.push(thisnode)


      thisnode = REXML::Element.new("y:NodeLabel")
      thisnode.add_attribute("alignment", "center")
      thisnode.add_attribute("autoSizePolicy", "content")
      thisnode.add_attribute("fontFamily", "Dialog")
      thisnode.add_attribute("fontSize", "12")
      thisnode.add_attribute("fontStyle", "plain")
      thisnode.add_attribute("hasBackgroundColor", "false")
      thisnode.add_attribute("hasLineColor", "false")
      thisnode.add_attribute("height", "17.96875")
      thisnode.add_attribute("horizontalTextPosition", "center")
      thisnode.add_attribute("iconTextGap", "4")
      thisnode.add_attribute("modelName", "internal")
      thisnode.add_attribute("modelPosition", "tr")
      thisnode.add_attribute("textColor", "#000000")
      thisnode.add_attribute("verticalTextPosition", "bottom")
      thisnode.add_attribute("visible", "true")
      thisnode.add_attribute("width", "69.47265625")
      thisnode.add_attribute("x", "60.52734375")
      thisnode.add_attribute("xml:space", "preserve")
      thisnode.add_attribute("y", "4.0")
      value_text = REXML::Text.new(self.getName)
      thisnode.push(value_text)
      shape_node.push(thisnode)

      thisnode = REXML::Element.new("y:NodeLabel")
      thisnode.add_attribute("alignment", "center")
      thisnode.add_attribute("autoSizePolicy", "content")
      thisnode.add_attribute("backgroundColor", "#FFFFFF")
      thisnode.add_attribute("fontFamily", "Dialog")
      thisnode.add_attribute("fontSize", "12")
      thisnode.add_attribute("fontStyle", "bold")
      # thisnode.add_attribute("hasBackgroundColor", "false")
      thisnode.add_attribute("hasLineColor", "false")
      thisnode.add_attribute("height", "17.96875")
      thisnode.add_attribute("horizontalTextPosition", "center")
      thisnode.add_attribute("iconTextGap", "4")
      thisnode.add_attribute("modelName", "custom")
      # thisnode.add_attribute("modelPosition", "tr")
      thisnode.add_attribute("textColor", "#0000FF")
      thisnode.add_attribute("verticalTextPosition", "bottom")
      thisnode.add_attribute("visible", "true")
      thisnode.add_attribute("width", "107.62")
      thisnode.add_attribute("x", "13.19140625")
      thisnode.add_attribute("xml:space", "preserve")
      thisnode.add_attribute("y", "20.956670673077042")
      value_text = REXML::Text.new(self.getMin.to_s + ' < ' + self.getDefaultData.to_s + ' < ' + self.getMax.to_s)
      thisnode.push(value_text)

=begin
            <y:LabelModel>
              <y:SmartNodeLabelModel distance="4.0"/>
            </y:LabelModel>
            <y:ModelParameter>
              <y:SmartNodeLabelModelParameter labelRatioX="0.0" labelRatioY="0.5" nodeRatioX="0.0" nodeRatioY="0.3462047972408028" offsetX="0.0" offsetY="0.0" upX="0.0" upY="-1.0"/>
            </y:ModelParameter>
=end


      thissubnode = REXML::Element.new("y:LabelModel")
      thissubnsubode = REXML::Element.new("y:SmartNodeLabelModel")
      thissubnsubode.add_attribute("distance", "4.0")
      thissubnode.push(thissubnsubode)
      thisnode.push(thissubnode)

      thissubnode = REXML::Element.new("y:ModelParameter")
      thissubnsubode = REXML::Element.new("y:SmartNodeLabelModelParameter")
      thissubnsubode.add_attribute("labelRatioX", "0.0")
      thissubnsubode.add_attribute("labelRatioY", "0.5")
      thissubnsubode.add_attribute("nodeRatioX", "0.0")
      thissubnsubode.add_attribute("nodeRatioY", "0.3462047972408028")
      thissubnsubode.add_attribute("offsetX", "0.0")
      thissubnsubode.add_attribute("offsetY", "0.0")
      thissubnsubode.add_attribute("upX", "0.0")
      thissubnsubode.add_attribute("upY", "1.0")
      thissubnode.push(thissubnsubode)
      thisnode.push(thissubnode)

      shape_node.push(thisnode)


      thisnode = REXML::Element.new("y:Shape")
      thisnode.add_attribute("type", "parallelogram")
      shape_node.push(thisnode)

      content_node.push(shape_node)

    end

  end
end
PORISValueFloat.send(:include, PORISValueFloatGraphMLPatch)


######### PORISMode #################

module PORISModeGraphMLPatch
  def self.included(base)
    base.extend(ClassMethods)

    base.send(:include , InstanceMethods)

    base.class_eval do
    end
  end

  module ClassMethods

    # Creates the object instance from an GraphML node
    def fromGraphML(n_node, pdoc)
      ret = super(n_node, pdoc)
      if ret != nil then
        ret.class = PORISMode
        # TODO: Parse these values
        ret.values = {}
        ret.submodes = {}
        ret.default_value = nil

        dest_node = n_node.get_elements_by_tag_name("destinations")[0]
        # puts "destnode: #{dest_node.local_name}"
        dest = nil
        # puts ret.getName
        dest_node.child_nodes.each do |d|
          if d.local_name == "destination"
            # puts "d.localname: #{d.local_name}"
            dest = PORIS.fromGraphMLRef(d, pdoc)
            # puts "d: #{dest.getName}"
            if dest
              if dest.is_a?(PORISValue)
                # Let's see the destinations to know if it is a PORISSys or a PORISParam
                ret.addValue(dest)
                # puts ret.values
              end

              if dest.is_a?(PORISMode)
                # Let's see the destinations to know if it is a PORISSys or a PORISParam
                ret.add_sub_mode(dest)
                # puts ret.submodes
              end
            end
          end
        end
      end
      ret
    end

  end

  module InstanceMethods


    # Getter for the GraphML tag name of this item
    def getGraphMLNodeName
      "mode"
    end

    # Getter for the NodeType of this item
    def getGraphMLNodeType
      6
    end

    # Dumps item to GraphML, uses super().toGraphML and
    # appends specific nodes for this class
    def addGraphMLShapeToNode(dom, content_node)

      shape_node = REXML::Element.new("y:ShapeNode")

      thisnode = REXML::Element.new("y:Geometry")
      thisnode.add_attribute("height", "30.0")
      thisnode.add_attribute("width", "65.0")
      thisnode.add_attribute("x", "289.0")
      thisnode.add_attribute("y", "782.0")
      shape_node.push(thisnode)

      thisnode = REXML::Element.new("y:Fill")
      thisnode.add_attribute("color", "#FFCC00")
      thisnode.add_attribute("transparent", "false")
      shape_node.push(thisnode)

      thisnode = REXML::Element.new("y:BorderStyle")
      thisnode.add_attribute("color", "#000000")
      thisnode.add_attribute("type", "line")
      thisnode.add_attribute("width", "1.0")
      shape_node.push(thisnode)

      thisnode = REXML::Element.new("y:NodeLabel")
      thisnode.add_attribute("alignment", "center")
      thisnode.add_attribute("autoSizePolicy", "content")
      thisnode.add_attribute("fontFamily", "Dialog")
      thisnode.add_attribute("fontSize", "12")
      thisnode.add_attribute("fontStyle", "plain")
      thisnode.add_attribute("hasBackgroundColor", "false")
      thisnode.add_attribute("hasLineColor", "false")
      thisnode.add_attribute("height", "17.96875")
      thisnode.add_attribute("horizontalTextPosition", "center")
      thisnode.add_attribute("iconTextGap", "4")
      thisnode.add_attribute("modelName", "internal")
      thisnode.add_attribute("modelPosition", "c")
      thisnode.add_attribute("textColor", "#000000")
      thisnode.add_attribute("verticalTextPosition", "bottom")
      thisnode.add_attribute("visible", "true")
      thisnode.add_attribute("width", "47.37109375")
      thisnode.add_attribute("x", "8.814453125")
      thisnode.add_attribute("xml:space", "preserve")
      thisnode.add_attribute("y", "6.015625")
      value_text = REXML::Text.new(self.getName)
      thisnode.push(value_text)
      shape_node.push(thisnode)

      thisnode = REXML::Element.new("y:Shape")
      thisnode.add_attribute("type", "roundrectangle")
      shape_node.push(thisnode)

      content_node.push(shape_node)

    end

  end
end
PORISMode.send(:include, PORISModeGraphMLPatch)

######### PORISNode #################

module PORISNodeGraphMLPatch
  def self.included(base)
    base.extend(ClassMethods)

    base.send(:include , InstanceMethods)

    base.class_eval do
    end
  end

  module ClassMethods

    # Creates the object instance from an GraphML node
    def executeGraphMLParser(n_node, pdoc)
      typenode = n_node.getElementsByTagName("type")[0]
      t = typenode.firstChild.nodeValue
      if t == "PORISParam"
        return PORISParam.fromGraphML(n_node, pdoc)
      elsif t == "PORISSys"
        return PORISSys.fromGraphML(n_node, pdoc)
      end

      # Let's see the destinations to know if it is a PORISSys or a PORISParam
      namenode = n_node.getElementsByTagName("name")[0]
      name = namenode.firstChild.nodeValue
      # puts "****** Parsing #{t} #{name}"

      destnode = n_node.getElementsByTagName("destinations")[0]
      destnode.children.each do |d|
        if d.nodeType != d.TEXT_NODE
          # puts "Name #{d.xpath}"
          if d.getAttribute("type") == "PORISNode" || d.getAttribute("type") == "PORISSys" || d.getAttribute("type") == "PORISParam"
            # puts "Is a system"
            return PORISSys.fromGraphML(n_node, pdoc)
          end
        end
      end
      # puts "Is a param"
      PORISParam.fromGraphML(n_node, pdoc)
    end

    def fromGraphML(n_node, pdoc)
      ret = super(PORISNode, PORISNode).fromGraphML(n_node, pdoc)
      if ret != nil then
        ret.class = PORISNode
        ret.modes = {}
        ret.selectedMode = nil
        ret.defaultMode = nil

        destnode = n_node.getElementsByTagName("destinations")[0]
        # puts "destnode: #{destnode.xpath}"
        dest = nil
        # puts ret.getName
        destnode.children.each do |d|
          if d.nodeType != d.TEXT_NODE
            dest = PORIS.fromGraphMLRef(d, pdoc)
            # puts "d: #{dest.getName}"
            if dest
              if dest.is_a?(PORISMode)
                # Let's see the destinations to know if it is a PORISSys or a PORISParam
                ret.addMode(dest)
                # puts ret.modes
              end
            end
          end
        end
      end
      ret
    end


  end

  module InstanceMethods

    # Function to obtain the tag name for the current item
    # In GraphML all PORISNodes (no matter if they are systems or params)
    # are <sub-system>
    def getGraphMLNodeName
      "sub-system"
    end

    # Function to obtain the NodeType, overloading super's
    def getGraphMLNodeType
      4
    end

  end
end
PORISNode.send(:include, PORISNodeGraphMLPatch)


######### PORISParam #################

module PORISParamGraphMLPatch
  def self.included(base)
    base.extend(ClassMethods)

    base.send(:include , InstanceMethods)

    base.class_eval do
    end
  end

  module ClassMethods

    def fromGraphML(n_node, pdoc)
      ret = super(n_node, pdoc)
      if ret != nil then
        ret.extend(PORISParam)
        ret.values = {}
        ret.instance_variable_set(:@selected_value, nil)

        destnode = n_node.elements["destinations"]
        destnode.elements.each do |d|
          dest = PORIS.fromGraphMLRef(d, pdoc)
          if dest && dest.is_a?(PORISValue)
            ret.addValue(dest)
          end
        end
      end
      ret
    end

  end

  module InstanceMethods


    def getGraphMLType
      "PORISNode"
    end

    def getGraphMLNodeName
      "sub-system"
    end

  end
end
PORISParam.send(:include, PORISParamGraphMLPatch)


######### PORISSys #################

module PORISSysGraphMLPatch
  def self.included(base)
    base.extend(ClassMethods)

    base.send(:include , InstanceMethods)

    base.class_eval do
    end
  end

  module ClassMethods

    def fromGraphML(n_node, pdoc)
      ret = super(n_node, pdoc)
      if ret != nil then
        ret.class = PORISSys
        ret.params = {}
        ret.subsystems = {}

        destnode = n_node.elements["destinations"]
        destnode.each_element do |d|
          dest = PORIS.fromGraphMLRef(d, pdoc)
          if dest
            if dest.is_a?(PORISParam)
              ret.addParam(dest)
            elsif dest.is_a?(PORISSys)
              ret.addSubsystem(dest)
            end
          end
        end
      end
      ret
    end

  end

  module InstanceMethods

=begin
    <y:ProxyAutoBoundsNode>


    <y:Realizers active="0">
      <y:GroupNode>
        <y:Geometry height="1319.2480096767354" width="1764.9852044160361" x="-504.1733350215851" y="530.11166971383"/>
        <y:Fill color="#FFFFFF" transparent="false"/>
        <y:BorderStyle color="#000000" type="dashed" width="1.0"/>
        <y:NodeLabel alignment="right" autoSizePolicy="node_width" backgroundColor="#EBEBEB" borderDistance="0.0" fontFamily="Dialog" fontSize="15" fontStyle="plain" hasLineColor="false" height="21.4609375" horizontalTextPosition="center" iconTextGap="4" modelName="internal" modelPosition="t" textColor="#000000" verticalTextPosition="bottom" visible="true" width="1764.9852044160361" x="0.0" xml:space="preserve" y="0.0">ARCGenIII</y:NodeLabel>
        <y:Shape type="roundrectangle"/>
        <y:State closed="false" closedHeight="1557.3791055961901" closedWidth="1419.1561391088312" groupDepthFillColorEnabled="false" innerGraphDisplayEnabled="false"/>
        <y:Insets bottom="15" bottomF="15.0" left="15" leftF="15.0" right="15" rightF="15.0" top="15" topF="15.0"/>
        <y:BorderInsets bottom="0" bottomF="0.0" left="0" leftF="0.0" right="0" rightF="0.0" top="0" topF="0.0"/>
      </y:GroupNode>
      <y:GroupNode>
        <y:Geometry height="1557.3791055961901" width="1419.1561391088312" x="-174.00127841182774" y="251.06542882408098"/>
        <y:Fill hasColor="false" transparent="false"/>
        <y:BorderStyle color="#000000" type="dashed" width="1.0"/>
        <y:NodeLabel alignment="right" autoSizePolicy="node_width" backgroundColor="#EBEBEB" borderDistance="0.0" fontFamily="Dialog" fontSize="15" fontStyle="plain" hasLineColor="false" height="21.4609375" horizontalTextPosition="center" iconTextGap="4" modelName="internal" modelPosition="t" textColor="#000000" verticalTextPosition="bottom" visible="true" width="1419.1561391088312" x="0.0" xml:space="preserve" y="0.0">System</y:NodeLabel>
        <y:Shape type="roundrectangle"/>
        <y:State closed="true" closedHeight="1557.3791055961901" closedWidth="1419.1561391088312" innerGraphDisplayEnabled="false"/>
        <y:Insets bottom="15" bottomF="15.0" left="15" leftF="15.0" right="15" rightF="15.0" top="15" topF="15.0"/>
        <y:BorderInsets bottom="0" bottomF="0.0" left="0" leftF="0.0" right="0" rightF="0.0" top="0" topF="0.0"/>
      </y:GroupNode>
    </y:Realizers>


    </y:ProxyAutoBoundsNode>

=end
    def addGraphMLShapeToNode(dom, content_node)


      shape_node = REXML::Element.new("y:ProxyAutoBoundsNode")

      this_realizers = REXML::Element.new("y:Realizers")
      this_realizers.add_attribute("active", "0")

      this_group = REXML::Element.new("y:GroupNode")

      thisnode = REXML::Element.new("y:Geometry")
      thisnode.add_attribute("height", "1319.0")
      thisnode.add_attribute("width", "1764.0")
      thisnode.add_attribute("x", "-504.0")
      thisnode.add_attribute("y", "530.0")
      this_group.push(thisnode)

      thisnode = REXML::Element.new("y:Fill")
      thisnode.add_attribute("color", "#FFFFFF")
      thisnode.add_attribute("transparent", "false")
      this_group.push(thisnode)

      thisnode = REXML::Element.new("y:BorderStyle")
      thisnode.add_attribute("color", "#000000")
      thisnode.add_attribute("type", "dashed")
      thisnode.add_attribute("width", "1.0")
      this_group.push(thisnode)

      thisnode = REXML::Element.new("y:NodeLabel")
      thisnode.add_attribute("alignment", "right")
      thisnode.add_attribute("autoSizePolicy", "node_width")
      thisnode.add_attribute("backgroundColor", "#EBEBEB")
      thisnode.add_attribute("borderDistance", "0.0")
      thisnode.add_attribute("fontFamily", "Dialog")
      thisnode.add_attribute("fontSize", "15")
      thisnode.add_attribute("fontStyle", "plain")
      thisnode.add_attribute("hasBackgroundColor", "false")
      thisnode.add_attribute("hasLineColor", "false")
      thisnode.add_attribute("height", "21.96875")
      thisnode.add_attribute("horizontalTextPosition", "center")
      thisnode.add_attribute("iconTextGap", "4")
      thisnode.add_attribute("modelName", "internal")
      thisnode.add_attribute("modelPosition", "t")
      thisnode.add_attribute("textColor", "#000000")
      thisnode.add_attribute("verticalTextPosition", "bottom")
      thisnode.add_attribute("visible", "true")
      thisnode.add_attribute("width", "1764.37109375")
      thisnode.add_attribute("x", "0.0")
      thisnode.add_attribute("xml:space", "preserve")
      thisnode.add_attribute("y", "0.0")
      value_text = REXML::Text.new(self.getName)
      thisnode.push(value_text)
      this_group.push(thisnode)

      thisnode = REXML::Element.new("y:Shape")
      thisnode.add_attribute("type", "roundrectangle")
      this_group.push(thisnode)

      thisnode = REXML::Element.new("y:State")
      thisnode.add_attribute("closed", "false")
      thisnode.add_attribute("closedHeight", "1557.3791055961901")
      thisnode.add_attribute("closedWidth", "1419.3791055961901")
      thisnode.add_attribute("groupDepthFillColorEnabled", "false")
      thisnode.add_attribute("innerGraphDisplayEnabled", "false")
      this_group.push(thisnode)

      thisnode = REXML::Element.new("y:Insets")
      thisnode.add_attribute("bottom", "15")
      thisnode.add_attribute("bottomF", "15.0")
      thisnode.add_attribute("left", "15")
      thisnode.add_attribute("leftF", "15.0")
      thisnode.add_attribute("right", "15")
      thisnode.add_attribute("rightF", "15.0")
      thisnode.add_attribute("top", "15")
      thisnode.add_attribute("topF", "15.0")
      this_group.push(thisnode)

      thisnode = REXML::Element.new("y:BorderInsets")
      thisnode.add_attribute("bottom", "0")
      thisnode.add_attribute("bottomF", "0.0")
      thisnode.add_attribute("left", "0")
      thisnode.add_attribute("leftF", "0.0")
      thisnode.add_attribute("right", "0")
      thisnode.add_attribute("rightF", "0.0")
      thisnode.add_attribute("top", "0")
      thisnode.add_attribute("topF", "0.0")
      this_group.push(thisnode)


      this_realizers.push(this_group)

      this_group = REXML::Element.new("y:GroupNode")

       thisnode = REXML::Element.new("y:Geometry")
      thisnode.add_attribute("height", "1557.0")
      thisnode.add_attribute("width", "1419.0")
      thisnode.add_attribute("x", "-174.0")
      thisnode.add_attribute("y", "251.0")
      this_group.push(thisnode)

      thisnode = REXML::Element.new("y:Fill")
      thisnode.add_attribute("hasColor", "false")
      thisnode.add_attribute("transparent", "false")
      this_group.push(thisnode)

      thisnode = REXML::Element.new("y:BorderStyle")
      thisnode.add_attribute("color", "#000000")
      thisnode.add_attribute("type", "dashed")
      thisnode.add_attribute("width", "1.0")
      this_group.push(thisnode)

      thisnode = REXML::Element.new("y:NodeLabel")
      thisnode.add_attribute("alignment", "right")
      thisnode.add_attribute("autoSizePolicy", "node_width")
      thisnode.add_attribute("backgroundColor", "#EBEBEB")
      thisnode.add_attribute("borderDistance", "0.0")
      thisnode.add_attribute("fontFamily", "Dialog")
      thisnode.add_attribute("fontSize", "15")
      thisnode.add_attribute("fontStyle", "plain")
      thisnode.add_attribute("hasLineColor", "false")
      thisnode.add_attribute("height", "21.96875")
      thisnode.add_attribute("horizontalTextPosition", "center")
      thisnode.add_attribute("iconTextGap", "4")
      thisnode.add_attribute("modelName", "internal")
      thisnode.add_attribute("modelPosition", "t")
      thisnode.add_attribute("textColor", "#000000")
      thisnode.add_attribute("verticalTextPosition", "bottom")
      thisnode.add_attribute("visible", "true")
      thisnode.add_attribute("width", "1419.37109375")
      thisnode.add_attribute("x", "0.0")
      thisnode.add_attribute("xml:space", "preserve")
      thisnode.add_attribute("y", "0.0")
      value_text = REXML::Text.new(self.getName)
      thisnode.push(value_text)
      this_group.push(thisnode)

      thisnode = REXML::Element.new("y:Shape")
      thisnode.add_attribute("type", "roundrectangle")
      this_group.push(thisnode)

      thisnode = REXML::Element.new("y:State")
      thisnode.add_attribute("closed", "true")
      thisnode.add_attribute("closedHeight", "1557.3791055961901")
      thisnode.add_attribute("closedWidth", "1419.3791055961901")
      thisnode.add_attribute("innerGraphDisplayEnabled", "false")
      this_group.push(thisnode)

      thisnode = REXML::Element.new("y:Insets")
      thisnode.add_attribute("bottom", "15")
      thisnode.add_attribute("bottomF", "15.0")
      thisnode.add_attribute("left", "15")
      thisnode.add_attribute("leftF", "15.0")
      thisnode.add_attribute("right", "15")
      thisnode.add_attribute("rightF", "15.0")
      thisnode.add_attribute("top", "15")
      thisnode.add_attribute("topF", "15.0")
      this_group.push(thisnode)

      thisnode = REXML::Element.new("y:BorderInsets")
      thisnode.add_attribute("bottom", "0")
      thisnode.add_attribute("bottomF", "0.0")
      thisnode.add_attribute("left", "0")
      thisnode.add_attribute("leftF", "0.0")
      thisnode.add_attribute("right", "0")
      thisnode.add_attribute("rightF", "0.0")
      thisnode.add_attribute("top", "0")
      thisnode.add_attribute("topF", "0.0")
      this_group.push(thisnode)


      this_realizers.push(this_group)
      shape_node.push(this_realizers)
      content_node.push(shape_node)


    end

    def getGraphMLType
      "PORISNode"
    end

    def getGraphMLNodeName
      "sub-system"
    end

  end
end
PORISSys.send(:include, PORISSysGraphMLPatch)


######### PORISDoc #################

module PORISDocGraphMLPatch
  def self.included(base)
    base.extend(ClassMethods)

    base.send(:include , InstanceMethods)

    base.class_eval do
    end
  end

  module ClassMethods
  end

  module InstanceMethods


    def toGraphML
      xmlDocument = REXML::Document.new
      xmlInstr = xmlDocument.add_element("poris", "id" => "systems")

      consistent_list = getConsistentReferencesSortedIdsList
      consistent_list.each do |id|
        n = @item_dict[id.to_s]
        # puts("--> " + n.getName)
        n_node = n.toGraphML(xmlDocument)
        xmlInstr.push(n_node) if n_node
      end
      #xmlDocument.add_element(xmlInstr)
      xmlDocument
    end

    def fromGraphML(doc)
      ret = false
      rootnode = doc.root
      if rootnode && rootnode.name == "poris"
        rootnode.elements.each do |ch|
          case ch.name
          when "poris-mode"
          when "mode"
            md = PORISMode.fromGraphML(ch, self)
          when "poris-node"
          when "sub-system"
            md = PORISNode.executeGraphMLParser(ch, self)
          when "poris-value"
          when "value"
            md = PORISValue.fromGraphML(ch, self)
          when "poris-value-float"
          when "value-double-range"
            md = PORISValueFloat.fromGraphML(ch, self)
          when "poris-sys"
            md = PORISSys.fromGraphML(ch, self)
          when "poris-param"
            md = PORISParam.fromGraphML(ch, self)
          when "poris-value-string"
          when "value-string"
            md = PORISValueString.fromGraphML(ch, self)
          when "poris-value-date"
          when "value-date"
            md = PORISValueDate.fromGraphML(ch, self)
          when "poris-value-file-path"
          when "value-file-path"
            md = PORISValueFilePath.fromGraphML(ch, self)
          end
        end
      end

      ret
    end

  end
end
PORISDoc.send(:include, PORISDocGraphMLPatch)

=begin
######### $C1 #################

module $C1GraphMLPatch
  def self.included(base)
    base.extend(ClassMethods)

    base.send(:include , InstanceMethods)

    base.class_eval do
    end
  end

  module ClassMethods
  end

  module InstanceMethods

  end
end
$C1.send(:include, $C1GraphMLPatch)
=end
