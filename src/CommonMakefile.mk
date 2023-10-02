## Hossein Moein
## August 29 2023

LOCAL_LIB_DIR = ../lib/$(BUILD_PLATFORM)
LOCAL_BIN_DIR = ../bin/$(BUILD_PLATFORM)
LOCAL_OBJ_DIR = ../obj/$(BUILD_PLATFORM)
LOCAL_INCLUDE_DIR = ../include
PROJECT_LIB_DIR = ../../lib/$(BUILD_PLATFORM)
PROJECT_INCLUDE_DIR = ../../include

# -----------------------------------------------------------------------------

SRCS = ../test/allocator_tester.cc

HEADERS = $(LOCAL_INCLUDE_DIR)/Cougar/AlignedAllocator.h \
          $(LOCAL_INCLUDE_DIR)/Cougar/FixedSizeAllocator.h

LIB_NAME =
TARGET_LIB =

TARGETS += $(LOCAL_BIN_DIR)/allocator_tester

# -----------------------------------------------------------------------------

LFLAGS += -Bstatic -L$(LOCAL_LIB_DIR) -L$(PROJECT_LIB_DIR)

LIBS = $(LFLAGS) $(PLATFORM_LIBS)
INCLUDES += -I. -I$(LOCAL_INCLUDE_DIR) -I$(PROJECT_INCLUDE_DIR)
DEFINES = -Wall -D_REENTRANT -DHMTHRP_HAVE_CLOCK_GETTIME \
          -DP_THREADS -D_POSIX_PTHREAD_SEMANTICS -DDMS_$(BUILD_DEFINE)__

# -----------------------------------------------------------------------------

# object file
#
LIB_OBJS =

# -----------------------------------------------------------------------------

# set up C++ suffixes and relationship between .cc and .o files
#
.SUFFIXES: .cc

$(LOCAL_OBJ_DIR)/%.o: %.cc
	$(CXX) $(CXXFLAGS) -c $< -o $@
$(LOCAL_OBJ_DIR)/%.o: ../benchmarks/%.cc
	$(CXX) $(CXXFLAGS) -c $< -o $@
$(LOCAL_OBJ_DIR)/%.o: ../examples/%.cc
	$(CXX) $(CXXFLAGS) -c $< -o $@
$(LOCAL_OBJ_DIR)/%.o: ../test/%.cc
	$(CXX) $(CXXFLAGS) -c $< -o $@

.cc :
	$(CXX) $(CXXFLAGS) $< -o $@ -lm $(TLIB) -lg++

# -----------------------------------------------------------------------------

all: PRE_BUILD $(TARGETS)

PRE_BUILD:
	mkdir -p $(LOCAL_LIB_DIR)
	mkdir -p $(LOCAL_BIN_DIR)
	mkdir -p $(LOCAL_OBJ_DIR)
	mkdir -p $(PROJECT_LIB_DIR)
	mkdir -p $(PROJECT_INCLUDE_DIR)/Cougar

$(TARGET_LIB):

ALLOCATOR_TESTER_OBJ = $(LOCAL_OBJ_DIR)/allocator_tester.o
$(LOCAL_BIN_DIR)/allocator_tester: $(TARGET_LIB) $(ALLOCATOR_TESTER_OBJ)
	$(CXX) -o $@ $(ALLOCATOR_TESTER_OBJ) $(LIBS)

# -----------------------------------------------------------------------------

depend:
	makedepend $(CXXFLAGS) -Y $(SRCS)

clean:
	rm -f $(LIB_OBJS) $(TARGETS) $(ALLOCATOR_TESTER_OBJ)

clobber:
	rm -f $(LIB_OBJS) $(TARGETS) $(ALLOCATOR_TESTER_OBJ)

install_hdr:
	cp -rpf $(LOCAL_INCLUDE_DIR)/* $(PROJECT_INCLUDE_DIR)/.

# -----------------------------------------------------------------------------

## Local Variables:
## mode:Makefile
## tab-width:4
## End:
