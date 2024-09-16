require 'rexml/document'
require 'date'
require 'tzinfo'

debug = false


def nametoidl(n)
  ret = n.gsub("(", "_")
  ret = ret.gsub(")", "_")
  ret = ret.gsub("Ñ", "NY")
  ret = ret.gsub(".", "_")
  ret = ret.gsub("+", "p")
  ret = ret.gsub("/", "_")
  ret = ret.gsub("¿", "_")
  ret = ret.gsub("?", "_")
  ret = ret.gsub("-", "_")
  ret = ret.gsub("á", "a")
  ret = ret.gsub("é", "e")
  ret = ret.gsub("í", "i")
  ret = ret.gsub("ó", "o")
  ret = ret.gsub("ú", "u")
  ret = ret.gsub("Á", "A")
  ret = ret.gsub("É", "E")
  ret = ret.gsub("Í", "I")
  ret = ret.gsub("Ó", "O")
  ret = ret.gsub("Ú", "U")
  ret = ret.gsub("ñ", "ny")

  if ret.downcase == "sequence"
    ret += "b"
  end

  ret
end

############################### PORIS subtype classes (not PORIS items) #########################################

############################### PORIS Formatters #########################################

#######################################

class PORISValueFormatter
  @@instances = {}

  attr_reader :name, :id, :label

  def initialize(name, id, label)
    @name = name
    @id = id
    @label = label
    @@instances[id.to_s] = self
  end

  def toXMLRef(dom)
    n_node = REXML::Element.new('value-formatter-id')
    n_node.add_attribute('type', 'integer')
    if @id
      value_text = REXML::Text.new(@id.to_s)
      n_node.add_text(value_text)
    else
      n_node.add_attribute('nil', 'true')
    end
    n_node
  end

  def self.fromXMLRef(n_node)
    idnode = n_node.elements['value-formatter-id']
    idnode.each_element do |t|
      if t.text?
        @@instances[t.text]
      end
    end
    nil
  end
end

class PORISValueDateFormatter < PORISValueFormatter
  DATE_FORMAT_STRING = "%d.%m.%Y %H:%M:%S %z"

  def getValue(str_value, format = DATE_FORMAT_STRING)
    DateTime.strptime(str_value, format)
  end

  def getString(value, format = DATE_FORMAT_STRING)
    value.strftime(format)
  end
end

class PORISValueDoubleFormatter < PORISValueFormatter
  def getValue(str_value, nospecifictreatment = false)
    str_value.to_f
  end

  def getString(value, nospecifictreatment = false)
    value.to_s
  end
end

class PORISValueDMSFormatter < PORISValueDoubleFormatter
  def getValue(str_value, nospecifictreatment = false)
    if nospecifictreatment
      super
    else
      str_value.to_f
    end
  end

  def getString(value, nospecifictreatment = false)
    if nospecifictreatment
      super
    else
      value.to_s
    end
  end
end

class PORISValueHMSFormatter < PORISValueDoubleFormatter
  def getValue(str_value, nospecifictreatment = false)
    if nospecifictreatment
      super
    else
      str_value.to_f
    end
  end

  def getString(value, nospecifictreatment = false)
    if nospecifictreatment
      super
    else
      value.to_s
    end
  end
end

class PORISValueIntegerFormatter < PORISValueDoubleFormatter
  def getValue(str_value, nospecifictreatment = false)
    if nospecifictreatment
      super
    else
      str_value.to_i
    end
  end

  def getString(value, nospecifictreatment = false)
    if nospecifictreatment
      super
    else
      value.to_s
    end
  end
end

class PORISValueArcMinFormatter < PORISValueDoubleFormatter
end

class PORISValueArcSecFormatter < PORISValueDoubleFormatter
end

### Create singletons

PORISVALUEFORMATTER_NIL = PORISValueFormatter.new("nil", nil, nil)
PORISVALUEFORMATTER_DOUBLE = PORISValueFormatter.new("double", 0, nil)
PORISVALUEFORMATTER_REAL = PORISValueDoubleFormatter.new("real", 1, "real")
PORISVALUEFORMATTER_HMS = PORISValueHMSFormatter.new("HH:mm:ss.sss", 2, "HH:mm:ss.sss")
PORISVALUEFORMATTER_DMS = PORISValueDMSFormatter.new("DD:mm:ss.sss", 3, "DD:mm:ss.sss")
PORISVALUEFORMATTER_ANGLE = PORISValueDoubleFormatter.new("angle", 4, "angle")
PORISVALUEFORMATTER_S = PORISValueDoubleFormatter.new("s", 5, "s")
PORISVALUEFORMATTER_DATE = PORISValueDateFormatter.new("Date", 6, "dd.MM.yyyy HH:mm:ss z")
PORISVALUEFORMATTER_INTEGER = PORISValueIntegerFormatter.new("integer", 7, "#")
PORISVALUEFORMATTER_ARCMIN = PORISValueArcMinFormatter.new("arcmin", 8, "arcmin")
PORISVALUEFORMATTER_ARCSEC = PORISValueArcSecFormatter.new("arcmin", 9, "arcsec")

############################### PORIS item classes ############################################################

####################################################
# This class is referenced in advance, to prevent
# circular definition errors

