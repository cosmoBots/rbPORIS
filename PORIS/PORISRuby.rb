require_relative 'PORIS'

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

######### PORIS #################

module PORISRubyPatch
  def self.included(base)
    base.extend(ClassMethods)

    base.send(:include , InstanceMethods)

    base.class_eval do
    end
  end

  module ClassMethods

    def getRubyPrefix
      "ERROR_NODE"
    end

    def getRubyFuncParticle
      "ERROR_NODE"
    end

  end

  module InstanceMethods

    def getRubyName
      nametoidl(self.getName)
    end

    def getRubyAccessor
      "#{self.class.getRubyPrefix}#{self.getRubyName}"
    end

    def getRubyIdent
      # "#{getRubyAccessor}"
      "i#{self.getId}_#{self.class.getRubyPrefix}#{self.getRubyName}"
    end

    def getRubyConstructorString
      "#{self.class.name}.new('#{self.getRubyName}')"
    end

    def toRuby
      ret = {}

      if not self.virtual
        thisident = self.getRubyIdent

        ret["attributes"] = "\tattr_reader :#{self.getRubyAccessor}\n"

        ret["constructor"] = "\t\t#{thisident} = #{getRubyConstructorString}\n"
        # ret['constructor'] = ("Entramos por aquí PORIS!!!" + self.getName + " " + self.class.name + "\n")
        ret["constructor"] += "\t\tself.addItem(#{thisident})\n"
        ret["constructor"] += "\t\t#{thisident}.setIdent('#{self.getIdent}')\n"
        ret["constructor"] += "\t\t#{thisident}.setDescription('#{self.getDescription}')\n"

        ret["destinations"] = ""
        ret["foreigndests"] = ""

        ret["functions"] = "\t## #{self.class.getRubyPrefix}#{self.class.getRubyFuncParticle} #{self.getRubyName}\n\n"
        ret["functions"] += "\tdef get_#{self.getRubyName}Node\n"
        ret["functions"] += "\t\t#{thisident}\n"
        ret["functions"] += "\tend\n"
      else
        ret["attributes"] = ""
        ret["constructor"] = ""
        ret["destinations"] = ""
        ret["foreigndests"] = ""
        ret["functions"] = ""
      end
      return ret
    end
  end
end
PORIS.send(:include, PORISRubyPatch)


######### PORISValue #################

module PORISValueRubyPatch
  def self.included(base)
    base.extend(ClassMethods)

    base.send(:include , InstanceMethods)

    base.class_eval do
    end
  end

  module ClassMethods

    def getRubyPrefix
      "vl"
    end

    def getRubyFuncParticle
      "Value"
    end

  end

  module InstanceMethods

  end
end
PORISValue.send(:include, PORISValueRubyPatch)


######### PORISValueFloat #################

module PORISValueFloatRubyPatch
  def self.included(base)
    base.extend(ClassMethods)

    base.send(:include , InstanceMethods)

    base.class_eval do
    end
  end

  module ClassMethods
  end

  module InstanceMethods

    def getRubyConstructorString
      "#{self.class.name}.new('#{self.getRubyName}',#{self.getMin.to_s},#{self.getDefaultData.to_s},#{self.getMax.to_s})"
    end

  end
end
PORISValueFloat.send(:include, PORISValueFloatRubyPatch)

######### PORISMode #################

module PORISModeRubyPatch
  def self.included(base)
    base.extend(ClassMethods)

    base.send(:include , InstanceMethods)

    base.class_eval do
    end
  end

  module ClassMethods
    def getRubyPrefix
      "md"
    end

    def getRubyFuncParticle
      "Mode"
    end

  end

  module InstanceMethods
    def toRuby
      # puts ("Entramos por aquí PARAM!!!")
      ret = super

      if not self.virtual then
        thisident = self.getRubyIdent

        @values.each do |myid, value|
          if not value.virtual then
            # puts("---------- Processing value #{value.getName} ---------")
            ret["destinations"] += "\t\t#{thisident}.addValue(#{value.getRubyIdent})\n"
          end
        end
        self.getSubModes.each do |myid, mode|
          if not mode.virtual then
            # puts("---------- Processing value #{value.getName} ---------")
            ret["foreigndests"] += "\t\t#{thisident}.addSubMode(#{mode.getRubyIdent})\n"
          end
        end
      end
      return ret
    end

  end
