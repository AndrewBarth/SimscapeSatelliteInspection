###########################################################################
## Makefile generated for component 'rtwshared'. 
## 
## Makefile     : rtwshared.mk
## Generated on : Tue Apr 30 15:16:36 2024
## Final product: ./rtwshared.lib
## Product type : static library
## 
###########################################################################

###########################################################################
## MACROS
###########################################################################

# Macro Descriptions:
# PRODUCT_NAME            Name of the system to build
# MAKEFILE                Name of this makefile
# MODELLIB                Static library target

PRODUCT_NAME              = rtwshared
MAKEFILE                  = rtwshared.mk
MATLAB_ROOT               = $(HOME)/SimscapeSatelliteInspection/R2023a
MATLAB_BIN                = $(HOME)/SimscapeSatelliteInspection/R2023a/bin
MATLAB_ARCH_BIN           = $(MATLAB_BIN)/win64
START_DIR                 = $(HOME)/SimscapeSatelliteInspection/SimscapeSatelliteInspection
SOLVER                    = 
SOLVER_OBJ                = 
CLASSIC_INTERFACE         = 0
TGT_FCN_LIB               = ISO_C++11
MODEL_HAS_DYNAMICALLY_LOADED_SFCNS = 
RELATIVE_PATH_TO_ANCHOR   = ../../..
C_STANDARD_OPTS           = 
CPP_STANDARD_OPTS         = 
MODELLIB                  = rtwshared.lib

###########################################################################
## TOOLCHAIN SPECIFICATIONS
###########################################################################

# Toolchain Name:          GNU GCC Embedded Linux
# Supported Version(s):    
# ToolchainInfo Version:   2023a
# Specification Revision:  1.0
# 
#-------------------------------------------
# Macros assumed to be defined elsewhere
#-------------------------------------------

# LINUX_TGT_LIBS

#-----------
# MACROS
#-----------

CCOUTPUTFLAG   = --output_file=
LDOUTPUTFLAG   = --output_file=

TOOLCHAIN_SRCS = 
TOOLCHAIN_INCS = 
TOOLCHAIN_LIBS = -lm -lrt -lpthread -ldl -lm -lstdc++ -lrt -lpthread -ldl

#------------------------
# BUILD TOOL COMMANDS
#------------------------

# Assembler: GNU GCC Embedded Linux Assembler
AS = as

# C Compiler: GNU GCC Embedded Linux C Compiler
CC = gcc

# Linker: GNU GCC Embedded Linux Linker
LD = gcc

# C++ Compiler: GNU GCC Embedded Linux C++ Compiler
CPP = g++

# C++ Linker: GNU GCC Embedded Linux C++ Linker
CPP_LD = g++

# Archiver: GNU GCC Embedded Linux Archiver
AR = ar

# MEX Tool: MEX Tool
MEX_PATH = $(MATLAB_ARCH_BIN)
MEX = "$(MEX_PATH)/mex"

# Download: Download
DOWNLOAD =

# Execute: Execute
EXECUTE = $(PRODUCT)

# Builder: Make Tool
MAKE = make


#-------------------------
# Directives/Utilities
#-------------------------

ASDEBUG             = -g
AS_OUTPUT_FLAG      = -o
CDEBUG              = -g
C_OUTPUT_FLAG       = -o
LDDEBUG             = -g
OUTPUT_FLAG         = -o
CPPDEBUG            = -g
CPP_OUTPUT_FLAG     = -o
CPPLDDEBUG          = -g
OUTPUT_FLAG         = -o
ARDEBUG             =
STATICLIB_OUTPUT_FLAG =
MEX_DEBUG           = -g
RM                  =
ECHO                = echo
MV                  =
RUN                 =

#--------------------------------------
# "Faster Runs" Build Configuration
#--------------------------------------

ARFLAGS              = -r
ASFLAGS              = -c \
                       $(ASFLAGS_ADDITIONAL) \
                       $(INCLUDES)
