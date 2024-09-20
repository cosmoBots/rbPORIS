require "date"
require "tzinfo"

debug = false

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
  attr_accessor :virtual
  # Constructor, needs a name for the PORIS item
  def initialize(name)
    # puts "Creating PORIS instance name #{name}"
    # Public attributes
    @id = nil               # A numeric id for reference
    @ident = nil            # A text id for reference
    @description = nil      # A description of the item
    @document = nil
    @virtual = false
    # Private attributes
    @name = name           # name
    @parent = nil         # Parent node (if any)
    @labels = {}           # A dictionary of labels for this item, the scope_kind acts as a key
    @node_attributes = {}  # A dictionary of node attributes for this item, the content acts as a key

    # TODO: Move this to a patch
    @rm_id = nil
  end

  # TODO: Move this to a patch
  # rm_id getter
  def getRmId
    if @rm_id == nil then
      return @id
    else
      return @rm_id
    end
  end

  # TODO: Move this to a patch
  # id setter
  def setRmId(rmid)
    @rm_id = rmid
  end

  # TODO: Move this to a patch
  # id setter
  def setRmProjectIdent(rmprjid)
    @rm_project_ident = rmprjid
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
    return [self]
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

end

class PORISValue < PORIS

  def initialize(name)
    super(name)
    @__formatter = PORISVALUEFORMATTER_NIL
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

end

#######################################
# This class stores Dates in a PORISValueString
# The difference is in the formatter
class PORISValueDate < PORISValueString

  def initialize(name, default_date, min_date, max_date)
    super(name, default_date)
    @min_date = min_date
    @max_date = max_date
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

  # Submodes getter
  def getSubModes
    ret = {}
    if self.getParent != nil then
      if self != self.getParent.engineeringMode then
        ret = @submodes
      else
        self.getParent.getDestinations.each{|d|
          if d.is_a?(PORISNode) then
            ret = d.getModes.merge(ret)
          end
        }
      end
    end
    return ret
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
      puts "Eligible submodes: #{self.getSubModes.keys}"
    end

    ret = nil
    if self.getSubModes.key?(m.getId)
      # The candidate was found in the eligible ones
      ret = m
    else
      # The candidate was not found in the eligible ones
      if self.getSubModes.key?(current.getId)
        # The current value was found in the eligible ones
        ret = current
      else
        # We will try to find the default mode for the PORISNode holding the candidate mode
        defmode = m.getParent.getDefaultMode
        if self.getSubModes.key?(defmode.getId)
          ret = defmode
        else
          if false
            puts "None of the two given or the default one, I have only these keys #{self.getSubModes.keys}"
          end

          # Neither the candidate nor the current submodes were eligible
          # Search the first submode with the same parent than the candidate
          # Iterating all submodes
          self.getSubModes.each_value do |s|
            # puts "#{s.getParent} #{s.getParent.getName}"


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
    mk = self.getSubModes.keys[idx]
    result = get_eligible_sub_mode(self.getSubModes[mk], current)
    result.nil? ? 0 : result.get_idx
  end

  # Getter for PORISMode destinations, which can be values or submodes
  def getDestinations
    ret = []
    @values.each_value { |v| ret << v }
    self.getSubModes.each_value { |m| ret << m }
    ret
  end

end

