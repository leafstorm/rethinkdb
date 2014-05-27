
PROTOBUF_TEST_SRC_DIR = $(TOP)/test/protobuf_test
PROTOBUF_TEST_SRC_FILES = $(PROTOBUF_TEST_SRC_DIR)/main.cpp $(wildcard $(PROTOBUF_TEST_SRC_DIR)/.cpp) $(wildcard $(PROTOBUF_TEST_SRC_DIR)/.hpp)
PROTOBUF_TEST_BUILD_DIR = $(BUILD_DIR)/drivers/protobuf_test
PROTOBUF_TEST = $(PROTOBUF_TEST_BUILD_DIR)/protobuf_test

PROTOBUF_TEST_OBJ_FILES := $(PROTOBUF_TEST_BUILD_DIR)/rql.o $(PROTOBUF_TEST_BUILD_DIR)/connection.o $(PROTOBUF_TEST_BUILD_DIR)/main.o $(BUILD_DIR)/obj/rdb_protocol/ql2.pb.o

$(PROTOBUF_TEST_BUILD_DIR)/rql.o: $(PROTOBUF_INCLUDE_DEP) $(BUILD_DIR)/proto/rdb_protocol/ql2.pb.h $(PROTOBUF_TEST_SRC_FILES) | $(PROTOBUF_TEST_BUILD_DIR)/.
	$P CC
	$(CXX) $(CXXFLAGS) -std=gnu++0x -c $(PROTOBUF_TEST_SRC_DIR)/rethink-db-cpp-driver/rql.cpp $(PROTOBUF_INCLUDE) $(BOOST_INCLUDE) -I$(BUILD_DIR) -o $(PROTOBUF_TEST_BUILD_DIR)/rql.o

$(PROTOBUF_TEST_BUILD_DIR)/connection.o: $(PROTOBUF_INCLUDE_DEP) $(BOOST_INCLUDE_DEP) $(BUILD_DIR)/proto/rdb_protocol/ql2.pb.h $(PROTOBUF_TEST_SRC_FILES) | $(PROTOBUF_TEST_BUILD_DIR)/.
	$P CC
	$(CXX) $(CXXFLAGS) -std=gnu++0x -c $(PROTOBUF_TEST_SRC_DIR)/rethink-db-cpp-driver/connection.cpp $(PROTOBUF_INCLUDE) $(BOOST_INCLUDE) -I$(BUILD_DIR) -o $(PROTOBUF_TEST_BUILD_DIR)/connection.o

$(PROTOBUF_TEST_BUILD_DIR)/main.o: $(PROTOBUF_INCLUDE_DEP) $(BOOST_INCLUDE_DEP) $(BUILD_DIR)/proto/rdb_protocol/ql2.pb.h $(PROTOBUF_TEST_SRC_FILES) | $(PROTOBUF_TEST_BUILD_DIR)/.
	$P CC
	$(CXX) $(CXXFLAGS) -std=gnu++0x -c $(PROTOBUF_TEST_SRC_DIR)/main.cpp -I$(PROTOBUF_TEST_SRC_DIR)/rethink-db-cpp-driver $(PROTOBUF_INCLUDE) $(BOOST_INCLUDE) -I$(BUILD_DIR) -o $(PROTOBUF_TEST_BUILD_DIR)/main.o

$(PROTOBUF_TEST): $(PROTOBUF_TEST_OBJ_FILES) $(PROTOBUF_LIBS_DEP) $(BOOST_SYSTEM_LIBS_DEP)
	$P LD
	$(CXX) $(LDFLAGS) -std=gnu++0x -o $(PROTOBUF_TEST) $(PROTOBUF_LIBS) $(BOOST_SYSTEM_LIBS) $(BOOST_INCLUDE) $(PROTOBUF_TEST_OBJ_FILES)

.PHONY: protobuf-test-make
protobuf-test-make: $(PROTOBUF_TEST)

.PHONY: protobuf-test-clean
protobuf-test-clean:
	$P RM $(PROTOBUF_TEST_BUILD_DIR)
	rm -rf $(PROTOBUF_TEST_BUILD_DIR)
# should this also cause clean for protobufs c++?

.PHONY: protobuf-test-output-location
protobuf-test-output-location: $(PROTOBUF_TEST)
	 $(info protobuff-test executable location: $(realpath $(PROTOBUF_TEST)))