end
PORISMode.send(:include, PORISModeRubyPatch)

######### PORISNode #################

module PORISNodeRubyPatch
  def self.included(base)
    base.extend(ClassMethods)

    base.send(:include , InstanceMethods)

    base.class_eval do
    end
  end

  module ClassMethods
  end

  module InstanceMethods

    def getRubyModeNamePrefix
      "#{self.getRubyName}Mode_"
    end

    def getRubyModeIdentPrefix
      "i#{self.getId}_#{PORISMode.getRubyPrefix}#{self.getRubyModeNamePrefix}"
    end

    def toRuby
      # puts ("Entramos por aquí PORISNode!!!")
      ret = super
      if not self.virtual then
        thisident = self.getRubyIdent
        thisModeIdentPrefix = self.getRubyModeIdentPrefix
        # thisUnknownModeIdent = thisModeIdentPrefix + "UNKNOWN"
        # thisUnknownModeName = self.getRubyModeNamePrefix + "UNKNOWN"

        # ret["constructor"] += "\t\t#{thisUnknownModeIdent} = PORISMode.new('#{thisUnknownModeName}')\n"

        # ret["constructor"] += "\t\tself.addItem(#{thisUnknownModeIdent})\n"
        # ret["constructor"] += "\t\t#{thisUnknownModeIdent}.setIdent('UNKM_#{self.getIdent}')\n"
        # ret["constructor"] += "\t\t#{thisUnknownModeIdent}.setDescription('Unknown mode for #{self.getRubyName}')\n"
        # ret["destinations"] += "\t\t#{thisident}.addMode(#{thisUnknownModeIdent})\n"

        @modes.each do |myid, mode|
          if not mode.virtual then
            m_ret = mode.toRuby
            ret["attributes"] += m_ret["attributes"]
            ret["constructor"] += m_ret["constructor"]
            ret["destinations"] += m_ret["destinations"]
            ret["destinations"] += "\t\t#{thisident}.addMode(#{mode.getRubyIdent})\n"
            ret["foreigndests"] += m_ret["foreigndests"]
          end
        end

        ret["functions"] += "\tdef get_#{self.getRubyName}Mode\n"
        ret["functions"] += "\t\t#{thisident}.getSelectedMode\n"
        ret["functions"] += "\tend\n\n"

        ret["functions"] += "\tdef set_#{self.getRubyName}Mode(mode)\n"
        ret["functions"] += "\t\t#{thisident}.selectMode(mode)\n"
        ret["functions"] += "\tend\n\n"
      end

      return ret
    end
  end
end
PORISNode.send(:include, PORISNodeRubyPatch)


######### PORISParam #################

module PORISParamRubyPatch
  def self.included(base)
    base.extend(ClassMethods)

    base.send(:include , InstanceMethods)

    base.class_eval do
    end
  end

  module ClassMethods

    def getRubyPrefix
      "pr"
    end

    def getRubyFuncParticle
      "Param"
    end

  end

  module InstanceMethods

    def getRubyValueNamePrefix
      "#{self.getRubyName}_"
    end

    def getRubyValueIdentPrefix
      "i#{self.getId}_#{PORISValue.getRubyPrefix}#{self.getRubyValueNamePrefix}"
    end

    def toRuby
      # puts ("Entramos por aquí PARAM!!! " + self.getRubyIdent)
      ret = super
      if not self.virtual then
        thisident = self.getRubyIdent
        thisModeIdentPrefix = self.getRubyModeIdentPrefix
        # thisUnknownModeIdent = thisModeIdentPrefix + "UNKNOWN"
        # thisUnknownValueIdent = getRubyValueIdentPrefix + "UNKNOWN"
        # thisUnknownValueName = self.getRubyValueNamePrefix + "UNKNOWN"