class PORISNode < PORIS
  attr_reader :unknownMode
  attr_reader :engineeringMode
  # Constructor, creates the modes dictionary
  def initialize(name)
    super(name)
    # A PORISNode has a selected mode
    @selectedMode = nil
    @modes = {}
    @defaultMode = nil
    @unknownMode = nil
    @engineeringMode = nil
    @unknownMode = PORISMode.new("UNKNOWN")
    @unknownMode.virtual = true
    addMode(@unknownMode)
    @engineeringMode = PORISMode.new("UNRESTRICTED")
    @engineeringMode.virtual = true
    self.addMode(@engineeringMode)
  end

  # ID setter
  def setId(i)
    ret = super(i)

    prevIdx = self.unknownMode.getId
    ret += self.unknownMode.setId(i + ret.length)
    if prevIdx != nil then
      @modes.delete(prevIdx)
      @modes[self.unknownMode.getId] = self.unknownMode
    end

    prevIdx = self.engineeringMode.getId
    ret += self.engineeringMode.setId(i + ret.length)
    if prevIdx != nil then
      @modes.delete(prevIdx)
      @modes[self.engineeringMode.getId] = self.engineeringMode
    end

    return ret
  end

  def setIdent(ident)
    super(ident)
    self.engineeringMode.setIdent("UNRS-"+ident)
    self.unknownMode.setIdent("UNKM-"+ident)
  end

  # This function adds a mode to the current item
  # If there is no mode selected, the first one is
  # then considered as selected
  # Note: In our initialization we always add the UNKNOWN mode, without submodes, in the first position
  # this is the mechanism to disable a PORISNode (and all its subtree) when none of its submodes is eligible
  # NOTE: We should consider creating and adding the UNKNOWN mode in the constructor of the item, to don't let the user
  # violate the restriction written here, and add an alternative mode as the first one
  def addMode(m)
    if (@unknownMode == m) then
      index = -1
      m.setId(index)
    else
      if (@engineeringMode == m) then
        index = -3
        m.setId(index)
      else
        index = m.getId
        @modes[index] = m
      end
    end
    @modes[m.getId] = m
    # puts("Setting "+m.getName+" as children of "+self.getName)
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

    # puts "----> Init #{getName}, mode list len: #{@modes.length}"

    # We select the first mode of the list, and set it as the selected one
    @selectedMode = self.unknownMode
    # puts "Init #{getName}: #{@selectedMode.getName}"
    @selectedMode
  end

  # This function gets the selected mode of a PORISNode.  In case there is no selected mode
  # it forces the selection of the first one (UNKNOWN)
  def getNotNullSelectedMode
    # puts "Entering in PORISNode getNotNullSelectedMode #{getName}"

    ret = getSelectedMode
    if ret.nil?
      # There is no selected mode?  Then we will force the item initialization
      # This normally is not occurring, because from the first mode added, the item
      # has a selected one
      # puts "- selectedMode is NULL"

      # If there is no selected mode, we will initialize the item, which will select
      # the first mode as the active one (the first mode should be the UNKNOWN one)
      ret = init
    end

    # puts "- selectedMode is now #{getSelectedMode.getName}"

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

    # puts "Entering in PORISNode #{getName}.getEligibleMode(#{m.getName})"

    ret = nil
    if @modes.key?(m.getId)
      # m is a mode of the current item
      if getParent.nil?
        # Current item has no parent, no restrictions to set m
        # puts "Parent of #{getName} is null, no upper levels for restrictions, we can freely select m"
        ret = m
      else
        # As this mode has a parent, we need to select a mode which is eligible in the context of the active mode at higher level
        # presenting the candidate as the candidate one, and the current mode as the alternative candidate
        # puts "Searching within the #{getParent.getSelectedMode.submodes.length} submodes of #{getParent.getName}"
        # puts "selectedMode #{getSelectedMode.getName} #{m.getName}"
        ret = getParent.getSelectedMode.getEligibleSubMode(m, getSelectedMode)
      end

      if ret.nil?
        # puts "ERROR, we were not lucky, there was no way of selecting a mode (NULL after search)"
      else
        # puts "Selected mode is #{ret.getName}"
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
      result = getEligibleMode(self.getSubModes[mk])
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

end

##########################################
# This class implements a param, which is a PORISNode which has values
# and does not have subsystems or subparams

class PORISParam < PORISNode
  attr_reader :selected_value
  attr_accessor :values
  attr_accessor :unknownValue

  def initialize(name)
    super(name)
    @selected_value = nil
    @values = {}
    @unknownValue = nil
    @unknownValue = PORISValue.new("UNKNOWN")
    @unknownValue.virtual = true
    self.addValue(self.unknownValue)
    @unknownValue.setDocument(self.getDocument)
    @unknownMode.addValue(self.unknownValue)
  end

  def setIdent(ident)
    super(ident)
    self.unknownValue.setIdent("UNKV-"+ident)
    self.unknownMode.setIdent("UNKM-"+ident)
  end

  # ID setter
  def setId(i)
    ret = super(i)
    prevIdx = self.unknownValue.getId
    ret += self.unknownValue.setId(i + ret.length)
    if prevIdx != nil then
      self.values.delete(prevIdx)
      self.values[self.unknownValue.getId] = self.unknownValue
    end
    ret
  end

  def getSelectedValue
    @selected_value
  end

  def addValue(v)
    index = v.getId
    if v.getParent != nil then
      if v.getParent.unknownValue == v
        index = -2
      end
    end

    @values[index] = v
    v.setParent(self)
    self.engineeringMode.addValue(v)
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

    # if v.nil?
    #   puts "Entering PORISParam getEligibleValue #{name} with NULL value"
    # else
    #   puts "Entering PORISParam getEligibleValue #{name} with value #{v.name}"
    # end
    # puts "*** #{name} #{getSelectedMode&.name} #{modes}"

    if getSelectedMode.nil?
      # puts "- selected_mode is NULL" if false
      init
    end

    getSelectedMode.getEligibleValue(v, current)
  end

  def setValue(v)
    # if v.nil?
    #   puts "Entering PORISParam setValue #{name} with NULL value"
    # else
    #   puts "Entering PORISParam setValue #{name} with value #{v.name}"
    # end

    ret = getEligibleValue(v, @selected_value)
    if ret != @selected_value then
      if @selected_value.is_a?(PORISValueData)
        data = @selected_value.getData
        @selected_value.setData(data)
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

