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

    # Dumps the current item to an GraphML node
    # PORIS items, after calling this function using super().toGraphML(doc),
    # will add additional nodes which will depend on the class
    def toGraphML(dom)
      # Tag name will be normally the class name, but it can be overloaded
      # so we use a function to get it
      n_node = REXML::Element.new(getGraphMLNodeName)

      # subnode with the name of the item
      name_child = REXML::Element.new("name")
      value_text = REXML::Text.new(getName)
      name_child.push(value_text)
      n_node.push(name_child)

      # subnode with an identifying integer
      id_child = REXML::Element.new("id")
      id_child.add_attribute("type", "integer")
      value_text = REXML::Text.new(@id.to_s)
      id_child.push(value_text)
      n_node.push(id_child)

      # subnode with the type
      nodetype_child = REXML::Element.new("type")
      value_text = REXML::Text.new(getGraphMLType)
      nodetype_child.push(value_text)
      n_node.push(nodetype_child)

      # subnode with the node type id
      nodetype_child = REXML::Element.new("node-type-id")
      nodetype_child.add_attribute("type", "integer")
      value_text = REXML::Text.new(getGraphMLNodeType.to_s)
      nodetype_child.push(value_text)
      n_node.push(nodetype_child)

      # subnode with an identifying string
      ident_child = REXML::Element.new("ident")
      if (@ident == nil)
        # Engineering modes, unknown modes, and unknown values have no ident
        @ident = "VIRT-"+self.getId.to_s
      end
      value_text = REXML::Text.new(@ident)
      ident_child.push(value_text)
      n_node.push(ident_child)

      # subnode with the project id
      nodetype_child = REXML::Element.new("project-id")
      nodetype_child.add_attribute("type", "integer")
      value_text = REXML::Text.new(getProjectId.to_s)
      nodetype_child.push(value_text)
      n_node.push(nodetype_child)

      # array of labels
      lbs = getLabels
      labels_child = REXML::Element.new("labels")
      labels_child.add_attribute("type", "array")
      lbs.each do |l, caption|
        # Each label is an entry in the labels dict
        # The value is the caption, which shall
        # be published under the "name" tag
        l_node = REXML::Element.new("label")
        name_node = REXML::Element.new("name")
        value_text = REXML::Text.new(caption)
        name_node.push(value_text)
        l_node.push(name_node)
        # The scope_kind is the key, which shall
        # be published under the scope-kind tag
        scope_node = REXML::Element.new("scope-kind")
        sk_name_node = REXML::Element.new("name")
        value_text = REXML::Text.new(l)
        sk_name_node.push(value_text)
        scope_node.push(sk_name_node)
        l_node.push(scope_node)
        labels_child.push(l_node)
      end

      n_node.push(labels_child)

      # array of destinations, containing their GraphML references
      destinations_node = REXML::Element.new("destinations")
      destinations_node.add_attribute("type", "array")
      dests = getDestinations
      dests.each do |d|
        dest_node = REXML::Element.new("destination")
        dest_node.add_attribute("type", d.getGraphMLType)
        dest_node.push(d.toGraphMLRef(dom))
        destinations_node.push(dest_node)
      end

      n_node.push(destinations_node)

      # array of node attributes
      nats = getNodeAttributes
      node_attributes_child = REXML::Element.new("node-attributes")
      node_attributes_child.add_attribute("type", "array")
      nats.each do |l, attr|
        # Each label is an entry in the labels dict
        # The value is the caption, which shall
        # be published under the "name" tag
        nat_node = REXML::Element.new("node-attribute")

        content_node = REXML::Element.new("content")
        value_text = REXML::Text.new(attr["content"])
        content_node.push(value_text)
        nat_node.push(content_node)

        name_node = REXML::Element.new("name")
        value_text = REXML::Text.new(l)
        name_node.push(value_text)
        nat_node.push(name_node)

        vis_node = REXML::Element.new("visibility")
        vis_node.add_attribute("type", "boolean")
        value_text = REXML::Text.new(attr["visibility"] ? "true" : "false")
        vis_node.push(value_text)
        nat_node.push(vis_node)

        node_attributes_child.push(nat_node)
      end

      n_node.push(node_attributes_child)

      # PORIS items, after calling this function using super().toGraphML(doc),
      # will add additional nodes which will depend on the class

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

    # Dumps the item's GraphML (uses PORIS superclass' one and appends information of the formatter)
    def toGraphML(dom)
      # puts(dom)
      # puts("toGraphML self ", self.getName)
      # puts("toGraphML super ", super.getName)
      n_node = super(dom)
      n_node.add_element(getGraphMLFormatter.toGraphMLRef(dom))
      n_node
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

    # Dumps item to GraphML, uses super().toGraphML and
    # appends specific nodes for this class
    def toGraphML(dom)
      n_node = super(dom)

      defaultstringnode = REXML::Element.new("default-string")
      valueText = REXML::Text.new(getDefaultData)
      defaultstringnode.push(valueText)
      n_node.add_element(defaultstringnode)

      n_node
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

    # Dumps item to GraphML, uses super().toGraphML and
    # appends specific nodes for this class
    def toGraphML(dom)
      n_node = super(dom)

      extnode = REXML::Element.new("file-extension")
      valueText = REXML::Text.new(@file_ext)
      extnode.push(valueText)
      n_node.add_element(extnode)

      descnode = REXML::Element.new("file-description")
      valueText = REXML::Text.new(@file_desc)
      descnode.push(valueText)
      n_node.add_element(descnode)

      n_node
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

    # Dumps item to GraphML, uses super().toGraphML and
    # appends specific nodes for this class
    def toGraphML(dom)
      n_node = super(dom)

      minnode = REXML::Element.new("date-min")
      minnode.add_attribute("type", "timestamp")
      valueText = REXML::Text.new(@min_date)
      minnode.push(valueText)
      n_node.add_element(minnode)

      maxnode = REXML::Element.new("date-max")
      maxnode.add_attribute("type", "timestamp")
      valueText = REXML::Text.new(@max_date)
      maxnode.push(valueText)
      n_node.add_element(maxnode)

      defaultstringnode = REXML::Element.new("default-date")
      defaultstringnode.add_attribute("type", "timestamp")
      valueText = REXML::Text.new(getDefaultData)
      defaultstringnode.push(valueText)
      n_node.add_element(defaultstringnode)

      n_node
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
    def toGraphML(dom)
      n_node = super(dom)

      defaultfloatnode = REXML::Element.new("default-float")
      defaultfloatnode.add_attribute("type", "float")
      valueText = REXML::Text.new(getDefaultData.to_s)
      defaultfloatnode.push(valueText)
      n_node.add_element(defaultfloatnode)

      rangeminnode = REXML::Element.new("rangemin")
      rangeminnode.add_attribute("type", "float")
      valueText = REXML::Text.new(getMin.to_s)
      rangeminnode.push(valueText)
      n_node.add_element(rangeminnode)

      rangemaxnode = REXML::Element.new("rangemax")
      rangemaxnode.add_attribute("type", "float")
      valueText = REXML::Text.new(getMax.to_s)
      rangemaxnode.push(valueText)
      n_node.add_element(rangemaxnode)

      n_node
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

    # Dumps the GraphML node from this PORISMode
    def toGraphML(dom)
      n_node = super(dom)
      # TODO: Think if it makes sense to have a default submode???
      default_mode_node = REXML::Element.new("default-mode-id")
      default_mode_node.add_attribute("type", "integer")
      default_mode_node.add_attribute("nil", "true")
      n_node.push(default_mode_node)
      default_value_node = REXML::Element.new("default-value-id")
      default_value_node.add_attribute("type", "integer")
      v = self.getDefaultValue
      if v.nil?
        default_value_node.add_attribute("nil", "true")
      else
        default_value_text = REXML::Text.new(v.getId.to_s)
        default_value_node.push(default_value_text) if default_value_text
      end
      n_node.push(default_value_node)

      n_node
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

    # Dump GraphML from this item.  Appends default mode
    # to super's GraphML
    # TODO: At the moment we have not selected default modes
    def toGraphML(dom)

      # <default-mode-id type="integer" nil="true"/>
      n_node = super(dom)
      defaultmodenode = REXML::Element.new("default-mode-id")
      defaultmodenode.add_attribute("type", "integer")
      # WARNING: It looks like the java panel is not correctly using default mode

      m = getDefaultMode
      if m.nil?
        defaultmodenode.add_attribute("nil", "true")
      else
        defaultmodetext = REXML::Text.new(m.getId.to_s)
        if defaultmodetext
          defaultmodenode.push(defaultmodetext)
        else
          puts "Error creating a text node for the default value of the #{getName} mode"
          raise "Assertion failed"
        end
      end
      n_node.push(defaultmodenode)
      n_node
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

    def toGraphML(doc)
      n_node = super(doc)
      childnode = REXML::Element.new("default-value-id")
      childnode.add_attribute("type", "integer")
      childnode.add_attribute("nil", "true")
      n_node.push(childnode)
      n_node
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