####################################################
# This is the base class for the PORIS items
# contains the common attributes and functions
# subclasses overload them when convenient
class PORIS
  # Constructor, needs a name for the PORIS item
  def initialize(name)
    # puts "Creating PORIS instance name #{name}"
    # Public attributes
    @id = nil               # A numeric id for reference
    @ident = nil            # A text id for reference
    @description = nil      # A description of the item
    @document = nil
    # Private attributes
    @name = name           # name
    @parent = nil         # Parent node (if any)
    @labels = {}           # A dictionary of labels for this item, the scope_kind acts as a key
    @node_attributes = {}  # A dictionary of node attributes for this item, the content acts as a key
    @project_id = 0 # The project where the item is described
  end

  # Name getter
  def getName
    @name
  end

  # Name setter
  def setName(name)
    @name = name
  end

  # id getter
  def getId
    @id
  end

  # id setter
  def setId(id)
    @id = id
  end

  # ident getter
  def getIdent
    @ident
  end

  # ident setter
  def setIdent(ident)
    @ident = ident
  end

  # document getter
  def getDocument
    @document
  end

  # document setter
  def setDocument(document)
    @document = document
  end

  # description getter
  def getDescription
    @description
  end

  # description setter
  def setDescription(description)
    @description = description
  end

  # Parent getter
  def setParent(parent)
    @parent = parent
  end

  # Parent setter
  def getParent
    @parent
  end

  # Project ID getter
  def getProjectId
    @project_id
  end

  # Project ID setter
  def setProjectId(i)
    @project_id = i
  end

  # Labels list getter
  def getLabels
    @labels
  end

  # Function for adding a label to the labels list.
  # caption is the string to show within a context
  # scope_kind is an identifier of the context where the caption applies
  def setLabel(caption, scope_kind)
    @labels[scope_kind] = caption
  end

  # Labels list getter
  def getNodeAttributes
    @node_attributes
  end

  # Function for setting a node attribute to the node attributes list.
  # name is the string to show as the caption and identifier of the attribute
  # it can also include units
  # content is the value of the attribute
  # visibility is a flag which determines if the attribute shall be shown to end users, or kept hidden for them
  def setNodeAttribute(name, content, visibility)
    @node_attributes[name] = { "content" => content, "visibility" => visibility }
  end

  # Getter for the destinations of this item
  # It will be overloaded by subclasses
  def getDestinations
    []
  end

  ########## XML related functions ########

  # Getter for the node name (tag name) which depends of the class.
  # It will be overloaded by subclasses
  def getXMLNodeName
    "none"
  end

  # Getter for the nodetype which depends of the class.
  # It will be overloaded by subclasses
  def getXMLNodeType
    0
  end

  # Getter for the type which depends of the class, by default is the class name
  # It can overloaded by subclasses.
  def getXMLType
    self.class.name
  end

  # Builds a reference for the item, to be used mainly inside the "destination" tag
  def toXMLRef(dom)
    ret = REXML::Element.new('id')
    ret.add_attribute("type", "integer")
    value_text = REXML::Text.new(@id.to_s)
    ret.push(value_text)
    ret
  end

  # Recovers the id of the item from a reference
  def self.fromXMLRef(n_node, pdoc)
    # puts "destination_node: #{n_node.xpath}"
    idnode = n_node.getElementsByTagName('id')[0]
    if idnode.firstChild.nodeType == idnode.TEXT_NODE
      return pdoc.get_item(idnode.firstChild.nodeValue.to_i)
    end
    nil
  end

  # Dumps the current item to an XML node
  # PORIS items, after calling this function using super().toXML(doc),
  # will add additional nodes which will depend on the class
  def toXML(dom)
    # Tag name will be normally the class name, but it can be overloaded
    # so we use a function to get it
    n_node = REXML::Element.new(getXMLNodeName)

    # subnode with the name of the item
    name_child = REXML::Element.new('name')
    value_text = REXML::Text.new(getName)
    name_child.push(value_text)
    n_node.push(name_child)

    # subnode with an identifying integer
    id_child = REXML::Element.new('id')
    id_child.add_attribute("type", "integer")
    value_text = REXML::Text.new(@id.to_s)
    id_child.push(value_text)
    n_node.push(id_child)

    # subnode with the type
    nodetype_child = REXML::Element.new('type')
    value_text = REXML::Text.new(getXMLType)
    nodetype_child.push(value_text)
    n_node.push(nodetype_child)

    # subnode with the node type id
    nodetype_child = REXML::Element.new('node-type-id')
    nodetype_child.add_attribute("type", "integer")
    value_text = REXML::Text.new(getXMLNodeType.to_s)
    nodetype_child.push(value_text)
    n_node.push(nodetype_child)

    # subnode with an identifying string
    ident_child = REXML::Element.new('ident')
    value_text = REXML::Text.new(@ident)
    ident_child.push(value_text)
    n_node.push(ident_child)

    # subnode with the project id
    nodetype_child = REXML::Element.new('project-id')
    nodetype_child.add_attribute("type", "integer")
    value_text = REXML::Text.new(getProjectId.to_s)
    nodetype_child.push(value_text)
    n_node.push(nodetype_child)

    # array of labels
    lbs = getLabels
    labels_child = REXML::Element.new('labels')
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

    # array of destinations, containing their XML references
    destinations_node = REXML::Element.new('destinations')
    destinations_node.add_attribute("type", "array")
    dests = getDestinations
    dests.each do |d|
      dest_node = REXML::Element.new('destination')
      dest_node.add_attribute("type", d.getXMLType)
      dest_node.push(d.toXMLRef(dom))
      destinations_node.push(dest_node)
    end

    n_node.push(destinations_node)

    # array of node attributes
    nats = getNodeAttributes
    node_attributes_child = REXML::Element.new('node-attributes')
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

    # PORIS items, after calling this function using super().toXML(doc),
    # will add additional nodes which will depend on the class

    n_node
  end

  # Creates the object instance from an XML node
  def self.fromXML(n_node, pdoc)
    name = nil
    ident = nil
    nats_node = nil
    labs_node = nil
    n_node.children.each do |e|
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
                  this_nat['content'] = c.nodeValue
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
                  this_nat['visibility'] = (c.nodeValue == "true")
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
    ret
  end

  def getRubyName
    nametoidl(self.getName)
  end

  def getRubyAccessor
    "#{self.class.getRubyPrefix}#{self.getRubyName}"
  end

  def getRubyIdent
    "@#{getRubyAccessor}"
  end

  def self.getRubyPrefix
    "ERROR_NODE"
  end

  def self.getRubyFuncParticle
    "ERROR_NODE"
  end

  def getRubyConstructorString
    "#{self.class.name}.new('#{self.getRubyName}')"
  end

  def toRuby

    ret = {}
=begin

    @prShuffleLines = PORISParam.new("ShuffleLines")
    self.addItem(@prShuffleLines)
    @prShuffleLines.setIdent("ARC-0080")
    @prShuffleLines.setDescription("")
=end

    thisident = self.getRubyIdent

    ret['attributes'] = "\tattr_reader :#{self.getRubyAccessor}\n"
    ret['constructor'] = "\t\t#{thisident} = #{getRubyConstructorString}\n"
    # ret['constructor'] = ("Entramos por aquí PORIS!!!" + self.getName + " " + self.class.name + "\n")
    ret['constructor'] += "\t\tself.addItem(#{thisident})\n"
    ret['constructor'] += "\t\t#{thisident}.setIdent('#{self.getIdent}')\n"
    ret['constructor'] += "\t\t#{thisident}.setDescription('#{self.getDescription}')\n"

=begin

    ## prParam ShuffleLines

    def get_ShuffleLinesNode
        @prShuffleLines
	  end

    def get_ShuffleLines
        @prShuffleLines.getSelectedValue
	  end
=end

    ret['destinations'] = ""

    ret['functions'] = "\t## #{self.class.getRubyPrefix}#{self.class.getRubyFuncParticle} #{self.getRubyName}\n\n"
    ret['functions'] += "\tdef get_#{self.getRubyName}Node\n"
    ret['functions'] += "\t\t#{thisident}\n"
    ret['functions'] += "\tend\n"

    return ret
  end
end



require 'rexml/document'