=begin
        @vlShuffleLines_UNKNOWN = PORISValue.new("ShuffleLines_UNKNOWN")
=end

        # ret["constructor"] += "\t\t#{thisUnknownValueIdent} = PORISValue.new('#{thisUnknownValueName}')\n"

=begin
        self.addItem(@vlShuffleLines_UNKNOWN)
        @vlShuffleLines_UNKNOWN.setIdent("UNK_ARC-0080")
        @vlShuffleLines_UNKNOWN.setDescription("Unknown value for ShuffleLines")
        @prShuffleLines.addValue(@vlShuffleLines_UNKNOWN)
=end
        # ret["constructor"] += "\t\tself.addItem(#{thisUnknownValueIdent})\n"
        # ret["constructor"] += "\t\t#{thisUnknownValueIdent}.setIdent('UNK_#{self.getIdent}')\n"
        # ret["constructor"] += "\t\t#{thisUnknownValueIdent}.setDescription('Unknown value for #{self.getRubyName}')\n"
        # ret["destinations"] += "\t\t#{thisident}.addValue(#{thisUnknownValueIdent})\n"

=begin
        @mdShuffleLinesMode_UNKNOWN.addValue(@vlShuffleLines_UNKNOWN)
=end
        # ret["destinations"] += "\t\t#{thisUnknownModeIdent}.addValue(#{thisUnknownValueIdent})\n"

        any_double = false
        @values.each do |myid, value|
          if not value.virtual then
            # puts("---------- Processing value #{value.getName} ---------")
            m_ret = value.toRuby
            ret["attributes"] += m_ret["attributes"]
            ret["constructor"] += m_ret["constructor"]
            ret["destinations"] += m_ret["destinations"]
            ret["destinations"] += "\t\t#{thisident}.addValue(#{value.getRubyIdent})\n"
            ret["foreigndests"] += m_ret["foreigndests"]
            if value.class == PORISValueFloat then
              any_double = true
            end
          end
        end

        ret["functions"] += "\tdef get_#{self.getRubyName}\n"
        ret["functions"] += "\t\t#{thisident}.getSelectedValue\n"
        ret["functions"] += "\tend\n\n"

        ret["functions"] += "\tdef set_#{self.getRubyName}(value)\n"
        ret["functions"] += "\t\t#{thisident}.setValue(value)\n"
        ret["functions"] += "\tend\n\n"

        if any_double then
          ret["functions"] += "\tdef get_#{self.getRubyName}Double\n"
          ret["functions"] += "\t\tv = #{self.getRubyIdent}.getSelectedValue\n"
          ret["functions"] += "\t\tv.class = PORISValueFloat\n"
          ret["functions"] += "\t\tv.getData\n"
          ret["functions"] += "\tend\n\n"

          ret["functions"] += "\tdef set_#{self.getRubyName}Double(data)\n"
          ret["functions"] += "\t\t#{self.getRubyIdent}.getSelectedValue.setData(data)\n"
          ret["functions"] += "\tend\n\n"
        end
      end
      return ret
    end
  end
end
PORISParam.send(:include, PORISParamRubyPatch)

######### PORISSys #################

