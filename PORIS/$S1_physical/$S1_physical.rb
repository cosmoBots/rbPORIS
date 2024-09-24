require_relative 'DEVICENAMEPORIS'

class DEVICENAME_physical < DEVICENAMEPORIS
    # Go to ARCGengIIIPORIS.rb, navigate to the ##### Action triggers ##### section
    # which is normally at the bottom of the class, and copy here the methods
    # to start overriding them, in order to convert the virtual device into a physical one
    # Once this class has any content, remove the pass clause
end

thismodel = DEVICENAME_physical.new(12)

puts("Let's test our model " + thismodel.getRoot.getName)
puts("Current mode is " + thismodel.getRoot.getSelectedMode.getName)
