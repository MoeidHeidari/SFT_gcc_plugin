# SFT_gcc_plugin

SFT is a gcc plugin to instrument manual prioritized Structure Field Transition to enhange data alignment toward the memory data sequence prefetchability enhancement and cache-line usage improvement.

## Installation

Use the Makefile to make the plugin

```bash

make plugin_name={plugin_name}
``
* plugin_name should be path specific
## Adjust the make file
```bash
#set the path of GXX executable files
GCCDIR={GCC executable files path}
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

```
**Example**  
GCCDIR=../../gccdir/installation/bin

## Usage

```C++
struct s1 {
    #pragma SFT A_1
    int x;
    #pragma SFT B_1
    int y;
};
struct s2
{
  #pragma SFT B_0
  int p;
};
struct s3
{
  #pragma SFT A_0
  double d;
  #pragma SFT C_0
  float j;
};
//...
struct s1 s_1[SIZE];
struct s2 s_2[SIZE];
struct s3 s_3[SIZE];
for(unsigned i=0;i<SIZE;++i)
  {
    s_3[i].d++;
    s_3[i].x=s_3[i].d+55;
    s_3[i].d++;
    s_1[i].x++;
    for(unsigned j=0;j<SIZE;++j)
        {s_3[j].d++;}
    s_3[i].d++;
  }
for(unsigned i=0;i<SIZE;++i)
  {
    s_2[i].p++;
    s_1[i].y++;
    s_1[i].y=s_1[i].y+32;

  }
for(unsigned i=0;i<SIZE/2;++i)
  {
  s_3[i].j=s_3[i].j+10;
  }
  //...
```
Hottest | #1 | #2 | #3 | #4 | #5 
--- | --- | --- | --- |--- |--- 
Field | d | x | p | y | j  

to use the plugin
```bash
$(GCCDIR)/g++ -fplugin=plugin_name.so -c test.cc -o test
```
you will get such a reordered structures
```C++
struct s1 {
   double d;
   int x;

};
struct s2
{
 int p;
 int y;
};
struct s3
{
 float j;
};
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

<p>
  <a href="https://www.paypal.me/AbdennourT/10">
      <img src="https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif" alt="paypal">
  </a>
</p>

## License
[GPLv3](https://choosealicense.com/licenses/gpl-3.0/)