module PORISSysRubyPatch
  def self.included(base)
    base.extend(ClassMethods)

    base.send(:include , InstanceMethods)

    base.class_eval do
    end
  end

  module ClassMethods

    def getRubyPrefix
      "sys"
    end

    def getRubyFuncParticle
      "Subsystem"
    end


  end

  module InstanceMethods

    def toRuby
      # puts ("Entramos por aquí SYS!!!!")
      ret = super
      if not self.virtual then
        thisident = self.getRubyIdent
        thisModeIdentPrefix = self.getRubyModeIdentPrefix

        thisident = self.getRubyIdent
        # thisUnknownModeIdent = thisModeIdentPrefix + "UNKNOWN"

        @params.each do |myid, param|
          # puts("---------- Processing param #{param.getName} ---------")
          m_ret = param.toRuby
          ret["attributes"] += m_ret["attributes"]
          ret["constructor"] += m_ret["constructor"]
          ret["destinations"] += m_ret["destinations"]
          ret["destinations"] += "\t\t#{thisident}.addParam(#{param.getRubyIdent})\n"
          ret["foreigndests"] += m_ret["foreigndests"]
          paramModeIdentPrefix = param.getRubyModeIdentPrefix
          # paramUnknownModeIdent = paramModeIdentPrefix + "UNKNOWN"
          # ret["foreigndess"] += "\t\t#{thisUnknownModeIdent}.addSubMode(#{paramUnknownModeIdent})\n"
          ret["functions"] += m_ret["functions"]
        end

        @subsystems.each do |myid, ss|
          # puts("---------- Processing param #{ss.getName} ---------")
          m_ret = ss.toRuby
          ret["attributes"] += m_ret["attributes"]
          ret["constructor"] += m_ret["constructor"]
          ret["destinations"] += m_ret["destinations"]
          ret["destinations"] += "\t\t#{thisident}.addSubsystem(#{ss.getRubyIdent})\n"
          ret["foreigndests"] += m_ret["foreigndests"]
          ret["functions"] += m_ret["functions"]
        end
      end
      return ret
    end
  end
end
PORISSys.send(:include, PORISSysRubyPatch)



######### PORISDoc #################

module PORISDocRubyPatch
  def self.included(base)
    base.extend(ClassMethods)

    base.send(:include , InstanceMethods)

    base.class_eval do
    end
  end

  module ClassMethods
  end

  module InstanceMethods

    def toRuby
      rootNodeCode = self.root.toRuby

      finalcode = "require_relative 'PORIS'\n\n"

      finalcode += "class #{self.root.getRubyName}PORIS < PORISDoc\n"
      # We remove the accessors to avoid nomenclature issues
      # finalcode += rootNodeCode['attributes']
      finalcode += "\tdef initialize(project_id)\n"
      finalcode += "\t\tsuper(project_id)\n"
      finalcode += rootNodeCode["constructor"]
      finalcode += "\t\tself.setRoot(#{self.root.getRubyIdent})\n"
      finalcode += rootNodeCode["destinations"]
      finalcode += rootNodeCode["foreigndests"]
      finalcode += "\tend\n"
      # We remove the functions to avoid nomenclature issues
      # finalcode += rootNodeCode['functions']
      finalcode += "end\n\n"

      finalcode += "thismodel = #{self.root.getRubyName}PORIS.new(#{self.getProjectId})\n"

      return finalcode
    end

  end
end
PORISDoc.send(:include, PORISDocRubyPatch)


def toRuby
  rootNodeCode = self.root.toRuby

  finalcode = "require_relative 'PORIS'\n\n"

  finalcode += "class #{self.root.getRubyName}PORIS < PORISDoc\n"
  # We remove the accessors to avoid nomenclature issues
  # finalcode += rootNodeCode['attributes']
  finalcode += "\tdef initialize(project_id)\n"
  finalcode += "\t\tsuper(project_id)\n"
  finalcode += rootNodeCode["constructor"]
  finalcode += "\t\tself.setRoot(#{self.root.getRubyIdent})\n"
  finalcode += rootNodeCode["destinations"]
  finalcode += rootNodeCode["foreigndests"]
  finalcode += "\tend\n"
  # We remove the functions to avoid nomenclature issues
  # finalcode += rootNodeCode['functions']
  finalcode += "end\n\n"

  finalcode += "thismodel = #{self.root.getRubyName}PORIS.new(#{self.getProjectId})\n"

  return finalcode
end

=begin
######### $C1 #################

module $C1RubyPatch
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
$C1.send(:include, $C1RubyPatch)
=end