CFLAGS               = -c \
                       -fPIC -MMD -MP -MF"$(@:%.o=%.dep)" -MT"$@"  \
                       -O2
CPPFLAGS             = -c \
                       -fPIC -MMD -MP -MF"$(@:%.o=%.dep)" -MT"$@"  \
                       -fpermissive  \
                       -O2 \
                       $(CUSTOM_CPP_FLAGS)
CPP_LDFLAGS          = -Wl,--no-as-needed
CPP_SHAREDLIB_LDFLAGS  = -shared  \
                         -Wl,--no-as-needed
DOWNLOAD_FLAGS       =
EXECUTE_FLAGS        =
LDFLAGS              = -Wl,--no-as-needed
MEX_CPPFLAGS         =
MEX_CPPLDFLAGS       =
MEX_CFLAGS           =
MEX_LDFLAGS          =
MAKE_FLAGS           = -j$(($(nproc)+1)) -Otarget -f $(MAKEFILE)
SHAREDLIB_LDFLAGS    = -shared  \
                       -Wl,--no-as-needed



###########################################################################
## OUTPUT INFO
###########################################################################

PRODUCT = ./rtwshared.lib
PRODUCT_TYPE = "static library"
BUILD_TYPE = "Model Reference Library"

###########################################################################
## INCLUDE PATHS
###########################################################################

INCLUDES_BUILDINFO = -I$(START_DIR) -I$(START_DIR)/slprj/ert/_sharedutils -I$(MATLAB_ROOT)/extern/include -I$(MATLAB_ROOT)/simulink/include -I$(MATLAB_ROOT)/rtw/c/src -I$(MATLAB_ROOT)/rtw/c/src/ext_mode/common -I$(MATLAB_ROOT)/rtw/c/ert -I$(MATLAB_ROOT)/extern/physmod/win64/lang/include -I$(MATLAB_ROOT)/extern/physmod/win64/mc/include -I$(MATLAB_ROOT)/extern/physmod/win64/pd/include -I$(MATLAB_ROOT)/extern/physmod/win64/pm/include -I$(MATLAB_ROOT)/extern/physmod/win64/pm_log/include -I$(MATLAB_ROOT)/extern/physmod/win64/pm_math/include -I$(MATLAB_ROOT)/extern/physmod/win64/sm/include -I$(MATLAB_ROOT)/extern/physmod/win64/sm_ssci/include -I$(MATLAB_ROOT)/extern/physmod/win64/ssc_comp/include -I$(MATLAB_ROOT)/extern/physmod/win64/ssc_core/include -I$(MATLAB_ROOT)/extern/physmod/win64/ssc_ds/include -I$(MATLAB_ROOT)/extern/physmod/win64/ssc_sli/include -I$(MATLAB_ROOT)/extern/physmod/win64/ssc_st/include

INCLUDES = $(INCLUDES_BUILDINFO)

###########################################################################
## DEFINES
###########################################################################

DEFINES_BUILD_ARGS = -DINTEGER_CODE=0
DEFINES_CUSTOM = 
DEFINES_OPTS = -DRT_MALLOC

DEFINES = $(DEFINES_BUILD_ARGS) $(DEFINES_CUSTOM) $(DEFINES_OPTS)

###########################################################################
## SOURCE FILES
###########################################################################