class PORISValue < PORIS
  def initialize(name)
    super(name)
    @__formatter = PORISVALUEFORMATTER_NIL
  end

  ########## XML related functions ########

  # the tag name will be "value", but subclasses
  # might overload it
  def getXMLNodeName
    "value"
  end

  # getter for the node type (overloading PORIS one)
  def getXMLNodeType
    5
  end

  def getXMLFormatter
    @__formatter
  end

  def setXMLFormatter(formatter)
    @__formatter = PORISVALUEFORMATTER_NIL
  end

  # Dumps the item's XML (uses PORIS superclass' one and appends information of the formatter)
  def toXML(dom)
    # puts(dom)
    # puts("toXML self ", self.getName)
    # puts("toXML super ", super.getName)
    n_node = super(dom)
    n_node.add_element(getXMLFormatter.toXMLRef(dom))
    n_node
  end

  # Creates the object instance from an XML node
  def self.fromXML(n_node, pdoc)
    ret = super(n_node, pdoc)
    ret.class = PORISValue
    formatter = PORISValueFormatter.fromXMLRef(n_node)
    ret.setXMLFormatter(formatter)
    ret
  end

  def self.getRubyPrefix
    "vl"
  end

  def self.getRubyFuncParticle
    "Value"
  end


end

########################################################
# Base class for the PORISValue items which contain data
# Apart for selecting the PORISValue, user has also to define the data
# data examples are strings, integers, floats, dates, angles, etc.

class PORISValueData < PORISValue
  # Constructor, appends data and default data
  # initializers to the super() constructor
  def initialize(name, default_data)
    super(name)
    # The current data will be the default one at the beginning
    @__default_data = default_data
    @__data = default_data
  end

  # Data getter
  def getData
    @__data
  end

  # Data setter
  def setData(data)
    @__data = data
    @__data
  end

  # Default data getter
  def getDefaultData
    @__default_data
  end

  def setDefaultData(d)
    @__default_data = d
  end

  ########## XML related functions ########

  # The tag is "none" because this class shall never
  # be instanced directly
  def getXMLNodeName
    "none"
  end

  # The node type is 0 because this class shall never
  # be instanced directly
  def getXMLNodeType
    0
  end

  # Creates the object instance from an XML node
  def self.fromXML(n_node, pdoc)
    ret = super(n_node, pdoc)
    ret.class = PORISValueData
    formatter = PORISValueFormatter.fromXMLRef(n_node)
    ret.setXMLFormatter(formatter)
    ret
  end
end

#######################################

class PORISValueString < PORISValueData
  def initialize(name, default_data)
    super(name, default_data)
  end

  # Getter for the data, it is overloading
  # superclass one, but adding control over datatype
  def getData
    super
  end

  # Setter for the data, it is overloading
  # superclass one, but adding control over datatype
  def setData(data)
    super(data)
  end

  ########## XML related functions ########

  # getter for the XML tag name
  def getXMLNodeName
    "value-string"
  end

  # The node type is 6 for PORISValueStrings
  def getXMLNodeType
    6
  end

  # Dumps item to XML, uses super().toXML and
  # appends specific nodes for this class
  def toXML(dom)
    n_node = super(dom)

    defaultstringnode = REXML::Element.new("default-string")
    valueText = REXML::Text.new(getDefaultData)
    defaultstringnode.push(valueText)
    n_node.add_element(defaultstringnode)

    n_node
  end

  # Creates the object instance from an XML node
  def self.fromXML(n_node, pdoc)
    ret = super(n_node, pdoc)
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

    formatter = PORISValueFormatter.fromXMLRef(n_node)
    ret.setXMLFormatter(formatter)

    ret
  end
end

#######################################
# This class is a PORISValuestring for storing a filepath
# TODO: Develop this class
class PORISValueFilePath < PORISValueString
  def initialize(name, default_path, file_ext, file_desc)
    super(name, default_path)
    @file_ext = file_ext
    @file_desc = file_desc
  end

  ########## XML related functions ########

  # Getter for the XML tag name of this item
  def getXMLNodeName
    "value-file-path"
  end

  # Dumps item to XML, uses super().toXML and
  # appends specific nodes for this class
  def toXML(dom)
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

  # Creates the object instance from an XML node
  def self.fromXML(n_node, pdoc)
    ret = super(n_node, pdoc)
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

    formatter = PORISValueFormatter.fromXMLRef(n_node)
    ret.setXMLFormatter(formatter)

    ret
  end
end

#######################################
# This class stores Dates in a PORISValueString
# The difference is in the formatter, and
# in the XML
class PORISValueDate < PORISValueString
  def initialize(name, default_date, min_date, max_date)
    super(name, default_date)
    @min_date = min_date
    @max_date = max_date
  end

  ########## XML related functions ########

  # getter for the node type (overloading PORISValueString one)
  def getXMLNodeType
    5
  end

  # Getter for the XML tag name of this item
  def getXMLNodeName
    "value-date"
  end

  # getter for the XML tag name
  def getXMLFormatter
    PORISVALUEFORMATTER_DATE
  end

  # Dumps item to XML, uses super().toXML and
  # appends specific nodes for this class
  def toXML(dom)
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

  # Creates the object instance from an XML node
  def self.fromXML(n_node, pdoc)
    ret = super(n_node, pdoc)
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
        if t.node_type == REXML::Text::NodeType
          ret.min_date = t.value
        end
      end
    end

    formatter = PORISValueFormatter.fromXMLRef(n_node)
    ret.setXMLFormatter(formatter)

    ret
  end
end

#######################################
# This class allows Flat data in a PORISValue
class PORISValueFloat < PORISValueData
  # Constructor, overloads PORISValueData and ads min and max values
  def initialize(name, min, default_data, max)
    super(name, default_data)
    @__min = min
    @__max = max
  end

  # Data getter, uses super()'s, but restricts data type
  def getData
    super
  end

  # Data setter, checks range limits and restricts data type
  def setData(data)
    if data >= @__min && data <= @__max
      super(data)
    else
      getData
    end
  end

  # min getter
  def getMin
    @__min
  end

  # max getter
  def getMax
    @__max
  end

  ########## XML related functions ########

  # getter for the XML tag name
  def getXMLNodeName
    "value-double-range"
  end

  # getter for the formatter, overload super()'s
  def getXMLFormatter
    PORISVALUEFORMATTER_REAL
  end

  # Dumps item to XML, uses super().toXML and
  # appends specific nodes for this class
  def toXML(dom)
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

  # Creates the object instance from an XML node
  def self.fromXML(n_node, pdoc)
    ret = super(n_node, pdoc)
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

    formatter = PORISValueFormatter.fromXMLRef(n_node)
    ret.setXMLFormatter(formatter)

    ret
  end


  def getRubyConstructorString
    "#{self.class.name}.new('#{self.getRubyName}',#{self.getMin.to_s},#{self.getDefaultData.to_s},#{self.getMax.to_s})"
  end

end

#######################################
# This class implements the PORIS Modes
# PORISModes are used to restrict the eligible values for a PORISParam
# or to restrict the eligible submodes for a PORISSys