end


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
    # puts "Entering in Sys selectMode for #{getName} with candidate mode #{m.getName}"

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

    # if m == ret
    #   puts "Candidate mode successfully applied: #{ret.getName}"
    # else
    #   if ret != prev_mode
    #     puts "Alternative eligible mode applied: #{ret.getName}"
    #   end
    # end
    # puts "Exiting PORISSys selectMode for #{getName} with candidate m=#{m.getName} and result =#{ret.getName}"

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

end

class PORISDoc
  attr_accessor :id_counter, :item_dict, :root, :project_id

  def initialize(project_id)
    @id_counter = 1
    @item_dict = {}
    @root = nil
    @project_id = project_id
    # TODO: Move this to a patch
    @rm_id = nil
  end

  # TODO: Move this to a patch
  # rm_id getter
  def getRmId
    if @rm_id == nil then
      return "prj_" + @project_id.to_s
    else
      return @rm_id
    end
  end

  # TODO: Move this to a patch
  # id setter
  def setRmId(rmid)
    @rm_id = rmid
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

  def addItem(n)

    # puts(n.getName)
    new_id = @id_counter
    items_created = n.setId(@id_counter)
    @id_counter += items_created.length

    n.setDocument(self)
    items_created.each{ |i|
      @item_dict[i.getId.to_s] = i
      i.setDocument(self)
    }

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
        dests = n.getDestinations
        # print(n.getId.to_s + " " + n.getName + " " + dests.length.to_s+" [")
        node_and_destinations[n.getId.to_s] = []
        dests.each {|d|
          # print(d.getId.to_s + ":" +d.class.name+"|"+ d.getName+" ")
          node_and_destinations[n.getId.to_s] << d.getId.to_s
        }
        # print("]\n")
        # puts(n.getId.to_s+"|"+n.class.name+"|"+n.getName+":"+node_and_destinations[n.getId.to_s].to_s)
      # node_and_destinations[n.getId.to_s] = n.getDestinations.map(&:getId).map(&:to_s)
    end

    finished = false
    ordered_list = []

    count = 0
    last_length = node_and_destinations.length

    # puts ("---------------- LOOP STARTS HERE ----------------")

    while !finished
      # puts ("---------------- LOOP STARTS HERlast_lengthE ---"+count.to_s+"-------------")
      nodes_without_destinations = []
      node_and_destinations.keys.each {|k|
        if (node_and_destinations[k].length <= 0) then
          nodes_without_destinations << k
        end
      }
      # puts("len without destination: "+nodes_without_destinations.length.to_s)
      # puts(nodes_without_destinations.to_s)
      ordered_list.concat(nodes_without_destinations)
      #puts(ordered_list.to_s)
      #puts("lbefore:" + node_and_destinations.length.to_s)
      nodes_without_destinations.each do |id|
        # print("r"+id.to_s)
        node_and_destinations.delete(id.to_s)
      end
      # puts("lafter:" + node_and_destinations.length.to_s)
      # puts(node_and_destinations.keys.to_s)

      node_and_destinations.keys.each {|k|

        nodes_without_destinations.each{|n|

          if node_and_destinations[k].include?(n) then
            node_and_destinations[k].delete(n)
          end

        }
      }

      # puts("checking "+ node_and_destinations.length.to_s)
      new_length = node_and_destinations.length
      finished = (new_length <= 0)  || (new_length == last_length)
      if (new_length == last_length) then
        puts "ERROR! vector is not decreasing while reordering!!!!"
      end
      last_length = new_length
      count += 1
    end


    node_and_destinations.keys.each {|nk|
      n = @item_dict[nk]
      # puts(n.getId.to_s+"|"+n.getName+":"+node_and_destinations[nk].to_s)
    }

    ordered_list
  end

end