SRCS = $(START_DIR)/slprj/ert/_sharedutils/binsearch_u32d.cpp $(START_DIR)/slprj/ert/_sharedutils/plook_u32d_bincka.cpp $(START_DIR)/slprj/ert/_sharedutils/rtGetInf.cpp $(START_DIR)/slprj/ert/_sharedutils/rtGetNaN.cpp $(START_DIR)/slprj/ert/_sharedutils/rt_atan2d_snf.cpp $(START_DIR)/slprj/ert/_sharedutils/rt_backsubrr_dbl.c $(START_DIR)/slprj/ert/_sharedutils/rt_forwardsubrr_dbl.c $(START_DIR)/slprj/ert/_sharedutils/rt_lu_real.c $(START_DIR)/slprj/ert/_sharedutils/rt_matrixlib_dbl.c $(START_DIR)/slprj/ert/_sharedutils/rt_nonfinite.cpp $(START_DIR)/slprj/ert/_sharedutils/mldivide_ACSdhGwc.cpp $(START_DIR)/slprj/ert/_sharedutils/norm_NaTV2q6x.cpp $(START_DIR)/slprj/ert/_sharedutils/svd_7Gu53yjg.cpp $(START_DIR)/slprj/ert/_sharedutils/xaxpy_096mtG8b.cpp $(START_DIR)/slprj/ert/_sharedutils/xaxpy_DudtLs4O.cpp $(START_DIR)/slprj/ert/_sharedutils/xaxpy_WCvBBQc1.cpp $(START_DIR)/slprj/ert/_sharedutils/xaxpy_YEe4MFbz.cpp $(START_DIR)/slprj/ert/_sharedutils/xdotc_aDpSMZ8I.cpp $(START_DIR)/slprj/ert/_sharedutils/xdotc_hYsJecV0.cpp $(START_DIR)/slprj/ert/_sharedutils/xnrm2_Nr2corQP.cpp $(START_DIR)/slprj/ert/_sharedutils/xnrm2_wVr87xYl.cpp $(START_DIR)/slprj/ert/_sharedutils/xrot_PQNMFBbq.cpp $(START_DIR)/slprj/ert/_sharedutils/xrot_cHa9XTr0.cpp $(START_DIR)/slprj/ert/_sharedutils/xrotg_9ZHhnzNd.cpp $(START_DIR)/slprj/ert/_sharedutils/xswap_66dnrKDh.cpp $(START_DIR)/slprj/ert/_sharedutils/xswap_TC0Nd8XC.cpp $(START_DIR)/slprj/ert/_sharedutils/norm_zKsPGJdM.cpp $(START_DIR)/slprj/ert/_sharedutils/rt_powd_snf.cpp $(START_DIR)/slprj/ert/_sharedutils/svd_jndSmZ1I.cpp $(START_DIR)/slprj/ert/_sharedutils/xaxpy_fV4GNNBY.cpp $(START_DIR)/slprj/ert/_sharedutils/xnrm2_CZPEua86.cpp $(START_DIR)/slprj/ert/_sharedutils/xnrm2_ZLcWpb61.cpp

ALL_SRCS = $(SRCS)

###########################################################################
## OBJECTS
###########################################################################

OBJS = binsearch_u32d.cpp.o plook_u32d_bincka.cpp.o rtGetInf.cpp.o rtGetNaN.cpp.o rt_atan2d_snf.cpp.o rt_backsubrr_dbl.c.o rt_forwardsubrr_dbl.c.o rt_lu_real.c.o rt_matrixlib_dbl.c.o rt_nonfinite.cpp.o mldivide_ACSdhGwc.cpp.o norm_NaTV2q6x.cpp.o svd_7Gu53yjg.cpp.o xaxpy_096mtG8b.cpp.o xaxpy_DudtLs4O.cpp.o xaxpy_WCvBBQc1.cpp.o xaxpy_YEe4MFbz.cpp.o xdotc_aDpSMZ8I.cpp.o xdotc_hYsJecV0.cpp.o xnrm2_Nr2corQP.cpp.o xnrm2_wVr87xYl.cpp.o xrot_PQNMFBbq.cpp.o xrot_cHa9XTr0.cpp.o xrotg_9ZHhnzNd.cpp.o xswap_66dnrKDh.cpp.o xswap_TC0Nd8XC.cpp.o norm_zKsPGJdM.cpp.o rt_powd_snf.cpp.o svd_jndSmZ1I.cpp.o xaxpy_fV4GNNBY.cpp.o xnrm2_CZPEua86.cpp.o xnrm2_ZLcWpb61.cpp.o

ALL_OBJS = $(OBJS)

###########################################################################
## PREBUILT OBJECT FILES
###########################################################################

PREBUILT_OBJS = 