# As we need to use the class from the class itself, we will need to declare it in advance
class PORISMode < PORIS

  # Constructor, uses super's an adds the initialization of the eligible values and submodes
  def initialize(name)
    super(name)
    @values = {}
    @submodes = {}
    @default_value = nil
  end

  # Function to add a submode as eligible if current mode is active
  def addSubMode(m)
    @submodes[m.getId] = m
  end

  # Function to add a value as eligible if current mode is active
  def addValue(v)
    @values[v.getId] = v
    # If there is no default value of this mode, this will be
    # the first default value
    @default_value ||= v
  end

  # Setter for the default value
  def setDefaultValue(v)
    ret = @default_value
    if @values.key?(v.getId)
      # Setting the candidate as the default value
      @default_value = v
      ret = v
    else
      puts "Error, we can not set a default value #{v.getName} which is not in the list of values for this mode"
    end

    ret
  end

  # Getter for the default value
  def getDefaultValue
    @default_value
  end

  # Gets the most suitable value from the list of eligible ones.
  def getEligibleValue(v, current)
    if false
      if v
        puts "Entering in PORISMode getEligibleValue for mode #{getName} with the candidate #{v.getName}"
      else
        puts "Entering in PORISMode getEligibleValue for mode #{getName} with NULL candidate"
      end
      puts "Eligible values for this mode #{@values.keys}"
    end

    ret = nil
    if @values.key?(v.getId)
      # The candidate was found in the eligible ones
      ret = v
    else
      # The candidate was not found in the eligible ones
      if @values.key?(current.getId)
        # The current value was found in the eligible ones
        ret = current
      else
        # Neither the candidate nor the current values were eligible
        # We will return the default value, which is always eligible
        ret = @default_value
      end
    end

    ret
  end

  # Gets the most suitable submode from the list of eligible ones.
  def getEligibleSubMode(m, current)
    if false
      if m
        puts "Entering in PORISMode getEligibleSubMode with mode #{getName} with the candidate #{m.getName}"
      else
        puts "Entering in PORISMode getEligibleSubMode with mode #{getName} with NULL candidate"
      end
      puts "Eligible submodes: #{@submodes.keys}"
    end

    ret = nil
    if @submodes.key?(m.getId)
      # The candidate was found in the eligible ones
      ret = m
    else
      # The candidate was not found in the eligible ones
      if @submodes.key?(current.getId)
        # The current value was found in the eligible ones
        ret = current
      else
        # We will try to find the default mode for the PORISNode holding the candidate mode
        defmode = m.getParent.getDefaultMode
        if @submodes.key?(defmode.getId)
          ret = defmode
        else
          if false
            puts "None of the two given or the default one, I have only these keys #{@submodes.keys}"
          end

          # Neither the candidate nor the current submodes were eligible
          # Search the first submode with the same parent than the candidate
          # Iterating all submodes
          @submodes.each_value do |s|
            if false
              puts "#{s.getParent} #{s.getParent.getName}"
            end

            # Selecting the current submode only if it shares parent with candidate mode (m)
            if s.getParent == m.getParent
              ret = s
              # We found the first valid item to return
              # We shall exit breaking the loop
              break
            end
          end

          if ret.nil?
            # We finally did not find an eligible submode for this mode, for the PORISNode item which is parent of m
            # So we will return the UNKNOWN mode (the first one of the item)
            ret = m.getParent.getModes[m.getParent.getModes.keys.first]
          end
        end
      end
    end

    ret
  end

  # This function executes getEligibleValue() using an index to select the candidate
  # It also returns an index
  def getEligibleValueFromIdx(idx, current)
    vk = @values.keys[idx]
    result = getEligibleValue(@values[vk], current)
    result.nil? ? 0 : result.get_idx
  end

  # This function executes getEligibleSubMode() using an index to select the candidate
  # It also returns an index
  def get_eligible_sub_mode_from_idx(idx, current)
    mk = @submodes.keys[idx]
    result = get_eligible_sub_mode(@submodes[mk], current)
    result.nil? ? 0 : result.get_idx
  end

  # Getter for PORISMode destinations, which can be values or submodes
  def getDestinations
    ret = []
    @values.each_value { |v| ret << v }
    @submodes.each_value { |m| ret << m }
    ret
  end

  ########### XML related functions ########

  # Getter for the XML tag name of this item
  def getXMLNodeName
    "mode"
  end

  # Getter for the NodeType of this item
  def getXMLNodeType
    6
  end

  # Dumps the XML node from this PORISMode
  def toXML(dom)
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

  # Creates the object instance from an XML node
  def self.fromXML(n_node, pdoc)
    ret = super(n_node, pdoc)
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
        dest = PORIS.fromXMLRef(d, pdoc)
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
    ret
  end


  def self.getRubyPrefix
    "md"
  end

  def self.getRubyFuncParticle
    "Mode"
  end

  def toRuby
    # puts ("Entramos por aquí PARAM!!!")
    ret = super

    thisident = self.getRubyIdent

    @values.each do |myid, value|
      # puts("---------- Processing value #{value.getName} ---------")
      ret['destinations'] += "\t\t#{thisident}.addValue(#{value.getRubyIdent})\n"
    end
    @submodes.each do |myid, mode|
      # puts("---------- Processing value #{value.getName} ---------")
      ret['destinations'] += "\t\t#{thisident}.addSubMode(#{mode.getRubyIdent})\n"
    end

    return ret
  end

end


require 'rexml/document'

