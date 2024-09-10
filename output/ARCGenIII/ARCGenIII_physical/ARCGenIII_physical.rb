require_relative 'ARCGenIII'
require 'rexml/document'

class ARCGenIII_physical < ARCGenIIIPORIS
  # Go to ARCGengIIIPORIS.rb, navigate to the ##### Action triggers ##### section
  # which is normally at the bottom of the class, and copy here the methods
  # to start overriding them, in order to convert the virtual device into a physical one
  # Once this class has any content, remove the pass statement
end

thismodel = ARCGenIII_physical.new(13)

puts "Let's test our model #{thismodel.getRoot.getName}"
puts ""
puts "Initial mode is #{thismodel.getRoot.getSelectedMode.getName}"
puts "Initial Binning mode is #{thismodel.get_BinningNode.getSelectedMode.getName}"
puts "Initial binning value is #{thismodel.get_BinningNode.getSelectedValue.getName}"
puts ""

puts "----- BEGIN --------- XML dump of the model ------------------"
puts ""

dom = thismodel.toXML

pretty_xml_as_string = dom.to_s
puts "----- BEGIN --------- XML dump of the model ------------------"
puts pretty_xml_as_string
puts ""
puts "-----  END  --------- XML dump of the model ------------------"

puts "Let's parse"

othermodel = PORISDoc.new(2)
othermodel.fromXML(dom)

# puts "Let's dump"
dom2 = othermodel.toXML
pretty_xml_as_string = dom2.to_s
puts pretty_xml_as_string

puts ""

thismodel.set_arc_gen_iii_mode(thismodel.md_arc_gen_iii_mode_real)
puts "Current mode is #{thismodel.getRoot.getSelectedMode.getName}"
puts "Current Binning mode is #{thismodel.pr_binning.getSelectedMode.getName}"
puts "Current binning value is #{thismodel.pr_binning.getSelectedValue.getName}"
puts ""
puts "We will add 2x1 to the Binnning_1x1 mode"
binning1x1mode = thismodel.pr_binning.getSelectedMode
binning1x1mode.addValue(thismodel.vl_binning_2x1)

thismodel.set_arc_gen_iii_mode(thismodel.md_arc_gen_iii_mode_unknown)
puts "Current mode is #{thismodel.getRoot.getSelectedMode.getName}"
puts "Current Binning mode is #{thismodel.pr_binning.getSelectedMode.getName}"
puts "After change, Current binning value is #{thismodel.pr_binning.getSelectedValue.getName}"

thismodel.set_arc_gen_iii_mode(thismodel.md_arc_gen_iii_mode_real)
puts "Current mode is #{thismodel.getRoot.getSelectedMode.getName}"
puts "Current Binning mode is #{thismodel.pr_binning.getSelectedMode.getName}"
puts "Current binning value is #{thismodel.pr_binning.getSelectedValue.getName}"

puts "We will select 2x1 as the default value for the Binnning_1x1 mode"
binning1x1mode.set_default_value(thismodel.vl_binning_2x1)

thismodel.set_arc_gen_iii_mode(thismodel.md_arc_gen_iii_mode_unknown)
puts "Current mode is #{thismodel.getRoot.getSelectedMode.getName}"
puts "Current Binning mode is #{thismodel.pr_binning.getSelectedMode.getName}"
puts "After change, Current binning value is #{thismodel.pr_binning.getSelectedValue.getName}"

thismodel.set_arc_gen_iii_mode(thismodel.md_arc_gen_iii_mode_real)
puts "Current mode is #{thismodel.getRoot.getSelectedMode.getName}"
puts "Current Binning mode is #{thismodel.pr_binning.getSelectedMode.getName}"
puts "Current binning value is #{thismodel.pr_binning.getSelectedValue.getName}"
puts "Current Acquisition mode is #{thismodel.sys_acquisition.getSelectedMode.getName}"

puts "We will select NormalWindow as the default acquisition mode"
thismodel.sys_acquisition.set_default_mode(thismodel.md_acquisition_mode_normal_window)

thismodel.set_arc_gen_iii_mode(thismodel.md_arc_gen_iii_mode_unknown)
puts "Current mode is #{thismodel.getRoot.getSelectedMode.getName}"
puts "Current Binning mode is #{thismodel.pr_binning.getSelectedMode.getName}"
puts "After change, Current binning value is #{thismodel.pr_binning.getSelectedValue.getName}"

thismodel.set_arc_gen_iii_mode(thismodel.md_arc_gen_iii_mode_real)
puts "Current mode is #{thismodel.getRoot.getSelectedMode.getName}"
puts "Current Binning mode is #{thismodel.pr_binning.getSelectedMode.getName}"
puts "Current binning value is #{thismodel.pr_binning.getSelectedValue.getName}"
puts "Current Acquisition mode is #{thismodel.sys_acquisition.getSelectedMode.getName}"

puts ""

puts "----- BEGIN --------- XML dump of the model ------------------"
puts ""

dom = thismodel.toXML
pretty_xml_as_string = dom.to_s
puts pretty_xml_as_string
puts ""
puts "-----  END  --------- XML dump of the model ------------------"

puts ""

require 'time'
require 'tzinfo'

x = Time.now.utc
puts x
mystring = PORISVALUEFORMATTER_DATE.getString(x)
puts mystring
mydate = PORISVALUEFORMATTER_DATE.getValue(mystring)
puts mydate
mystring = PORISVALUEFORMATTER_DATE.getString(mydate)
puts mystring

tz = TZInfo::Timezone.get('US/Pacific')
x = tz.utc_to_local(x)
puts x
mystring = PORISVALUEFORMATTER_DATE.getString(x)
puts mystring
mydate = PORISVALUEFORMATTER_DATE.getValue(mystring)
puts mydate
mystring = PORISVALUEFORMATTER_DATE.getString(mydate)
puts mystring
