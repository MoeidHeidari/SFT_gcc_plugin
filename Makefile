#set the path of GXX executable files
GCCDIR=/home/andromeda/gcc-plugins/gcc-install/bin
#set the name of the plugin with exact path
PLUGIN_NAME=$(plugin_name)
#-----------------------------------------------------------
#set GXX flags
CXX       =  $(GCCDIR)/g++
CXXFLAGS  =  -Wall -fno-rtti
CXXFLAGS  += -Wno-literal-suffix
#find the GXX plugin path
PLUGINDIR =  $(shell $(CXX) -print-file-name=plugin)

#set GXX flags
CXXFLAGS  += -I$(PLUGINDIR)/include
#enable C++ support
LDFLAGS   =  -std=c++11
#-----------------------------------------------------------
# make command to build the plugin
all: $(PLUGIN_NAME).so
#make the shared library file
$(PLUGIN_NAME).so: $(PLUGIN_NAME).o
$(CXX) $(LDFLAGS) -shared -o $@ $<
#-----------------------------------------------------------
#make the plugin object file
$(PLUGIN_NAME).o:
$(CXX) $(CXXFLAGS) -fPIC -c -o $@ $<
#-----------------------------------------------------------
#make clean command to delete generated object and shared library files
clean:
rm -f $(PLUGINNAME).o $(PLUGINNAME).so