class PORISNode < PORIS
  # Constructor, creates the modes dictionary
  def initialize(name)
    super(name)
    # A PORISNode has a selected mode
    @selectedMode = nil
    @modes = {}
    @defaultMode = nil
  end

  # This function adds a mode to the current item
  # If there is no mode selected, the first one is
  # then considered as selected
  # Note: In our initialization we always add the UNKNOWN mode, without submodes, in the first position
  # this is the mechanism to disable a PORISNode (and all its subtree) when none of its submodes is eligible
  # NOTE: We should consider creating and adding the UNKNOWN mode in the constructor of the item, to don't let the user
  # violate the restriction written here, and add an alternative mode as the first one
  def addMode(m)
    @modes[m.getId] = m
    m.setParent(self)
    if @defaultMode.nil?
      # No mode was the default one, this one will be the default one
      @defaultMode = m
    end

    if @selectedMode.nil?
      # No mode was selected, this one will be the selected one
      @selectedMode = m
    end
  end

  def getModes
    @modes
  end

  # Getter for the default mode
  def getDefaultMode
    @defaultMode
  end

  # Setter for the default mode
  def setDefaultMode(m)
    # puts "Setting #{m.getName} as the default mode for #{getName}"
    if @modes.key?(m.getId)
      @defaultMode = m
    else
      puts "Error, #{m.getName} is not one of #{getName} modes"
    end
    @defaultMode
  end

  # Getter for the selected mode
  def getSelectedMode
    @selectedMode
  end

  # Setter for the selected mode, names as the act of select it
  def selectMode(m)
    # First we will get an eligible mode given our candidate
    ret = getEligibleMode(m)
    if ret.nil?
      if false
        puts "New eligible mode is NULL, so we have to set initialize the item to select the unknown mode"
      end
      ret = init
    end

    # If the mode has changed from the previous one, we shall propagate the change
    if ret != getSelectedMode
      if false
        puts "New mode is #{ret.getName}"
        if getSelectedMode
          puts " which is different from #{getSelectedMode.getName}"
        else
          puts " which is different from NULL"
        end
      end
      @selectedMode = ret
    end
    ret
  end

  # Setter for the selected mode using an index in the modes list, instead of using the mode itself
  def setModeFromIdx(idx)
    success = false
    # First we find the mode using the index
    mk = @modes.keys[idx]
    if mk
      result = selectMode(@modes[mk])
      if result
        # We succeeded in setting the mode using the index
        ret = result.get_idx
        success = true
      end
    end

    if !success
      # We could not set the mode using the idx
      # so we will initialize the item to select the UNKNOWN mode
      result = init
      # index for UNKNOWN is 0
      ret = 0
    end
    ret
  end

  # In case an item has not a selected mode, we can use this function to
  # select the first node
  # This function is normally only called internally, in reaction to
  # the circumstances of not having a selected mode when it is expected to have
  def init
    if false
      puts "----> Init #{getName}, mode list len: #{@modes.length}"
    end

    # We select the first mode of the list, and set it as the selected one
    firstMode = @modes[@modes.keys[0]]
    @selectedMode = firstMode
    if false
      puts "Init #{getName}: #{firstMode.getName}"
    end
    @selectedMode
  end

  # This function gets the selected mode of a PORISNode.  In case there is no selected mode
  # it forces the selection of the first one (UNKNOWN)
  def getNotNullSelectedMode
    if false
      puts "Entering in PORISNode getNotNullSelectedMode #{getName}"
    end

    ret = getSelectedMode
    if ret.nil?
      # There is no selected mode?  Then we will force the item initialization
      # This normally is not occurring, because from the first mode added, the item
      # has a selected one
      if false
        puts "- selectedMode is NULL"
      end

      # If there is no selected mode, we will initialize the item, which will select
      # the first mode as the active one (the first mode should be the UNKNOWN one)
      ret = init
    end

    if false
      puts "- selectedMode is now #{getSelectedMode.getName}"
    end
    # This looks like redundant, but it is not!!!
    selectMode(getSelectedMode)
  end

  # Gets the most suitable mode from the list of eligible ones for this item.
  # The argument is a candidate mode
  # if the candidate submode is eligible, then it will be returned
  # otherwise if the current submode is eligible, then it will be returned
  # if none of them both were returned, then the first eligible submode will be returned
  # This method plays an important role when changes are made at higher levels
  # of the PORIS tree, helping the subtree to arrive to a consistent state
  # propagating the change to eligible submodes in case the triggering changes
  # make the tree inconsistent.
  # Important: candidate(m) and current submodes shall belong to the same parent item (param or sys)
  # Take into account that submodes list is mixing modes of several items.
  # Finally, if there is no eligible submode belonging to the same parent that the m mode, the UNKNOWN mode
  # mode of m's parent.  UNKNOWN modes disables the parent item, and this is the method which
  # allows disabling parts of a PORIS subtree depending on the choices made at higher levels
  # TODO: Implement a check to confirm m and current are siblings
  def getEligibleMode(m)
    if false
      puts "Entering in PORISNode #{getName}.getEligibleMode(#{m.getName})"
    end

    ret = nil
    if @modes.key?(m.getId)
      # m is a mode of the current item
      if getParent.nil?
        # Current item has no parent, no restrictions to set m
        if false
          puts "Parent of #{getName} is null, no upper levels for restrictions, we can freely select m"
        end
        ret = m
      else
        # As this mode has a parent, we need to select a mode which is eligible in the context of the active mode at higher level
        # presenting the candidate as the candidate one, and the current mode as the alternative candidate
        if false
          puts "Searching within the #{getParent.getSelectedMode.submodes.length} submodes of #{getParent.getName}"
          puts "selectedMode #{getSelectedMode.getName} #{m.getName}"
        end
        ret = getParent.getSelectedMode.getEligibleSubMode(m, getSelectedMode)
      end

      if ret.nil?
        if false
          puts "ERROR, we were not lucky, there was no way of selecting a mode (NULL after search)"
        end
      else
        if false
          puts "Selected mode is #{ret.getName}"
        end
      end
    else
      puts "ERROR, trying to select #{m.getName} which is not a mode of #{getName}"
      # We then try to find a suitable mode depending on the choices done at higher level
      # we can not present m as a candidate, so we are presenting the current selected mode as candidate too
      if getParent.nil?
        # No parent, we can select the default mode
        ret = @defaultMode
      else
        ret = getParent.getSelectedMode.getEligibleSubMode(getSelectedMode, @defaultMode)
      end
    end
    ret
  end

  # Function to get an eligible mode using an index
  def getEligibleModeFromIdx(idx)
    ret = 0
    mk = @modes.keys[idx]
    if mk
      result = getEligibleMode(@submodes[mk])
      if result
        ret = result.get_idx
        success = true
      end
    end
    ret
  end

  # Get a mode from its Idx
  def getModeFromId(myid)
    ret = nil
    if @modes.key?(myid)
      ret = @modes[myid]
    end
    ret
  end

  # Get a mode from its name
  def getModeFromName(myname)
    ret = nil
    @modes.each do |myid, mode|
      if mode.getName == myname
        ret = mode
      end
    end
    ret
  end

  # Getter for the destinations list, including the modes
  def getDestinations
    ret = []
    @modes.each do |k, mode|
      ret << mode
    end
    ret
  end

  ########### XML related functions ########

  # Function to obtain the tag name for the current item
  # In XML all PORISNodes (no matter if they are systems or params)
  # are <sub-system>
  def getXMLNodeName
    "sub-system"
  end

  # Function to obtain the NodeType, overloading super's
  def getXMLNodeType
    4
  end

  # Dump XML from this item.  Appends default mode
  # to super's XML
  # TODO: At the moment we have not selected default modes
  def toXML(dom)
    '''
    <default-mode-id type="integer" nil="true"/>
    '''
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

  # Creates the object instance from an XML node
  def self.executeXMLParser(n_node, pdoc)
    typenode = n_node.getElementsByTagName("type")[0]
    t = typenode.firstChild.nodeValue
    if t == "PORISParam"
      return PORISParam.fromXML(n_node, pdoc)
    elsif t == "PORISSys"
      return PORISSys.fromXML(n_node, pdoc)
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
          return PORISSys.fromXML(n_node, pdoc)
        end
      end
    end
    # puts "Is a param"
    PORISParam.fromXML(n_node, pdoc)
  end

  def self.fromXML(n_node, pdoc)
    ret = super(PORISNode, PORISNode).fromXML(n_node, pdoc)
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
        dest = PORIS.fromXMLRef(d, pdoc)
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
    ret
  end

  def getRubyModeNamePrefix
    "#{self.getRubyName}Mode_"
  end


  def getRubyModeIdentPrefix
    "@#{PORISMode.getRubyPrefix}#{self.getRubyModeNamePrefix}"
  end

  def toRuby
    # puts ("Entramos por aquí PORISNode!!!")
    ret = super

    thisident = self.getRubyIdent
    thisModeIdentPrefix = self.getRubyModeIdentPrefix
    thisUnknownModeIdent = thisModeIdentPrefix+"UNKNOWN"
    thisUnknownModeName = self.getRubyModeNamePrefix+"UNKNOWN"