###########################################################################
## LIBRARIES
###########################################################################

LIBS = 

###########################################################################
## SYSTEM LIBRARIES
###########################################################################

SYSTEM_LIBS = 

###########################################################################
## ADDITIONAL TOOLCHAIN FLAGS
###########################################################################

#---------------
# C Compiler
#---------------

CFLAGS_BASIC = $(DEFINES) $(INCLUDES)

CFLAGS += $(CFLAGS_BASIC)

#-----------------
# C++ Compiler
#-----------------

CPPFLAGS_BASIC = $(DEFINES) $(INCLUDES)

CPPFLAGS += $(CPPFLAGS_BASIC)

###########################################################################
## INLINED COMMANDS
###########################################################################


DERIVED_SRCS = $(subst .o,.dep,$(OBJS))

build:

%.dep:



-include codertarget_assembly_flags.mk
-include *.dep


###########################################################################
## PHONY TARGETS
###########################################################################

.PHONY : all build clean info prebuild download execute


all : build
	echo "### Successfully generated all binary outputs."


build : prebuild $(PRODUCT)


prebuild : 


download : $(PRODUCT)


execute : download


###########################################################################
## FINAL TARGET
###########################################################################

#---------------------------------
# Create a static library         
#---------------------------------

$(PRODUCT) : $(OBJS) $(PREBUILT_OBJS)
	echo "### Creating static library "$(PRODUCT)" ..."
	$(AR) $(ARFLAGS)  $(PRODUCT) $(OBJS)
	echo "### Created: $(PRODUCT)"


###########################################################################
## INTERMEDIATE TARGETS
###########################################################################

#---------------------
# SOURCE-TO-OBJECT
#---------------------

%.c.o : %.c
	$(CC) $(CFLAGS) -o "$@" "$<"


%.s.o : %.s
	$(AS) $(ASFLAGS) -o "$@" "$<"


%.cpp.o : %.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.c.o : $(RELATIVE_PATH_TO_ANCHOR)/%.c
	$(CC) $(CFLAGS) -o "$@" "$<"


%.s.o : $(RELATIVE_PATH_TO_ANCHOR)/%.s
	$(AS) $(ASFLAGS) -o "$@" "$<"


%.cpp.o : $(RELATIVE_PATH_TO_ANCHOR)/%.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.c.o : $(START_DIR)/%.c
	$(CC) $(CFLAGS) -o "$@" "$<"


%.s.o : $(START_DIR)/%.s
	$(AS) $(ASFLAGS) -o "$@" "$<"


%.cpp.o : $(START_DIR)/%.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


binsearch_u32d.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/binsearch_u32d.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


plook_u32d_bincka.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/plook_u32d_bincka.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


rtGetInf.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/rtGetInf.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


rtGetNaN.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/rtGetNaN.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


rt_atan2d_snf.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/rt_atan2d_snf.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


rt_backsubrr_dbl.c.o : $(START_DIR)/slprj/ert/_sharedutils/rt_backsubrr_dbl.c
	$(CC) $(CFLAGS) -o "$@" "$<"


rt_forwardsubrr_dbl.c.o : $(START_DIR)/slprj/ert/_sharedutils/rt_forwardsubrr_dbl.c
	$(CC) $(CFLAGS) -o "$@" "$<"


rt_lu_real.c.o : $(START_DIR)/slprj/ert/_sharedutils/rt_lu_real.c
	$(CC) $(CFLAGS) -o "$@" "$<"


rt_matrixlib_dbl.c.o : $(START_DIR)/slprj/ert/_sharedutils/rt_matrixlib_dbl.c
	$(CC) $(CFLAGS) -o "$@" "$<"


rt_nonfinite.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/rt_nonfinite.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


mldivide_ACSdhGwc.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/mldivide_ACSdhGwc.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


norm_NaTV2q6x.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/norm_NaTV2q6x.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


svd_7Gu53yjg.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/svd_7Gu53yjg.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


xaxpy_096mtG8b.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/xaxpy_096mtG8b.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


