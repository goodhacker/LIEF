if(__add_lief_git)
	return()
endif()
set(__add_lief_git ON)


execute_process(
  COMMAND ${GIT_EXECUTABLE} log -1 --format=%h
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
  OUTPUT_VARIABLE LIEF_COMMIT_HASH
  OUTPUT_STRIP_TRAILING_WHITESPACE
)

execute_process(
  COMMAND ${GIT_EXECUTABLE} rev-list --count ${LIEF_COMMIT_HASH}
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
  OUTPUT_VARIABLE LIEF_COMMIT_COUNT
  OUTPUT_STRIP_TRAILING_WHITESPACE
)

execute_process(
  COMMAND ${GIT_EXECUTABLE} describe --abbrev=0 --tags HEAD
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
  OUTPUT_VARIABLE LIEF_GIT_TAG
  OUTPUT_STRIP_TRAILING_WHITESPACE
)

execute_process(
  COMMAND ${GIT_EXECUTABLE} tag --list --points-at=HEAD
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
  OUTPUT_VARIABLE LIEF_GIT_COMMIT_TAGGED
  OUTPUT_STRIP_TRAILING_WHITESPACE
)

execute_process(
  COMMAND ${GIT_EXECUTABLE} rev-parse --abbrev-ref HEAD
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
  OUTPUT_VARIABLE LIEF_GIT_BRANCH
  OUTPUT_STRIP_TRAILING_WHITESPACE
)

string(COMPARE NOTEQUAL "${LIEF_GIT_COMMIT_TAGGED}" "" LIEF_IS_TAGGED)

STRING(REGEX MATCHALL "([0-9]+)" VERSION_STRING "${LIEF_GIT_TAG}")

message(STATUS "Tagged: ${LIEF_IS_TAGGED}")
if (${LIEF_IS_TAGGED})
  message(STATUS "Tag: ${LIEF_GIT_TAG}")
endif()
message(STATUS "Current branch: ${LIEF_GIT_BRANCH}")


list(GET VERSION_STRING 0 LIEF_VERSION_MAJOR)
list(GET VERSION_STRING 1 LIEF_VERSION_MINOR)
list(GET VERSION_STRING 2 LIEF_VERSION_PATCH)