=begin

    @mdShuffleLinesMode_UNKNOWN = PORISMode.new("ShuffleLinesMode_UNKNOWN")
=end

    ret['constructor'] += "\t\t#{thisUnknownModeIdent} = PORISMode.new('#{thisUnknownModeName}')\n"

=begin
    self.addItem(@mdShuffleLinesMode_UNKNOWN)
    @mdShuffleLinesMode_UNKNOWN.setIdent("UNKM_ARC-0080")
    @mdShuffleLinesMode_UNKNOWN.setDescription("Unknown mode for ShuffleLines")
    @prShuffleLines.addMode(@mdShuffleLinesMode_UNKNOWN)
=end
    ret['constructor'] += "\t\tself.addItem(#{thisUnknownModeIdent})\n"
    ret['constructor'] += "\t\t#{thisUnknownModeIdent}.setIdent('UNKM_#{self.getIdent}')\n"
    ret['constructor'] += "\t\t#{thisUnknownModeIdent}.setDescription('Unknown mode for #{self.getRubyName}')\n"
    ret['destinations'] += "\t\t#{thisident}.addMode(#{thisUnknownModeIdent})\n"

=begin
    @mdAcquisitionMode_UNKNOWN.addSubMode(@mdShuffleLinesMode_UNKNOWN)
=end

    @modes.each do |myid, mode|
      m_ret = mode.toRuby
      ret['attributes'] += m_ret['attributes']
      ret['constructor'] += m_ret['constructor']
      ret['destinations'] += m_ret['destinations']
      ret['destinations'] += "\t\t#{thisident}.addMode(#{mode.getRubyIdent})\n"
    end

=begin

      @vlShuffleLines_Full_Range = PORISValueFloat.new("ShuffleLines_Full_Range",0,200,1000)
      @mdShuffleLinesMode_Normal = PORISMode.new("ShuffleLinesMode_Normal")
=end
=begin
      self.addItem(@vlShuffleLines_Full_Range)
      @vlShuffleLines_Full_Range.setIdent("ARC-0081")
      @vlShuffleLines_Full_Range.setDescription("")
      @prShuffleLines.addValue(@vlShuffleLines_Full_Range)
      self.addItem(@mdShuffleLinesMode_Normal)
      @mdShuffleLinesMode_Normal.setIdent("ARC-0082")
      @mdShuffleLinesMode_Normal.setDescription("")
      @prShuffleLines.addMode(@mdShuffleLinesMode_Normal)

      # Marcamos ShuffleLinesMode_Normal como elegible para AcquisitionMode_Shuffling
      @mdAcquisitionMode_Shuffling.addSubMode(@mdShuffleLinesMode_Normal)
      # Marcamos ShuffleLinesMode_Normal como elegible para AcquisitionMode_Engineering
      @mdAcquisitionMode_Engineering.addSubMode(@mdShuffleLinesMode_Normal)
      # Marcamos ShuffleLines_Full_Range como elegible para ShuffleLinesMode_Normal
      @mdShuffleLinesMode_Normal.addValue(@vlShuffleLines_Full_Range)
=end

=begin

    ## prParam ShuffleLines

    # ShuffleLines
    def get_ShuffleLinesNode
        @prShuffleLines
	end

    def get_ShuffleLines
        @prShuffleLines.getSelectedValue
	end

    def set_ShuffleLines(value)
        @prShuffleLines.setValue(value)
	end

    ## ShuffleLinesMode
    def get_ShuffleLinesMode
        @prShuffleLines.getSelectedMode
	end

    def set_ShuffleLinesMode(mode)
        @prShuffleLines.selectMode(mode)
	end

    ## prParam Acquisition

    # ShuffleLinesDouble
    def get_ShuffleLinesDouble
        v = @prShuffleLines.getSelectedValue
        v.class = PORISValueFloat
        v.getData
	end

    def set_ShuffleLinesDouble(data)
        @prShuffleLines.getSelectedValue.setData(data)
	end


=end
    ret['functions'] += "\tdef get_#{self.getRubyName}Mode\n"
    ret['functions'] += "\t\t#{thisident}.getSelectedMode\n"
    ret['functions'] += "\tend\n\n"

    ret['functions'] += "\tdef set_#{self.getRubyName}Mode(mode)\n"
    ret['functions'] += "\t\t#{thisident}.selectMode(mode)\n"
    ret['functions'] += "\tend\n\n"

    return ret
  end




end

##########################################
# This class implements a param, which is a PORISNode which has values
# and does not have subsystems or subparams
require 'rexml/document'