xaxpy_DudtLs4O.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/xaxpy_DudtLs4O.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


xaxpy_WCvBBQc1.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/xaxpy_WCvBBQc1.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


xaxpy_YEe4MFbz.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/xaxpy_YEe4MFbz.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


xdotc_aDpSMZ8I.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/xdotc_aDpSMZ8I.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


xdotc_hYsJecV0.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/xdotc_hYsJecV0.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


xnrm2_Nr2corQP.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/xnrm2_Nr2corQP.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


xnrm2_wVr87xYl.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/xnrm2_wVr87xYl.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


xrot_PQNMFBbq.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/xrot_PQNMFBbq.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


xrot_cHa9XTr0.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/xrot_cHa9XTr0.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


xrotg_9ZHhnzNd.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/xrotg_9ZHhnzNd.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


xswap_66dnrKDh.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/xswap_66dnrKDh.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


xswap_TC0Nd8XC.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/xswap_TC0Nd8XC.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


norm_zKsPGJdM.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/norm_zKsPGJdM.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


rt_powd_snf.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/rt_powd_snf.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


svd_jndSmZ1I.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/svd_jndSmZ1I.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


xaxpy_fV4GNNBY.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/xaxpy_fV4GNNBY.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


xnrm2_CZPEua86.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/xnrm2_CZPEua86.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


xnrm2_ZLcWpb61.cpp.o : $(START_DIR)/slprj/ert/_sharedutils/xnrm2_ZLcWpb61.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


###########################################################################
## DEPENDENCIES
###########################################################################

$(ALL_OBJS) : 


###########################################################################
## MISCELLANEOUS TARGETS
###########################################################################

info : 
	echo "### PRODUCT = $(PRODUCT)"
	echo "### PRODUCT_TYPE = $(PRODUCT_TYPE)"
	echo "### BUILD_TYPE = $(BUILD_TYPE)"
	echo "### INCLUDES = $(INCLUDES)"
	echo "### DEFINES = $(DEFINES)"
	echo "### ALL_SRCS = $(ALL_SRCS)"
	echo "### ALL_OBJS = $(ALL_OBJS)"
	echo "### LIBS = $(LIBS)"
	echo "### MODELREF_LIBS = $(MODELREF_LIBS)"
	echo "### SYSTEM_LIBS = $(SYSTEM_LIBS)"
	echo "### TOOLCHAIN_LIBS = $(TOOLCHAIN_LIBS)"
	echo "### ASFLAGS = $(ASFLAGS)"
	echo "### CFLAGS = $(CFLAGS)"
	echo "### LDFLAGS = $(LDFLAGS)"
	echo "### SHAREDLIB_LDFLAGS = $(SHAREDLIB_LDFLAGS)"
	echo "### CPPFLAGS = $(CPPFLAGS)"
	echo "### CPP_LDFLAGS = $(CPP_LDFLAGS)"
	echo "### CPP_SHAREDLIB_LDFLAGS = $(CPP_SHAREDLIB_LDFLAGS)"
	echo "### ARFLAGS = $(ARFLAGS)"
	echo "### MEX_CFLAGS = $(MEX_CFLAGS)"
	echo "### MEX_CPPFLAGS = $(MEX_CPPFLAGS)"
	echo "### MEX_LDFLAGS = $(MEX_LDFLAGS)"
	echo "### MEX_CPPLDFLAGS = $(MEX_CPPLDFLAGS)"
	echo "### DOWNLOAD_FLAGS = $(DOWNLOAD_FLAGS)"
	echo "### EXECUTE_FLAGS = $(EXECUTE_FLAGS)"
	echo "### MAKE_FLAGS = $(MAKE_FLAGS)"


clean : 
	$(ECHO) "### Deleting all derived files ..."
	$(RM) $(PRODUCT)
	$(RM) $(ALL_OBJS)
	$(RM) *.c.dep
	$(RM) *.cpp.dep
	$(ECHO) "### Deleted all derived files."


