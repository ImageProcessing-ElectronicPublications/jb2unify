PROJECT = jb2unify
DJVULIBRE_PATH = src/djvulibre
CXX = g++ -O3 -std=c++0x
INCLUDES = -I$(DJVULIBRE_PATH) -I$(DJVULIBRE_PATH)/libdjvu -I$(DJVULIBRE_PATH)/tools -I$(DJVULIBRE_PATH)/tools/jb2cmp -Isrc
CXXFLAGS = $(INCLUDES) -DHAVE_CONFIG_H -pthread -DTHREADMODEL=POSIXTHREADS
LDFLAGS = -ldjvulibre
LN = $(CXX) -DHAVE_CONFIG_H
RM = rm -f


OBJ_FILES = src/jb2unify.o $(DJVULIBRE_PATH)/tools/jb2cmp/classify.o $(DJVULIBRE_PATH)/tools/jb2cmp/cuts.o $(DJVULIBRE_PATH)/tools/jb2cmp/frames.o $(DJVULIBRE_PATH)/tools/jb2cmp/patterns.o $(DJVULIBRE_PATH)/tools/jb2tune.o
BIN_FILES = $(PROJECT)

all: djvulibre_config $(BIN_FILES)

$(PROJECT): $(OBJ_FILES)
	$(LN) $^ $(LDFLAGS) -o $@

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

#src/jb2cmp/libjb2cmp.a: 
#	cd src/jb2cmp && ${MAKE}

djvulibre_config:
	cd src/djvulibre && ./autogen.sh

clean:
	$(RM) $(OBJ_FILES) $(BIN_FILES)
#	cd src/jb2cmp && ${MAKE} clean