class PORISParam < PORISNode
  attr_reader :selected_value
  attr_accessor :values

  def initialize(name)
    super(name)
    @selected_value = nil
    @values = {}
  end

  def getSelectedValue
    @selected_value
  end

  def addValue(v)
    @values[v.getId] = v
    v.setParent(self)
    @selected_value = v if @selected_value.nil?
  end

  def setEligibleValue
    # puts "Entering PORISParam setEligibleValue #{name}" if false
    setValue(@selected_value)
  end

  def selectMode(m)
    # puts "Entering PORISParam #{name}.selectMode(#{m.name})" if false

    prev_mode = getSelectedMode
    ret = super(m)

    if ret != prev_mode
      setValue(getSelectedValue)
    end

    ret
  end

  def getValueFromId(myid)
    @values[myid]
  end

  def getValueFromName(myname)
    @values.values.find { |v| v.name == myname }
  end

  def getEligibleValue(v, current)
    if false
      if v.nil?
        puts "Entering PORISParam getEligibleValue #{name} with NULL value"
      else
        puts "Entering PORISParam getEligibleValue #{name} with value #{v.name}"
      end
      puts "*** #{name} #{getSelectedMode&.name} #{modes}"
    end

    if getSelectedMode.nil?
      # puts "- selected_mode is NULL" if false
      init
    end

    getSelectedMode.getEligibleValue(v, current)
  end

  def setValue(v)
    if false
      if v.nil?
        puts "Entering PORISParam setValue #{name} with NULL value"
      else
        puts "Entering PORISParam setValue #{name} with value #{v.name}"
      end
    end

    ret = getEligibleValue(v, @selected_value)
    if ret != @selected_value
      if @selected_value.is_a?(PORISValueData)
        data = @selected_value.get_data
        ret.set_data(data)
      end

      @selected_value = ret
    end

    ret
  end

  def getEligibleValueFromIdx(idx, current)
    ret = 0
    vk = @values.keys[idx]
    if vk
      result = getEligibleValue(@values[vk], current)
      if result
        ret = result.get_idx
      else
        puts "ERROR, we could not find an eligible value for #{name}"
      end
    else
      puts "ERROR, the index #{idx} is not valid for selecting a value for #{name}"
    end
    ret
  end

  def setValueFromIdx(idx)
    ret = 0
    vk = @values.keys[idx]
    if vk
      result = setValue(@values[vk])
      if result
        ret = result.get_idx
      else
        puts "ERROR, we could not set a value for #{name}"
      end
    else
      puts "ERROR, the index #{idx} is not valid for selecting a value for #{name}"
    end
    ret
  end

  def getDestinations
    super + @values.values
  end

  def getXMLType
    "PORISNode"
  end

  def getXMLNodeName
    "sub-system"
  end

  def toXML(doc)
    n_node = super(doc)
    childnode = REXML::Element.new("default-value-id")
    childnode.add_attribute("type", "integer")
    childnode.add_attribute("nil", "true")
    n_node.push(childnode)
    n_node
  end

  def self.fromXML(n_node, pdoc)
    ret = super(n_node, pdoc)
    ret.extend(PORISParam)
    ret.values = {}
    ret.instance_variable_set(:@selected_value, nil)

    destnode = n_node.elements["destinations"]
    destnode.elements.each do |d|
      dest = PORIS.fromXMLRef(d, pdoc)
      if dest && dest.is_a?(PORISValue)
        ret.addValue(dest)
      end
    end

    ret
  end


  def self.getRubyPrefix
    "pr"
  end

  def self.getRubyFuncParticle
    "Param"
  end

  def getRubyValueNamePrefix
    "#{self.getRubyName}_"
  end

  def getRubyValueIdentPrefix
    "@#{PORISValue.getRubyPrefix}#{self.getRubyValueNamePrefix}"
  end


  def toRuby
    # puts ("Entramos por aquí PARAM!!! " + self.getRubyIdent)
    ret = super
    thisident = self.getRubyIdent
    thisModeIdentPrefix = self.getRubyModeIdentPrefix
    thisUnknownModeIdent = thisModeIdentPrefix+"UNKNOWN"
    thisUnknownValueIdent = getRubyValueIdentPrefix+"UNKNOWN"
    thisUnknownValueName = self.getRubyValueNamePrefix+"UNKNOWN"


=begin
    @vlShuffleLines_UNKNOWN = PORISValue.new("ShuffleLines_UNKNOWN")
=end

    ret['constructor'] += "\t\t#{thisUnknownValueIdent} = PORISValue.new('#{thisUnknownValueName}')\n"

=begin
    self.addItem(@vlShuffleLines_UNKNOWN)
    @vlShuffleLines_UNKNOWN.setIdent("UNK_ARC-0080")
    @vlShuffleLines_UNKNOWN.setDescription("Unknown value for ShuffleLines")
    @prShuffleLines.addValue(@vlShuffleLines_UNKNOWN)
=end
    ret['constructor'] += "\t\tself.addItem(#{thisUnknownValueIdent})\n"
    ret['constructor'] += "\t\t#{thisUnknownValueIdent}.setIdent('UNK_#{self.getIdent}')\n"
    ret['constructor'] += "\t\t#{thisUnknownValueIdent}.setDescription('Unknown value for #{self.getRubyName}')\n"
    ret['destinations'] += "\t\t#{thisident}.addValue(#{thisUnknownValueIdent})\n"

=begin
    @mdShuffleLinesMode_UNKNOWN.addValue(@vlShuffleLines_UNKNOWN)
=end
    ret['destinations'] += "\t\t#{thisUnknownModeIdent}.addValue(#{thisUnknownValueIdent})\n"

    any_double = false
    @values.each do |myid, value|
      # puts("---------- Processing value #{value.getName} ---------")
      m_ret = value.toRuby
      ret['attributes'] += m_ret['attributes']
      ret['constructor'] += m_ret['constructor']
      ret['destinations'] += m_ret['destinations']
      ret['destinations'] += "\t\t#{thisident}.addValue(#{value.getRubyIdent})\n"
      if value.class == PORISValueFloat then
        any_double = true
      end
    end

    ret['functions'] += "\tdef get_#{self.getRubyName}\n"
    ret['functions'] += "\t\t#{thisident}.getSelectedValue\n"
    ret['functions'] += "\tend\n\n"

    ret['functions'] += "\tdef set_#{self.getRubyName}(value)\n"
    ret['functions'] += "\t\t#{thisident}.setValue(value)\n"
    ret['functions'] += "\tend\n\n"

    if any_double then
      ret['functions'] += "\tdef get_#{self.getRubyName}Double\n"
      ret['functions'] += "\t\tv = #{self.getRubyIdent}.getSelectedValue\n"
      ret['functions'] += "\t\tv.class = PORISValueFloat\n"
      ret['functions'] += "\t\tv.getData\n"
      ret['functions'] += "\tend\n\n"

      ret['functions'] += "\tdef set_#{self.getRubyName}Double(data)\n"
      ret['functions'] += "\t\t#{self.getRubyIdent}.getSelectedValue.setData(data)\n"
      ret['functions'] += "\tend\n\n"
    end

    return ret
  end









end
require 'rexml/document'

class PORISSys < PORISNode
  attr_accessor :params, :subsystems

  def initialize(name)
    super(name)
    @params = {}
    @subsystems = {}
  end

  def addParam(p)
    @params[p.getId] = p
    p.setParent(self)
  end

  def addSubsystem(s)
    @subsystems[s.getId] = s
    s.setParent(self)
  end

  def selectMode(m)
    if false
      puts "Entering in Sys selectMode for #{getName} with candidate mode #{m.getName}"
    end

    prev_mode = getSelectedMode
    ret = super(m)

    if ret != prev_mode
      @params.each_value do |p|
        p.getNotNullSelectedMode
      end

      @subsystems.each_value do |s|
        s.getNotNullSelectedMode
      end
    end

    if false
      if m == ret
        puts "Candidate mode successfully applied: #{ret.getName}"
      else
        if ret != prev_mode
          puts "Alternative eligible mode applied: #{ret.getName}"
        end
      end
      puts "Exiting PORISSys selectMode for #{getName} with candidate m=#{m.getName} and result =#{ret.getName}"
    end

    ret
  end

  def getParamFromId(myid)
    @params[myid]
  end

  def getParamFromName(myname)
    @params.each_value do |param|
      return param if param.getName == myname
    end
    nil
  end

  def getSubSystemFromId(myid)
    @subsystems[myid]
  end

  def getSubSystemFromName(myname)
    @subsystems.each_value do |subsystem|
      return subsystem if subsystem.getName == myname
    end
    nil
  end

  def getDescendantParamFromId(myid)
    ret = getParamFromId(myid)
    if ret.nil?
      @subsystems.each_value do |s|
        ret = s.getDescendantParamFromId(myid)
        break if ret
      end
    end
    ret
  end

  def getDescendantParamFromName(myname)
    ret = getParamFromName(myname)
    if ret.nil?
      @subsystems.each_value do |s|
        ret = s.getDescendantParamFromName(myname)
        break if ret
      end
    end
    ret
  end

  def getDescendantSysFromId(myid)
    ret = getSubSystemFromId(myid)
    if ret.nil?
      @subsystems.each_value do |s|
        ret = s.getDescendantSysFromId(myid)
        break if ret
      end
    end
    ret
  end

  def getDescendantSysFromName(myname)
    ret = getSubSystemFromName(myname)
    if ret.nil?
      @subsystems.each_value do |s|
        ret = s.getDescendantSysFromName(myname)
        break if ret
      end
    end
    ret
  end

  def getDestinations
    ret = super()
    ret.concat(@params.values)
    ret.concat(@subsystems.values)
    ret
  end

  def getXMLType
    "PORISNode"
  end

  def getXMLNodeName
    "sub-system"
  end

  def self.fromXML(n_node, pdoc)
    ret = super(n_node, pdoc)
    ret.class = PORISSys
    ret.params = {}
    ret.subsystems = {}

    destnode = n_node.elements["destinations"]
    destnode.each_element do |d|
      dest = PORIS.fromXMLRef(d, pdoc)
      if dest
        if dest.is_a?(PORISParam)
          ret.addParam(dest)
        elsif dest.is_a?(PORISSys)
          ret.addSubsystem(dest)
        end
      end
    end

    ret
  end

  def self.getRubyPrefix
    "sys"
  end

  def self.getRubyFuncParticle
    "Subsystem"
  end


  def toRuby
    # puts ("Entramos por aquí SYS!!!!")
    ret = super

    thisident = self.getRubyIdent
    thisModeIdentPrefix = self.getRubyModeIdentPrefix

    thisident = self.getRubyIdent
    thisUnknownModeIdent = thisModeIdentPrefix+"UNKNOWN"

    @params.each do |myid, param|
      # puts("---------- Processing param #{param.getName} ---------")
      m_ret = param.toRuby
      ret['attributes'] += m_ret['attributes']
      ret['constructor'] += m_ret['constructor']
      ret['destinations'] += m_ret['destinations']
      ret['destinations'] += "\t\t#{thisident}.addParam(#{param.getRubyIdent})\n"
      paramModeIdentPrefix = param.getRubyModeIdentPrefix
      paramUnknownModeIdent = paramModeIdentPrefix+"UNKNOWN"
      ret['destinations'] += "\t\t#{thisUnknownModeIdent}.addSubMode(#{paramUnknownModeIdent})\n"
      ret['functions'] += m_ret['functions']
    end


    @subsystems.each do |myid, ss|
      # puts("---------- Processing param #{ss.getName} ---------")
      m_ret = ss.toRuby
      ret['attributes'] += m_ret['attributes']
      ret['constructor'] += m_ret['constructor']
      ret['destinations'] += m_ret['destinations']
      ret['destinations'] += "\t\t#{thisident}.addSubsystem(#{ss.getRubyIdent})\n"
      ret['functions'] += m_ret['functions']
    end

    return ret
  end





end

class PORISDoc
  attr_accessor :id_counter, :item_dict, :root, :project_id

  def initialize(project_id)
    @id_counter = 1
    @item_dict = {}
    @root = nil
    @project_id = project_id
  end

  def setProjectId(i)
    @project_id = i
  end

  def getProjectId
    @project_id
  end

  def setRoot(r)
    @root = r
  end

  def getRoot
    @root
  end

  def getName
    @root.getName
  end

  def addItem(n, id = nil)
    # puts(n.getName)
    if id.nil?
      n.setId(@id_counter)
      @id_counter += 1
    else
      n.setId(id)
    end

    n.setDocument(self)
    @item_dict[n.getId.to_s] = n
  end

  def getItem(i)
    @item_dict[i.to_s]
  end

  def list_items
    puts @item_dict.size
    @item_dict.each_value do |n|
      puts "#{n.getId} #{n.getName}"
    end
  end

  def getConsistentReferencesSortedIdsList
    node_and_destinations = {}
    @item_dict.each_value do |n|
      node_and_destinations[n.getId.to_s] = n.getDestinations.map(&:getId).map(&:to_s)
    end

    finished = false
    ordered_list = []

    while !finished
      nodes_without_destinations = node_and_destinations.select { |_, destinations| destinations.empty? }.keys.map(&:to_i)
      ordered_list.concat(nodes_without_destinations)

      nodes_without_destinations.each do |id|
        node_and_destinations.delete(id.to_s)
      end

      node_and_destinations.each_value do |destinations|
        destinations.reject! { |d| nodes_without_destinations.include?(d.to_i) }
      end

      finished = node_and_destinations.empty?
    end

    ordered_list
  end

  def toXML
    xmlDocument = REXML::Document.new
    xmlInstr = xmlDocument.add_element('poris', 'id' => 'systems')

    consistent_list = getConsistentReferencesSortedIdsList
    consistent_list.each do |id|
      n = @item_dict[id.to_s]
      n_node = n.toXML(xmlDocument)
      xmlInstr.push(n_node) if n_node
    end
    #xmlDocument.add_element(xmlInstr)
    xmlDocument
  end

  def fromXML(doc)
    ret = false
    rootnode = doc.root
    if rootnode && rootnode.name == "poris"
      rootnode.elements.each do |ch|
        case ch.name
        when "poris-mode"
        when "mode"
          md = PORISMode.fromXML(ch, self)
        when "poris-node"
        when "sub-system"
          md = PORISNode.executeXMLParser(ch, self)
        when "poris-value"
        when "value"
          md = PORISValue.fromXML(ch, self)
        when "poris-value-float"
        when "value-double-range"
          md = PORISValueFloat.fromXML(ch, self)
        when "poris-sys"
          md = PORISSys.fromXML(ch, self)
        when "poris-param"
          md = PORISParam.fromXML(ch, self)
        when "poris-value-string"
        when "value-string"
          md = PORISValueString.fromXML(ch, self)
        when "poris-value-date"
        when "value-date"
          md = PORISValueDate.fromXML(ch, self)
        when "poris-value-file-path"
        when "value-file-path"
          md = PORISValueFilePath.fromXML(ch, self)
        end
      end
    end

    ret
  end

  def toRuby
    rootNodeCode = self.root.toRuby

    finalcode = "require_relative 'PORIS'\n\n"

    finalcode += "class #{self.root.getRubyName}PORIS < PORISDoc\n"
    finalcode += rootNodeCode['attributes']
    finalcode += "\tdef initialize(project_id)\n"
    finalcode += "\t\tsuper(project_id)\n"
    finalcode += rootNodeCode['constructor']
    finalcode += "\t\tself.setRoot(#{self.root.getRubyIdent})\n"
    finalcode += rootNodeCode['destinations']
    finalcode += "\tend\n"
    finalcode += rootNodeCode['functions']
    finalcode += "end\n\n"

    finalcode += "thismodel = #{self.root.getRubyName}PORIS.new(#{self.getProjectId})\n"


    return finalcode

  end
end
